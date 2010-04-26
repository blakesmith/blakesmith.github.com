---
layout: post
title: rails 3 app without a database
published: true
---

In Rails 2, you used to be able to make Rails 3 work without a database
by adding the following line to your config/environment.rb file:

{% highlight ruby %}
config.frameworks -= [ :active_record ]
{% endhighlight %}

Rails 3 has switched the convention around. Go into your
__config/application.rb__ file and remove the following line:

{% highlight ruby %}
require 'rails/all'
{% endhighlight %}

Replace it with the following lines:

{% highlight ruby %}
require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "rails/test_unit/railtie"
{% endhighlight %}

You should now be able to fire up your rails application without a database.

