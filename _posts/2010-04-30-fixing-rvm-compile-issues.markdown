---
layout: post
title: fixing rvm compile issues
published: true
---

I did a [write
up](/2009/09/14/using-multiple-versions-of-ruby-with-rvm.html) awhile
back on rvm and really enjoy it's feature set. Yesterday, I tried to rvm
install ruby 1.8.7 on a new machine I'm using that runs ruby 1.9.1 as
the system ruby. I did my normal thing:

{% highlight bash %}
$ rvm install 1.8.7
{% endhighlight%}

And rvm spit this error out after trying to compile:

<pre>
Error running 'make ', please check
/home/blake/.rvm/log/ruby-1.8.7-p249/make*.log
There has been an error while running make. Aborting the installation.
</pre>

Hrm, interesting... Let's take a look at the make.log:

<pre>
ossl_pkcs7.c: At top level:
ossl_pkcs7.c:546:14: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘*’ token
ossl_pkcs7.c: In function ‘ossl_pkcs7_set_certificates’:
ossl_pkcs7.c:584:11: warning: assignment makes pointer from integer without a cast
ossl_pkcs7.c: In function ‘ossl_pkcs7_get_certificates’:
ossl_pkcs7.c:594:5: warning: passing argument 1 of ‘ossl_x509_sk2ary’ makes pointer from integer without a cast
ossl.h:120:7: note: expected ‘struct stack_st_X509 *’ but argument is of type ‘int’
ossl_pkcs7.c: In function ‘ossl_pkcs7_set_crls’:
ossl_pkcs7.c:624:10: warning: assignment makes pointer from integer without a cast
ossl_pkcs7.c: In function ‘ossl_pkcs7_get_crls’:
ossl_pkcs7.c:634:5: warning: passing argument 1 of ‘ossl_x509crl_sk2ary’ makes pointer from integer without a cast
ossl.h:121:7: note: expected ‘struct stack_st_X509_CRL *’ but argument is of type ‘int’
make[1]: *** [ossl_pkcs7.o] Error 1
make: *** [all] Error 1
</pre>

Oh man, where to begin right? After doing a bit of poking around, I
discovered that the issue is with OpenSSL. My system install is using a
version that is having some compatability issues with compiling ruby.

After finding [this
thread](http://groups.google.com/group/rubyversionmanager/browse_thread/thread/f8ff58bb55620823)
and [this solution](http://rvm.beginrescueend.com/packages/openssl/),
here's the recipe I followed to get it to work:

{% highlight bash %}
$ rvm package install openssl
$ rvm remove 1.8.7
$ rvm install 1.8.7 -C --with-openssl-dir=$HOME/.rvm/usr
{% endhighlight %}

What am I doing? I'm downloading a working version of OpenSSL,
compiling it and sticking it inside my rvm prefix. Then I clean out
the provious installation attempt to make sure things are in order
before re-compiling. When I tell rvm to install ruby, I pass it in the
option of using the version of ssl that rvm compiled instead of the
system one. Now everything is working again, sweet! Back to cutting
those gems.

