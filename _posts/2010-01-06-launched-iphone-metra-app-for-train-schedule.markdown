---
title: "launched: iphone metra web app for train schedule"
layout: post
published: true
---

Like most people, I'm of the opinion that the new [Chicago Metra](http://metrarail.com) website is a bit underwhelming. Viewing the schedule from my iPhone is still tedious and painful, as they don't expose a decent mobile view of the schedule. So like any geek would do, I tinkered... And I think it lead to good results.

As of a few days ago, the [application I've been working on](http://metra.blakesmith.me) in my spare time for the past couple weeks has gone into release. It is a easy to use web application targeted at the iPhone mobile safari browser, for use by Chicago Metra train commuters. Pictures speak a thousand words, so check it out:

![Schedule Display](/images/metra_schedule.jpg)

I think the picture speaks pretty clearly for itself. The application tries to solve one basic problem by answering one question, "What train can I get on next?". There's lots of other data that we could throw at the user, (Bike limits, a detailed list of all the stops, etc.) But this isn't what people really need to see.

To get to this screen, initially you drill down into the following menu:

![Line Select](/images/metra_select_line.jpg)

Then you select your starting and ending stops:

![Starting Station Selection](/images/metra_starting_station.jpg)

The cool thing is, once you select your stops for the first time, next time you open the application up it will remember the stops and take you straight to the schedule display. This assumes that MOST people usually go back and forth between just two stops, and shouldn't have to input all this data everytime.

[Click here to view the App](http://metra.blakesmith.me)

### technical details

The web frontend is a Ruby on Rails application combined with IUI for the presentation layer (Thanks to [Noel Rappin](http://10printhello.blogspot.com/) for the rails-iui plugin). This is also coupled with some custom javascript to do the countdown timers and clock logic. The web server is Lighttpd which proxies to a cluster of Mongrels which handle the Ruby application execution.

The heavy lifting is done by a data and object library I built for the schedule scraping and business logic. I've released the source for this, in hopes that others might find it useful and build something else cool around the metra data. I for one am annoyed at the fact that Metra doesn't expose this data to begin with, so any help I can provide to a future developer to make an application is terrific.

You can find information and the source to the data library on my github [here](http://github.com/blakesmith/metra_schedule). You can also do a 'gem install metra_schedule -s http://gemcutter.org' if you want to start playing with the library immediately.
