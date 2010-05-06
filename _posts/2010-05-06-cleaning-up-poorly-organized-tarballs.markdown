---
title: cleanup up poorly organized tarballs
published: true
layout: post
---

Have you ever downloaded a tarball or zip file that contains lots of
files, but doesn't have them placed in their own directory? This is high
on the list of pet peeves. I'll download the source for some piece of
software and the person who packaged the code didn't put all the source
directories and files into their own directory.

I'll download the archive, and save it to my "Downloads" folder. I'll go
to extract the archive, and just like playing 52-card pickup it spews
files all over the directory. Usually at this point my teeth are nashing
and I'm asking why someone would do something that's this evil. In the
past, if the count of files was small enough, I'd just remove them by
hand (ugh). I propose a solution to this terrible problem!

So you download an archive, and go to unarchive it:

{% highlight bash %}
$ tar xzvf myarchive.tar.gz
{% endhighlight %}

And you get files exploded into your present directory. Your stress
levels are rising and you're wondering why the wrath of the computer
gods have chosen to smite you. Don't panic, there is a cure!

While staying in the same directory:

{% highlight bash %}
$ tar -tzf myarchive.tar.gz | xargs rm -rf
{% endhighlight %}

Presto! All the mess is gone. Now you can go ahead and do the work that
the packager should have done in the first place and create the
directory yourself. The first half of this command (before the pipe) is
simply listing all the contents of the archive and writing them to
stdout. Then we pipe those results to xargs, which removes each file
that's printed. Huzzah!

Just a little trick I discovered today that I thought I might pass on.
Cheers!

