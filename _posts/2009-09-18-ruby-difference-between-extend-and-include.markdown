---
layout: post
title: "ruby: the difference between extend and include"
published: true
---

Ruby provides a great platform for modular coding. You're not limited to just class hierarchies that other languages provide. Through the power of mixins, code can be reused in many robust ways. The two primary ways to utilize the power of mixins are through Ruby's extend and include.

I know this one has been done many times before, but I felt some further elaboration would help. There are many use cases where extend and include are relevant. I'm also writing this down so I won't forget it later :-). Let's dive in.

### high level

As a general rule of thumb, you use extend for class level methods, and include for instance level methods. This isn't always the case, as we'll see in a later example. For now, let's just assume this to be the case. Here's an example that demonstrates this:

{% highlight ruby %}

module SayHello
  def hello
    puts 'hello'
  end
end

module SayBye
  def bye
    puts 'bye'
  end
end

class Greeter
  include SayHello
  extend SayBye
end

Greeter.bye # class level
bye
=> nil
Greeter.new.hello # instance level
hello
=> nil
{% endhighlight %}

This demonstrates the simple way to handle the difference between instance and class level methods. More often than not, you may want a module to be able to have instance AND class level methods, so you can just mix that module in, and have the class gain both. This is possible with this slightly more advanced example:

### common mixin usage

{% highlight ruby %}

module SayHello
  def self.included(base)
    base.extend SayBye
  end

  module SayBye # all class level methods
    def bye # class level method
      puts 'bye'
    end
  end

  def hello # instance level method
    puts 'hello'
  end
end

class Greeter
  include SayHello
end

Greeter.bye # class level
bye
=> nil
Greeter.new.hello # instance level
hello
=> nil

{% endhighlight %}

This acheives the same effect as the first example, but with a more simple interface. Instead of having to extend and include 2 seperate modules when you include SayHello, it automatically extends the sub-module SayBye. This is accomplished using the self.included method, which rails calls whenever a module is included. From inside this method, we capture the base object and tell it to extend our class level methods in the SayBye module. In our example the base object is the Greeter class.

### extending existing objects

If you have an existing object, whether it be a class or an instance of a class you can use the use the extend method to mixin a module's methods at the class or instance levels. This sounds confusing and contradictory to what I just told you, but I think an example will help clarify:

{% highlight ruby %}

module SayHello
  def hello
    puts 'hello'
  end
end

class Greeter
end
 
{% endhighlight %}

For the sake of this example, I have a module with some methods, in this case the 'hello' method. I also have a class, Greeter which I want to gain those methods. Let's say I do the following.

{% highlight ruby %}
>> g = Greeter.new
>> g.hello
NoMethodError: undefined method `hello' for #<Greeter:0x00000002319718>
    from (irb):3
    from /usr/bin/irb:12:in `<main>'
>> g.extend SayHello
=> #<Greeter:0x00000002319718>
>> g.hello
hello
=> nil
{% endhighlight %}

In this case, I used extend to add the hello method to __an already instantiated Greeter object__. In this case my g object gained some instance methods unique to that object. If I instantiated a different copy of my Greeter object, it would not have the 'hello' method on it. Similarly, extend can be used on the class itself for it to gain class level methods:

{% highlight ruby %}
>> Greeter.hello
NoMethodError: undefined method `hello' for Greeter:Class
        from (irb):2
        from /usr/bin/irb:12:in `<main>'
>> Greeter.extend SayHello
=> Greeter
>> Greeter.hello
hello
=> nil
{% endhighlight %}

The important thing to take away from these examples is that extend works at the level of the type of object you've passed it.

### include before class is instantiated

Given the same code as above:

{% highlight ruby %}

module SayHello
  def hello
    puts 'hello'
  end
end

class Greeter
end
 
{% endhighlight %}

Let's say we want to mixin the hello method to any new instances of Greeter. We can do it like this:

{% highlight ruby %}
>> Greeter.send :include, SayHello
=> Greeter
>> g = Greeter.new
=> #<Greeter:0x00000002a0bde0>
>> g.hello
hello
=> nil
{% endhighlight %}

Remember, use include to have a class gain instance methods __before it's instantiated__. Use extend if you want the object to gain instance methods __on an already instantiated/existing object__. This can be confusing at first, but once you understand what's going on under the hood, it's not so bad.

### conclusion

I've covered all the basic areas where you'd want to use mixins. Hopefully going forward using modules in Ruby will be easier for you and you'll be able to enjoy coding more with the ability to make your code more modular.

Happy coding!
