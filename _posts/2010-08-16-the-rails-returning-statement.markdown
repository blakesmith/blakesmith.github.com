---
title: the rails returning statement
published: true
layout: post
---

All the cool Rubyists know that it's so passé to use the return
statement in a method call. You don't want to make other Rubyists think
you're uncool by using such an unnecessary expression, do you? No, of
course you don't.

Let me tell you something else that's also uncool. The following snippet
of code, and the pattern that emerges from it:

{% highlight ruby %}
def some_hash
  thehash = Hash.new
  thehash[:property1] = "one"
  thehash[:property2] = "two"
  thehash[:property3] = "three"
  thehash
end
{% endhighlight %}

What's so uncool about this you may ask? We have two lines of routine
boilerplate code that are repeated over and over again.  Every time you
need to build up a hash in this manner, you're going to be instantiating
a hash like this:

{% highlight ruby %}
  thehash = Hash.new
{% endhighlight %}

... stuffing some data inside of it, and then explicitly calling the
hash at the end of the method so that it returns from the function
instead of the last evaluated property:

{% highlight ruby %}
  thehash[:property3] = "three"
  thehash
{% endhighlight %}

We do this with Arrays and all sorts of other data structures:

{% highlight ruby %}
def some_array
  thearray = Array.new
  thearray << "value1"
  thearray << "value2"
  thearray << "value3"
  thearray
end
{% endhighlight %}

Let me show you something that's much cooler that you get in Rails for
free. It achieves the exact some thing as above, but in a far more
elegant and minimal expression:

{% highlight ruby %}
def some_hash
  returning Hash.new do |h|
    h[:one] = "one"
    h[:two] = "two"
    h[:three] = "three"
  end
end
{% endhighlight %}

Oh my, that's some beautiful code right there. Much more elegant, simple
and clear. We're cutting out two lines of boilerplate code, and making
the whole thing read much cleaner. Let's look at the same thing while
rewriting the array version:

{% highlight ruby %}
def some_array
  returning Array.new do |a|
    a << "value1"
    a << "value2"
    a << "value3"
  end
end
{% endhighlight %}

A true beauty!

The returning statement is both simple in use, and simple in
definition:

{% highlight ruby %}
class Object
  def returning(value)
    yield(value)
    value
  end
end
{% endhighlight %}

This is the kind of stuff that gets me excited about Ruby. It's flexible
enough that we can add on this kind of functionality to the base of the
language without much pain or hassle. We're not doomed to repeat ugly
paradigms and write ugly code forever if we can come up with a better
way of saying something, much like someone using a spoken language
might. So use it! Next time you're building up a data structure like
this, bust out your awesome knowledge of the returning statement and
show those other Rubyists that you're hip and with it.

