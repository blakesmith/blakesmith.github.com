---
title: compiling tinyfugue on snow leopard
layout: post
published: true
---

I recently upgraded my mac mini to Snow Leopard. The TinyFugue website says that it should compile right out of the box with the OS X dev tools installed, but this doesn't seem to work on snow leopard. When I tried to compile it right out of the box, I get the following error after running make:

<pre>
malloc.c:15: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'malloc_base'
</pre>

So I took a look at line 15 of malloc.c:

{% highlight c %}
caddr_t mmalloc_base = NULL;
{% endhighlight %}

Doing some googling, it seems that caddr_t is an obscure type that can also refer to a void pointer. To fix this so that tf will compile cleanly, download the following patch.

[snow_leopard.patch](/files/snow_leopard.patch)

After untarring the tf tarball, put the patch into the tf directory and apply it with the following:

{% highlight bash %}
$ patch -p0 < snow_leopard.patch
{% endhighlight %}

That should apply the fix to malloc.c. You can then run configure, make and install:

{% highlight bash %}
$ ./configure --prefix=/usr
$ make
$ sudo make install
{% endhighlight %}

That should do it! Happy MUDing!

