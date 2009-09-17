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
    lib/
    src/
    '-> 
        mylib/
        main.c
    doc/
</pre>

Through the process of evolution, we've found that 'mylib' is actually quite capable of standing on it's own, and thus we'd like to move it into it's own seperate repository.
