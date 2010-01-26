---
layout: post
title: verbose erlang eunit example
published: true
---

I'm a big believer in tests that are easy to read and understand quickly. Tests should be simple and straightforward. When I started writing unit tests in Erlang, I found that the EUnit documentation only briefly mentioned titles. I was a bit confused about how all these testing styles fit together and wanted to publish what I eventually figured out for people trying to figure out EUnit for the first time. In this example, I also seperated the test modules from the implementation modules.

./tests/input_parser_tests.erl
{% highlight erlang %}
-module(input_parser_tests).
-include_lib("eunit/include/eunit.hrl").

parse_test_() ->
	{"Main entry point for parser process",
		fun() ->
			?assertEqual("test", input_parser:parse("test"))
		end
	}.

{% endhighlight %}

./src/input_parser.erl
{% highlight erlang %}
-module(input_parser).
-export([parse/1]).
-include_lib("eunit/include/eunit.hrl").

parse(Packet) ->
	Packet.	

{% endhighlight %}

This test doesn't really do anything, but is simplified to show the syntax of a single eunit test. The first thing to notice is that the test function name ends in an underscore. This is mandatory if you want to tell Erlang that the test function is returning a _test data tuple_ rather than an actual function to be executed. Inside the test function you have a tuple containing two terms: a title describing the operations of the test, and a closure function of the actual test itself. This closure will be executed by EUnit when the tests are run.

Now to run it, just fire up 'erl'...

{% highlight bash %}
erl -pa tests -pa ebin
{% endhighlight %}

...and do the following:

{% highlight erlang %}
1> input_parser:test().
 Test passed.
ok
2>
{% endhighlight %}

If you got lost or things aren't working, you can take a look at my first pass at setting up a [well structured erlang project](http://github.com/blakesmith/emud).
