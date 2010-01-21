---
layout: post
title: core language counts
published: false
---

I was involved in an argument with a friend about the benefits of having common programming language use cases be incorporated into its core. He argued that as long as the language is really flexible, it's not really important what's included with the core language because you can just add onto it what you need. I disagreed with him.

== expectations

When a programming language comes with certain features as a base, it sets up certain expectations for how it will be used. If closures/anonymous functions are really simple to work with in a language, programmers will be much more inclined to use them. If you can only get access to closures through some clever trickery, then people will generally avoid them. Programmers are lazy, so a well designed language will make it easy to do the things it expects from you. If you're programming in a 'python like way' or a 'java like way' it will be easier for other developers to follow the thoughts and patterns of your code. These are the expectations of flow and structure.

== flexibility and clarity

Take a language like C. It's extremely small, and places very little expectations on how the programmer should use it. You can write C code object-oriented, procedure-oriented, event-driven or more. This has the benefit of extreme flexibility. C will pretty much get out of your way and let you write your code however you want. This has the benefits of extreme power, at the cost of clarity. Reading and understanding C code can take quite a long time. C coders have developed common patterns and idioms over time, but quite often I'll open up some unfamiliar C project and spend most of my time thinking, "What on earth is going on here?". Keeping code easy to read and easy to follow means well-thought out design, clear organization of thought, and predictable patterns of flow and control. Having some of these decisions made for you by the language means developers can spend less time arguing about how it's going to be done and do it. 

== crowded ecosystem

Java is a great example of a language that likes to bolt stuff on. It's become one of the defacto industry standards for big business software development, and as such it suffers from the problems of trying to be everything to everyone. It's got all kinds of tack-ons, add-ons and modules that try to reinvent the way you write in Java. The Spring Roo project is a great example of this, as well as Java annotations. I'm not arguing that Spring Roo or annotations are bad, but when countless tools like Spring Roo are added to the ecosystem it is difficult to keep pace with the expectations of Java programming style. As a language evolves and more of these tools are bolted on, reading and understanding and working with code that spans the entire life of the language becomes more and more difficult (especially languages that have been around for a long time). Making a decision about which tool to use becomes harder. Reading and writing code written 20 years ago is going to be more problematic with all its misfit solutions that should have been included with the core language from the beginning.

== reinventing the wheel

When you look at C code, you'll see a lot of reinventing the wheel. C doesn't come with the ability to do many things out of the box, so people often roll their own. I can hear what you're thinking, "But what about libraries?". Libraries have their strengths and weaknesses. There's a search cost that's attached to finding and evaluating the right library to suit your needs. If there are 3 common string manipulation libraries out there for my language, but the language's standard library includes its own string manipulation library - I'm much more prone to using the standard one. Maybe it's a combination of sheer convenience, laziness, and lack of dependency management - but in the end I'm more prone to use it because _the language has made the decision for me_. It's silently made the statement, 'This string manipulation library is important enough that we roll it into every incarnation of our language'. I may end up with decision paralysis if I'm forced to choose another one. Will the library do everything I want? Will I have to hack in fixes when it fails me? Would I be better off just rolling my own? These are the kinds of doubts that lead developers to reinventing the wheel (along with our propencity to show off our cleverness).

== the nature of evolution

Programming languages are evolutionary by nature - in a way similar to regular spoken languages. To have a language that remains useful and easy to work with for a long time, it is important for language developers to make well thought out design decisions. The goals of the tool must remain clear for it to avoid becoming the bolted-on kitchen sink that doesn't do any one thing well anymore. Opinionated tools can be good. Don't try to be everything to everyone. Instead, pick a design philosophy and include core tools in the language that support that philosophy.
