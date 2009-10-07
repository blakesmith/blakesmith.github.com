---
layout: post
title: jekyll pagination example
published: false
---

### what is jekyll?

From the jekyll website:

<p class="quote">
	"Jekyll is a simple, blog aware, static site generator. It takes a template directory (representing the raw form of a website), runs it through Textile or Markdown and Liquid converters, and spits out a complete, static website suitable for serving with Apache or your favorite web server. This is also the engine behind GitHub Pages, which you can use to host your project’s page or blog right here from GitHub."
</p>

What this means is that you can take a website that has a simple function, such as a blog or personal site - and give it easy to use dynamic properties. For example, my blog here is encapsulated entirely in static html files. I compose my pages in Markdown, HTML, or Textile - and jekyll 'compiles' them to static html for presentation.

### using with blog posts

Jekyll is losely based around the blog model. It has built-in support for managing blog posts, and pagination that goes with it. One thing that was difficult for me when getting started was finding a good example of how to use jekyll to paginate my blog posts. I didn't want every post to be listed on the front page.

The jekyll documentation [provides the following](http://wiki.github.com/mojombo/jekyll/template-data) variables for working with pagination:

<pre>
paginator.per_page		Number of posts per page.
paginator.posts			Posts available for that page.
paginator.total_posts		Total number of posts.
paginator.total_pages		Total number of pages.
paginator.page 			The number of the current page.
paginator.previous_page 	The number of the previous page.
paginator.next_page 		The number of the next page. 
</pre>

A somewhat spartan list for managing pagination. I tried to extrapolate how the pagination feature functions specifically. The jekyll documentation isn't much help here, but I did find this [cucumber test](http://github.com/mojombo/jekyll/blob/2f2e45bedf67dedb8d1dc0d02612345ee5c893f2/features/pagination.feature) in the git repository that helped point me in the right direction. I recommend reading it to understand a bit more how the feature works.

### an example

Start by adding the following to the bottom of your \_config.yml file in the root of your jekyll project:

{% highlight yaml %}
paginate: 5
{% endhighlight %}

In our case, we want our blog posts to be split with 5 posts per page. Let's look at the code to render the paginated list.

<pre>
<ul class="posts">
  {% for post in paginator.posts %}
    <li><span class="weak">
      {{ post.date | date_to_string }}
      </span> &raquo; <a href="{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>


<!-- Pagination -->
{% if paginator.previous_page == 1 %}
	<a class="semi-weak" href="/">&laquo; fresh thoughts</a>
{% endif %}
{% if paginator.previous_page > 1 %}
	<a class="semi-weak" href="/page{{ paginator.previous_page }}">&laquo; fresh thoughts</a>
{% endif %}
{% if paginator.next_page <= paginator.total_pages %}
	<a class="semi-weak" href="/page{{ paginator.next_page }}">stale thoughts &raquo;</a>
{% endif %}
</pre>

The top portion of the code 
