---
title: testing em-httprequest with webmock
published: true
layout: post
---

I've been [working on a project](https://github.com/blakesmith/flamethrower)
lately that is an EventMachine server that bridges [37signals
campfire](http://campfirenow.com/) with IRC. It does this by tapping into the
[Campfire API](http://developer.37signals.com/campfire/). My goal was to just
get basic message sending and receiving working before I started adding more
layers of complexity. This meant that for the first pass on
flamethrower, I used Net::HTTP to initiate http requests to the campfire API,
and tested those http calls using [Fakeweb](http://fakeweb.rubyforge.org/).
These tools were most familiar to me, so I started with them as a first step.

### problems

There are a few problems with this approach. One is that Net::HTTP is a blocking
HTTP library. This means that whenever an HTTP call needs to be made, the entire
rest of the server will halt and wait for the http request to complete (an
eternity when you're thinking in server response times). Since EventMachine is a
single threaded event loop, this effectively prevents the server from doing
anything else while we're waiting for the request to complete. We could put the
HTTP requests into a separate Thread, but this isn't really productive
considering we're already using an event-loop based architecture for everything
else.

The other problem with this approach is that Fakeweb is tied directly to
Net::HTTP. In fact, Fakeweb is essentially just a nice API that stubs
out Net::HTTP requests and responses.

So we need two changes, a different HTTP library, and a different framework to
test it with.

### em-httprequest

We're already using EventMachine, so why can't we make our HTTP calls async
inside our existing EventMachine loop? Thanks to
[EM-HttpRequest](https://github.com/igrigorik/em-http-request), we can!

Here's an example HTTP call that can be made with EM-HttpRequest:

{% highlight ruby %}
require 'eventmachine'
require 'em-http-request'

class ExampleHttp
  attr_reader :response

  def initialize
    @response = {}
  end

  def run_and_fetch
    EventMachine.run do
      fetch_status
    end
  end

  def fetch_status
    http = EventMachine::HttpRequest
      .new('https://api.groupon.com/status')
      .get :timeout => 10

    http.callback do
      @response[:status] = http.response_header.status
      @response[:header] = http.response_header
      @response[:body] = http.response
      EventMachine.stop
    end
  end
end
{% endhighlight %}

So we've got a working HTTP call, but how can we test it?

### webmock

Enter [webmock](https://github.com/bblimke/webmock)! Webmock is awesome because
it doesn't necessarily tie you to any specific Ruby HTTP library. It provides
adapters for a bunch of HTTP libraries, including Net::HTTP as well as
EM::HttpRequest. Switching your HTTP library shouldn't prompt you to have to
switch your tests (too much), so this is a big win!


From the example above, here's a test that might exercise that call:

{% highlight ruby %}
require 'example_http'
require 'webmock/rspec'

describe ExampleHttp do
  before do
    @body = "{\"message\":null,\"versions\":[{\"version\":1,\"baseUrl\":\"https://www.groupon.com/api/v1\"},{\"version\":2,\"baseUrl\":\"https://api.groupon.com/v2\"}]}"
    @example_http = ExampleHttp.new
  end

  it "returns the right json from the body of the http request" do
    stub_request(:get, 'https://api.groupon.com/status')
      .to_return(:body => @body, :status => 200)
    EM.run_block { @example_http.fetch_status }
    @example_http.response[:body].should == @body
  end
end
{% endhighlight %}

The key part to note about this test is this line:

{% highlight ruby %}
  EM.run_block { @example_http.fetch_status }
{% endhighlight %}

EM.run_block is cool because it allows us to test the method that's making the
HTTP requests without having to worry about keeping our EventMachine loop
running for the tests. EM.run_block will start the Event loop, run what's in the
block, and then terminate the EventMachine loop. This was an important thing I
discovered when making HTTP requests while
also running an EM server loop that will never terminate.

### conclusions

- Making blocking calls in an EventMachine or any other event based server is
  not good. **NEVER EVER BLOCK on the main thread**
- Changing our underlying HTTP library shouldn't change our tests much (if at
  all). This makes webmock awesome - I'll be avoiding FakeWeb from now on.

If you're looking for more detailed examples, take a look at my
[Flamethrower](https://github.com/blakesmith/flamethrower) gem on github.
