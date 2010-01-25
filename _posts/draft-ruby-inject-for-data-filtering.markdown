---
layout: post
title: ruby inject for data filtering
published: true
---

One of my favorite features of Ruby is its [Enumerables](http://ruby-doc.org/core/classes/Enumerable.html#M003134). They provide all sorts of neat loop logic that enhances readability and usefulness.

My favorite Enumerable so far is inject. I learned from the Ruby docs that inject is really great for building something up. Like a sum for example.

{% highlight ruby %}
>> numbers = (1..10).to_a
=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
>> numbers.inject(0) {|sum, current| sum += current}
=> 55
{% endhighlight %}

Conceptually, you can view inject as being useful for using a base variable (like an empty array) and adding stuff to that base variable using the logic in the block.

{% highlight ruby %}
>> numbers = (1..10).to_a
=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
>> numbers.inject([]) do |array, current|
>>   array << current if current.even?
>>   array
>> end
=> [2, 4, 6, 8, 10]
{% endhighlight %}

Again, we're building up an array and only including numbers in the array that are even.

One useful thing I've found I can do with inject is to use it to filter down an array of items based on certain criteria. Let's take a look at the example:

{% highlight ruby %}
class Filter
  def initialize
    @numbers = (1..10).to_a
    @filters = [filter_out_even]
  end

  def process_filters
    @filters.inject(@numbers) {|num, fun| fun.call(num)}
  end

  private

  def filter_out_even
    lambda do |numbers|
      numbers.find_all {|num| num.odd?}
    end
  end

end
{% endhighlight %}

Let's look at the results of this first in irb, then I'll explain what's going on.

{% highlight ruby %}
>> f = Filter.new
=> #<Filter:0x7ff7bbe0 @filters=[#<Proc:0x10022208@./inject.rb:14>, #<Proc:0x10021a24@./inject.rb:20>], @numbers=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]>
>> f.process_filters
=> [1, 3, 5, 7, 9]
{% endhighlight %}

In our class, @numbers is the array of items we're going to filter down. We start with a full array of all possible numbers, then filter them out by passing each number through all the filters. Each filter is defined by as a lamda function that is stored in the @filters instance variable. The public API goes through the array of @filters and calls each function on the remaining numbers in the set. If we wanted to add another filter, it's as simple as adding another lambda function, and adding it to the @filters array:

{% highlight ruby %}
class Filter
  def initialize
    @numbers = (1..10).to_a
    @filters = [filter_out_even, filter_divisible_by_three]
  end

  def process_filters
    @filters.inject(@numbers) {|num, fun| fun.call(num)}
  end

  private

  def filter_out_even
    lambda do |numbers|
      numbers.find_all {|num| num.odd?}
    end
  end

  def filter_divisible_by_three
    lambda do |numbers|
      numbers.find_all {|num| (num % 3) != 0} 
    end
  end

end
{% endhighlight %}

All we did was define another filter and add it to the @filters array. There are two things you should be aware of and cautious over when you use this:

1. Each filter will only filter out the results of what hasn't been filtered out. Because of this:
2. The filtering strategy should not depend on calling the filter methods in any specific order. If someone can switch the order of the @filters array and affect the results, something is probably screwy with your filter logic.
3. Filters should be written with logic that doesn't depend on the previous filter to do something.

For a more robust example of this in action, take a look at my recent [metra train schedule data library](http://github.com/blakesmith/metra_schedule/blob/master/lib/metra/line.rb) (find the 'trains' method, and the private filters at the bottom).
