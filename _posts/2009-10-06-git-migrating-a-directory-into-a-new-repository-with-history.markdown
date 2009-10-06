---
layout: post
title: "git: migrating a directory into a new repository with history"
published: true
---

I had a problem. I started a new project in git with a very broadly defined scope. As I started hacking along, I realized that some of the components of my project should probably be pulled out into their own seperate library. With this came the problem:

I wanted to:

- pull a directory of my existing git project out of the repo
- put those files into a new repo
- retain the history of the files that were moved in the new repository

Let's assume for this example that I have the following existing git repository:

<pre>
big_project/
'-> 
    test/
    src/
    '-> 
        mylib/
	'-> 
	    mylib.h
	    mylib.c
        main.c
    doc/
</pre>

Through the process of evolution, we've found that 'mylib' is actually quite capable of standing on it's own, and thus we'd like to move it into it's own seperate repository. __WARNING: Make sure you have backups of your repository in case anything goes wrong, some operations listed below are destructive__

### step 1: clone existing repository

cd to the directory with the repository and issue the following command:

{% highlight bash %}
$ git clone --no-hardlinks big_project mylib
{% endhighlight %}

This will create a copy of the project ommiting filesystem hardlinks. Both big_project and mylib are exactly the same at this point. Now let's do some history modification:

### step 2: filter branch the subdirectory

cd to the mylib repository copy and issue the follow commands:

{% highlight bash %}
$ git filter-branch --subdirectory-filter src/mylib HEAD
$ git reset --hard
$ git gc --aggressive
$ git prune
{% endhighlight %}

The first command will make the 'src/mylib' directory the root of your repository and strip out all the files and history not in that directory. The reset --hard will move your current HEAD to the top of the history that was rewritten. git gc --aggressive will repack all of git's objects and remove ones that are not in your new history. git prune will remove all unreachable objects from the object database.

Next we need to remove 'src/mylib' out of big_project:

### step 3: remove files and history from old repository

cd back to your original project (big_project) and issue the following command:

{% highlight bash %}
git filter-branch --tree-filter "rm -rf src/mylib" --prune-empty HEAD
{% endhighlight %}

This will remove the 'src/mylib' directory from big_project.

### end result

You should now have 2 git repositories that look like this:

<pre>
big_project/
'-> 
    test/
    src/
    '-> 
        main.c
    doc/
</pre>

<pre>
mylib/
'-> 
    mylib.h
    mylib.c
</pre>

Each of these repositories will have history that corresponds with the files that are present in the respective repository.


### sources

This information was derived from [this StackOverflow question](http://stackoverflow.com/questions/359424/detach-subdirectory-into-separate-git-repository).
