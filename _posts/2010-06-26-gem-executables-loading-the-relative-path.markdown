---
title: gem executables loading the relative path
published: true
layout: post
---

In a common gem project structure, a simple layout might look like this:

<pre>
my_gem
`-> lib
  `-> my_gem.rb
  `-> my_gem
    `-> runner.rb
 -> bin
  `-> my_executable
</pre>

With an executable file in the bin folder, a common ruby idiom might
follow this pattern:

{% highlight ruby %}
#!/usr/bin/env ruby

require 'rubygems'
require 'my_gem'

MyGem::Runner.run!(ARGV)
{% endhighlight %}

This is great, we've deffered all of our run logic to a class inside of
our lib folder (in this case, runner.rb) which makes it easier to unit
test our code.

The dilema that this situation creates, is that by default Ruby will
load the my_gem classes from the default rubygems path instead of in the
folder relative to the executable. This means that everytime we update
our code, we have to rebuild the gem and reinstall it to smoke-test our
executable. Otherwise if we only change the code in our project
directory, when we run the executable that's located in our project
directory, it will still be loading the stale code in our rubygems path.

A great solution is to add this line before you require your gem:

{% highlight ruby %}
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
{% endhighlight %}

You can also use the shorthand variable $: as an alias for $LOAD_PATH.

So the final code would look like this:

{% highlight ruby %}
#!/usr/bin/env ruby
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require 'rubygems'
require 'my_gem'

MyProject::Runner.run!(ARGV)
{% endhighlight %}

A Ruby master would laugh at me for just realizing this pattern, but
what this means is that each time your executable is run, even from your
local project directory, it will always load the code that is relative
to the executable, which is exactly what you want.

Just a little tidbit I thought I'd pass on to ease the friction of those
developing executables in their gem projects.

