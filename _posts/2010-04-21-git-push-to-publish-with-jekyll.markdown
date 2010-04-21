---
layout: post
published: true
title: git push to publish with jekyll
---

This blog uses a push to publish model with
[Jekyll](http://github.com/mojombo/jekyll) and Github Pages. You can see
a write-up of this process [right
here](github.com/blakesmith/blakesmith.github.com/blob/master/README.markdown).

I wanted to implement a similar sort of feature with another Jekyll
powered site I'm working on without having to use Github pages. Luckily
for me after a bit of googling I found that Ryan Briones [had already
thought about it and had a working
solution](http://brionesandco.com/ryanbriones/blog/2009/07/27/push-to-publish-website-with-git-and-jekyll.html).

I recommend giving his article a read. I was able to follow his steps
and do the same thing for my project. I did a slight cleanup of his
post-receive script which I wanted to post here.

Put this script inside the source (non-local) repository repository that
you are publishing to. When it receieves a push, it will execute the
post-receive bash script and explode and compile the jekyll source.

{% highlight bash %} 
#!/bin/bash

GITSOURCE=/home/user/pubgit/jekyll-site.git
SOURCE=/home/user/public_html/jekyll-site/source
PUBLIC=/home/user/public_html/jekyll-site/public

git --bare --git-dir=$GITSOURCE archive master | tar xC $SOURCE 
jekyll $SOURCE $PUBLIC 
{% endhighlight %}

Variable definitions (replace these with your own setup):

- GITSOURCE - the source git repository 
- SOURCE - directory where the jekyll source is exploded to after a push 
- PUBLIC - compiled jekyll files. Point your web server to this directory

Thanks again to Ryan Briones for this recipe. Happy Jekylling!

