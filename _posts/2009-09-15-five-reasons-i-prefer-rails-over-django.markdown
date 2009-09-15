---
layout: post
title: five reasons i prefer rails over django
published: true
---

Don't you just love controversial titles like that? Who wants to be always neutral on topics when you can pick a side and cause a bit of disturbance. Sure I like [Django](http://djangoproject.org), it's what got me into MVC web development to begin with. I was already familiar with Python when I started working with Django, so it was a great transition from PHP. That being said, I will say that Django does seem to have different goals than Rails and thus different features that stem from it's development. Bottom line is I've been using Rails on a daily basis at work and can see why people find it's so attractive. Here's why it's awesome, (and why you should care).

### 1. simple controllers

Rails has the philosophy that your controllers should be simple, elegant and lightweight. It's not uncommon to see an action in rails defined in one line:

{% highlight ruby %}
def index
  @posts = Post.published.all
end
{% endhighlight %}

As compared to something similar in Django:

{% highlight python %}
from django.shortcuts import render_to_response
from blog.models import Post

def index(request, id):
    post_details = Post.objects.filter(published=True)
    return render_to_response("blog/post_details.html", {'post_details': post_details})

{% endhighlight %}

It's not that the Django controller has that many more lines of code, it's the verbosity of the function. In Django, you have to be very explicit about everything. If I want to use a model from my project, I have to explicitly import that model into the view otherwise it won't be present in the controllers namespace. I have to be very specific about which variables from the controller are going to get passed to the view template. Granted there are some shortcuts, but they result in code that is harder to read and not as elegant. I like that Rails prescribes to the 'convention over configuration' approach. Not only is this visible in the controller code I just showed you, but in the amount of time you're going to spend playing with configuration files. 

### 2. migrations

This is a big one for me. Unless you're going to spend months and months designing a detailed database model, your schema is going to change. Even if you spend months and months working on a data model, it's going to change. A web framework should expect this. Django [seems to be working on this](http://code.djangoproject.com/wiki/SchemaEvolution), but right now if I want to modify my models in any way, I'm going to have to make the appropriate changes to the model, access the database and run the SQL manually. This is a major speedbump for me. I just don't like it. When I'm already using an abstraction layer to manipulate my SQL database as it is, I really don't want to have to drop to a SQL shell unless I absolutely have to. The awesomeness of rails migrations speak for themselves:

{% highlight ruby %}
class AddEmailToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :email, :string
  end

  def self.down
    remove_column :users, :email
  end
end
{% endhighlight %}

This rocks my socks. Being able to go both directions is brilliant. Migrations are a winner.

### 3. ERB in the view

Again, this is a difference in philosophy. Django says that templates should be easy for designers to read and understand, and to this I would agree. However, the annoyance comes when I as a developer work on the view template. I have to remember 2 ways to do iteration, (One in Python, one in the Django Templating language). I have to remember all sorts of stuff about filters and tags... It's just a lot to get comftorable with quickly. Having to learn two ways of doing it makes it harder for quick adoption. If you're new to Python AND Django, you're going to be working quite a bit harder to get comftorable. Rails uses ERB or embedded ruby. The same flow control syntax I use in my models and controllers, I can also use in my views. 'But what about designers?' you might ask. I would tell you that ruby is easy enough to read (sometimes easier) than Python: I think Ruby reads closer to printed prose than Python does, thus making it more accussible to non-developers.

The only disadvantage about using ERB in the views, is you have to be careful about how much business logic they contain (There shouldn't be any). Make sure to only put presentation logic in the view, and you'll be much more satisfied in the long-term.

### 4. enumerables/blocks

This isn't much of a Rails thing as it is a Ruby thing. I like enumerables. I like them a lot. They provide so many shortcuts to common problems that you're bound to face. They allow your code to be shorter and easier to understand. Let me pose an example comparing Python and Ruby. This may be a matter of opinion, but you tell me which one you think looks cleaner:

{% highlight ruby %}
posts = [{:title => 'Why the Swedish Chef is Awesome', :published => true},
          {:title => 'How to make a million dollars a day', :published => false}]

puts posts.find_all{ |post| post[:published] == true }.map{ |post| post[:title] }
{% endhighlight %}

I read this as: Find all my posts where they are published, and print me their title

{% highlight python %}
posts = [{'title': 'Why the Swedish Chef is Awesome', 'published': True},
            {'title': 'How to make a million dollars a day', 'published': False}]

for post in posts:
    if post['published']:
        print(post['title'])
{% endhighlight %}

I read this as: Loop through all my posts, if the post is published, print the title

This one will depend on what kind of programming background you come from, but personally I love the power and flexibility of all the various enumerables. They read more like a sentence than a blob of code. This was a simple example, but where I think ruby shines is when the logic gets longer and a bit more sophisticated. I get weirded out with Python when I see deep layers of nested if/else statements.

### 5. community/gems/plugins

This is a chicken and egg problem. It's hard to have cool plugins if you don't have lots of users. Conversely, it's difficult to have lots of users if you don't have cool plugins. Because Ruby is so maleable and extendable with mixins, it makes writing extensions and plugins quite simple and hassle-free. On top of that, Rails makes it extremely simple to bring in other people's packages and integrate them into your own. Rubygems is a definite advantage here, and the installation process using rake tasks is quite convenient.

The sheer quantity of problems that have been modularly solved using plugins and gems is astounding. So much of web development involves logic that can be reused. Thanks to the rails community adopting [Github](http://github.com) these plugins can spread far and wide and are generally in one central location.


### wrapup

I'm a big believer in using the right tool for the right job. If you're trying to fit a square shape into a round hole you're doing something wrong. Rails cannot solve all your web development problems. Some may be better solved with Python (perhaps if I wanted to do something that involved the [twisted](http://twistedmatrix.com) library). But for general enjoyment and productivity, give me Rails anyday.
