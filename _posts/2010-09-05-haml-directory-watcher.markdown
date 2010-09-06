---
title: haml directory watcher
published: true
layout: post
---

My friend [Ethan Gunderson](http://ethangunderson.com/index.html) wrote
[an article](http://www.scribd.com/doc/33776550/Rails-Magazine-Issue6)
on the beauty of [HAML](http://haml-lang.com/) as a substitute for ERB
or just plain HTML markup. He's been singing its praises for a long time
now, but I've just been too stubborn to listen to his good advice. At
first glance, HAML looks like a strange sort of dialect, and indeed it
does take a bit to get used to if you've been doing ERB or using any
other kind of traditional templating markup for awhile.

During a recent project I've been working on, I've been spending more
time than usual doing actual layout and design. I tend to be someone who
actually likes to [do my design in the
browser](http://24ways.org/2009/make-your-mockup-in-markup). After
having all kinds of problems with unclosed nested divs and other
mal-formked markup, I decided that it was finally time to give HAML a
try.

Boy, have I been missing out on something cool. Better late to the party
than never I guess.

Anyhoo, unlike [LessCSS](http://lesscss.org/) (a cool CSS tool I use)
which has a --watch flag, HAML does not have the same directory watching
capability. I wanted something that watches a given directory and
recompiles the HAML to HTML whenever the file is updated. Here's the
ruby script I came up with:

{% highlight ruby %}
# Script to watch a directory for any changes to a haml file
# and compile it.
#
# USAGE: ruby haml_watch.rb <directory_to_watch>
#
require 'rubygems'
require 'fssm'

directory = File.join(File.dirname(__FILE__), ARGV.first)
FSSM.monitor(directory, '**/*.haml') do
  update do |base, relative|
    input = "#{base}/#{relative}"
    output = "#{base}/#{relative.gsub!('.haml', '.html')}"
    command = "haml #{input} #{output}"
    %x{#{command}}
    puts "Regenerated #{input} to #{output}"
  end
end
{% endhighlight %}

It's pretty straightforward. Make sure you have the 'fssm' gem installed
before you try to run it (gem install fssm). Thanks Ethan for telling me
about HAML. :-)

Enjoy!

