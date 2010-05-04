---
title: iphone metra updates
published: true
layout: post
---

The [iPhone metra schedule application](http://metra.blakesmith.me) that
I
[announced](/2010/01/06/launched-iphone-metra-app-for-train-schedule.html)
and launched in January has been working quite nicely for my day-to-day
commuting. The use case of 'Tell me what trains I can get on right now'
seems to encapsulate what most people would want to use the application
for.

The goal of the Metra schedule iPhone app was to be minimal, simple, and
just give you enough data to do what you want. For the situations where
you're running to the train and want to look up trains that are about to
depart, it works great. However, I've found myself annoyed at the fact
that if I want to look at _tomorrow's_ schedule, I have to go pull to
the actual metra website - either on a phone or computer (yuck and
yuck!).

This seems to be a common use case amongst other people as well. If the
application can solve the problems of 'What train can I get on right
now?' and 'What trains are available tomorrow?' - I think it will fit
99% of people's needs.

So today I've pushed out a new version of iPhone Metra.

### check tomorrow's schedule

For the current station selection, if you scroll down to the end of the
trains, you should be able to find the option to check the schedule for
tomorrow:

![Link to tomorrow](/images/metra_go_tomorrow.jpg)

Once you select the option, you will be taken to the schedule for the
currently selected stations, but for tomorrow:

![Tomorrow's schedule](/images/metra_tomorrow.jpg)

I spent a long time playing around with this screen. I wanted to make
certain that the user had many visual cues that they were looking at
tomorrow's schedule (you wouldn't want to look up the wrong time for the
wrong day). I tried lots of different options, and I came up with the
solution to make the station names orange. I'm hoping that by being a
different color, the user will recognize that something has 'changed'
and they aren't looking at the same thing as they were before. On top of
that, a link to go back to the current day's schedule is right below
that, helping to confirm the suspicion the user might have that
something is different. One last possible clue is the countdown time to
the left of the train - times will appear much higher if you're looking
at tomorrow's schedule and should also help signal the user that they're
not looking at today.

### aeschetic changes

The top portion of the schedule display has always kind of annoyed me, I
felt like the top portion didn't really promote what was important, and
demote what was not important:

![Original
schedule](/images/metra_schedule.jpg)

After some cleanup, I've found that this design focuses the user
attention much more readily on what's important:

![New schedule](/images/metra_blue_buttons.jpg)

### holiday schedules

This actually has been in production for about a month or so, but I
wanted to go public with the fact that iPhone metra now accounts for
days that are official Metra holidays. If you retrieve today or
tomorrow's schedule when that day falls on a holiday, iPhone metra will
automatically kick back a Holiday schedule. In the future, it might be
neat to display some kind of indication that the user is viewing a
holiday schedule, but for now nothing is visually changed.

### check it out

If you haven't checked it out yet, [give it a
try](http://metra.blakesmith.me) and be sure to bookmark it to your
iPhone home screen for easy access to the schedule!
