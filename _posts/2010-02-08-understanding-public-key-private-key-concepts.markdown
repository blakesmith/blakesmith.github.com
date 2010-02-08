---
layout: post
title: understanding public key private key concepts
published: true
---

When I started to use ssh in my workflow many years ago, the concept of public and private keys came up as quite confusing. If you aren't aware ssh can use public/private key methods for authorization and authentication. I found countless tutorials online that described the procedures for setting up key based authentication with ssh, but very few explained it in a conceptual way that was easy to understand. Some of the terms went right over my head. I came up with a good analogy that might help others in the future.

- Think of a public key as being the lock. It's not actually a key, it's a padlock you can make lots of copies of and distribute wherever you want. For example, if you want to put your 'padlock' on an ssh account on another machine, you would copy it to 'authorized_keys' in the ~/.ssh folder. You've setup the padlock.
- Think of a private key as being the actual key. This is what you use to open the padlock that is stored on the other machine. Just like a regular key you keep it secret, safe, and out of the wrong hands.

![Public Private Key](/images/public_private_key.png/)

Your public key (padlock) can be distributed anywhere. Toss it all over the place. As long your private key is never compromised, it doesn't matter where your public key is living. Toss it everywhere. Just like a real life key system, you wouldn't care if there were hundreds of the same padlock locking your things, as long as you never lost possession of the key. This holds true for public/private key models as well.

So when you run 'ssh-keygen' - it produces both a private (id_rsa) and a public (id_rsa.pub) key for usage. You have both the master lock and the key to open it. With this, you can make copies of id_rsa.pub (public key/padlock) and put them onto the computers that you want someone with the private key (probably just you) to have access to.

![Public Private Key on many computers](/images/public_private_many.png/)

Yes, this is an oversimplified analogy - but this is the concept that really helped me to understand how the whole system works at a very high level.
