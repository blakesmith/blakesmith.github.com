---
layout: post
title: using vim recording
published: true
---

I've been a vim fan for quite a long time. I used to be an emacs guy, back when I didn't know any better (and thought that more features always made something better). With vim's powerful modal editing, there's almost no text document you can't edit quickly and efficiently. After awhile, it becomes second nature to use the keyboard for all sorts of text file navigation.

Vim provides a cool feature which I never really explored until recently: recording. Recording allows you to capture a series of modal commands, and repeat them as many times as you want. Let me show you a practical example.

### simple example

The other day I was editing an m3u file that had roughly 100 tracks in it. Each track listing was seperated by a comment. Something like this:

<pre>
1 
2 # chapter 1, section 1:
3 music/track1.mp3
4 # chapter 1, section 2:
5 music/track2.mp3
6 # chapter 1, section 3:
7 music/track3.mp3
8 # chapter 1, section 4:
9 music/track4.mp3
10 # chapter 1, section 5:
11 music/track5.mp3
...

</pre>

I wanted a quick and easy way to strip out the commented lines, as I was going to repurpose the filenames and pipe them into another program. This sounds like a prime canidate for using a vim record.

I place my cursor on line one and type the following:

<pre>
qa
</pre>

This tells vim to enter record mode (q) and store the contents of what is recorded into buffer a (a). Now that I'm in record mode I have to think carefully about what series of commands will get me the output I want. In this case I want to delete a line, skipping one in between. I can achieve this with the following series of commands:

<pre>
j (move down one row)
dd (delete a row)
</pre>

I have the series of commands I want, now I must exit recording mode:

<pre>
q
</pre>

I now have the appropriate action stored in buffer a. I can execute the recorded buffer like so:

<pre>
@a
</pre>

This tells vim to replay the recording (@) from buffer a (a). Just as I might paste something from a buffer 50 times, I can replay a recorded command-set the same way. In my case I wanted to run this 99 more times since there were 100 tracks. I used the following command:

<pre>
99@a
</pre>

Pretty cool eh?

Now I have a file that looks like this:

<pre>

1 
2 music/track1.mp3
3 music/track2.mp3
4 music/track3.mp3
5 music/track4.mp3
6 music/track5.mp3
...

</pre>

This was a simple example, but I'm sure you get the idea. Another practical example I used in with was have to convert a long series of paragraph html elements and put them into a table. This is a pretty repetitive action that can easily be optimized with a vim recording.

Here's hoping you're now more of a vim ninja!
