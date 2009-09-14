---
layout: post
title: using multiple versions of ruby with rvm
published: true
---

As the Ruby community begins to transition to Ruby 1.9 as the standard, there are some things that I needed to address. This weekend, [Arch Linux](http://archlinux.org) migrated to ruby version 1.9 in the upstream repositories. I'm a big fan of running bleeding edge software releases, so Arch works well... I would have hoped that the upgrade to 1.9 would be seamless, but there are a few issues that would compel me to run multiple versions of Ruby happily on the same machine, namely: 

- Not all gems and plugins have updated to be compatible with 1.9
- Older projects that will not be upgrading to the latest release are still required
- Duplicating production environments as closey as possible

Meet [rvm](http://rvm.beginrescueend.com/). It provides the tools necessary to have multiple versions of Ruby installed at the same time, and mechanisms to switch quickly and painlessly between them without jumping through any hoops.

### install

Fire up a terminal and:

{% highlight bash %}
$ gem install rvm
$ rvm-install
{% endhighlight %}

rvm-install will walk you through a series of prompts to finish the install. Most importantly, it will ask you about installing some hooks into your bash/zsh config files. This adds some of the rvm tools to your PATH. Once that is complete, logout of your current shell and log back in, you should now be able to do something like this:

{% highlight bash %}
$ rvm info
rvm 0.0.37 (2009.09.09) [http://rvm.beginrescueend.com/]

ruby:
  interpreter:  "ruby"
  version:      "1.9.1p129"
  date:         "2009-05-12"
  platform:     "x86_64-linux"
  patchlevel:   "2009-05-12 revision 23412"
  full_version: "ruby 1.9.1p129 (2009-05-12 revision 23412) [x86_64-linux]"

homes:
  gem:          "'not set'"
  ruby:         "'not set'"

binaries:
  ruby:         "/usr/bin/ruby"
  irb:          "/usr/bin/irb"
  gem:          "/usr/bin/gem"
  rake:         "/usr/bin/rake"

environment:
  GEM_HOME:     ""
  MY_RUBY_HOME: ""
  IRBRC:        ""

{% endhighlight %}

This output will tell you some of the details of the current version of Ruby you're running. My system has 1.9.1 installed, but what if I have an application or package that needs 1.8.6 to run properly?

### installing another version of ruby

If I want to install version 1.8.6 of Ruby, I just issue the following command:

{% highlight bash %}
$ rvm install 1.8.6
{% endhighlight %}

This will go automatically go out, fetch the desired version of Ruby, compile and install it in your home directory. It's important to note that rvm does not install anything in any system directories, it keeps everything locally in your home directory. After compiling and installing, I should be able to do this:

{% highlight bash %}
$ rvm list

ruby:

   ruby-1.8.6-p383
   ruby-1.8.7-p174

jruby:


ree:


system:

=> ruby 1.9.1p129 (2009-05-12 revision 23412) [x86_64-linux]

{% endhighlight %}

This shows all installed versions of ruby on my system. In this case, I have 1.8.6 and 1.8.7 installed in my home directory, and 1.9.1 installed at the system level. The hash rocket pointing to 1.9.1 indicates that that is the current version that will be globally used. If I want to switch to using 1.8.6, I do this:

{% highlight bash %}
$ rvm use 1.8.6
$ rvm info
rvm 0.0.37 (2009.09.09) [http://rvm.beginrescueend.com/]

ruby:
  interpreter:  "ruby"
  version:      "1.8.6"
  date:         "2009-08-04"
  platform:     "x86_64-linux"
  patchlevel:   "2009-08-04 patchlevel 383"
  full_version: "ruby 1.8.6 (2009-08-04 patchlevel 383) [x86_64-linux]"

homes:
  gem:          "/home/blake/.rvm/gems/ruby/1.8.6"
  ruby:         "/home/blake/.rvm/ruby-1.8.6-p383"

binaries:
  ruby:         "/home/blake/.rvm/ruby-1.8.6-p383/bin/ruby"
  irb:          "/home/blake/.rvm/ruby-1.8.6-p383/bin/irb"
  gem:          "/home/blake/.rvm/ruby-1.8.6-p383/bin/gem"
  rake:         "/home/blake/.rvm/ruby-1.8.6-p383/bin/rake"

environment:
  GEM_HOME:     "/home/blake/.rvm/gems/ruby/1.8.6"
  MY_RUBY_HOME: "/home/blake/.rvm/ruby-1.8.6-p383"
  IRBRC:        "/home/blake/.rvm/ruby-1.8.6-p383/.irbrc"

{% endhighlight %}

Notice how it now points to the version of ruby we just installed. If you do a ruby --version you'll see that it works quite well:

{% highlight bash %}
$ ruby --version
ruby 1.8.6 (2009-08-04 patchlevel 383) [x86_64-linux]
{% endhighlight %}

Just like magic!

### working with gems

You'll have to install all the gems you need for each version you plan to run. You can do this like you would in a system ruby install, but DON'T USE SUDO. Remember that the versions of ruby you installed are stored in your home directory, so you want to make sure they are written with normal user priveleges. I noted that there is a feature 'gemdup' which is supposed to let you copy over gems from one install to another, but I couldn't get it to work correctly (it is marked as experimental, so I'll give that some time to mature). I could not get 'gemdir' to succesfully switch the gem directory either, but this isn't that big of a deal.

Overall I'm really pleased with rvm. Now I can cut ruby gems like a pro. :-)
