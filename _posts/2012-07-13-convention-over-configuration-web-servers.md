---
layout: post
title: Convention Over Configuration Web Servers
---
I am seeing more and more bootstrap projects for HTML, CSS, PHP, and the like. This is great because it really removes a lot of the configuration time when starting a new project so you can get down to business. Even frameworks for Ruby and PHP have basic web app skeletons in place before you being working. 

With both front end and middleware levels covered its time we focus our efforts on the backend servers that power these apps. Too often I find myself manually installing and configuring a server.

1. Create the VM
2. Install Linux
3. Install Apache
4. Install MySQL
5. Install PHP
6. Remove mod\_php and replace with mod\_fcgi
7. Install PHP accelerator (XCache, APC, etc.)
8. Install content caching (Redis, Memcache, etc.)
9. Finally install WordPress, Drupal, or being working on an app

Seems like a lot of shit to deal with when a lot of these programs and settings are becoming standard, especially for high traffic websites. Why would we build a website expecting low traffic anyways? Some sites will not need the more advanced caching settings, but why not have them there and ready to go if needed.

A few places have started to embrace the need for a single install web server. [TurnKey Linux](http://www.turnkeylinux.org) and [BitNami](http://bitnami.org) offer a wide range server stacks that you can download, install, and a lot of the configurations done.

### [TurnKey Linux LAMP Stack](http://www.turnkeylinux.org/lampstack)

- SSL support out of the box.
- PHP, Python and Perl support for Apache2 and MySQL.
- XCache - PHP opcode caching acceleration.
- PHPMyAdmin administration frontend for MySQL (listening on port 12322 - uses SSL).
- Postfix MTA (bound to localhost) to allow sending of email from web applications (e.g., password recovery)
- Webmin modules for configuring Apache2, PHP, MySQL and Postfix.

This stack is also available with [PostgreSQL](http://www.turnkeylinux.org/lapp) instead of MySQL.

There are also many others for Ruby on Rails, Tomcat, and Java. More specific web app versions for Drupal, WordPress, Redmine, etc. are also available.

Once you get up and running with the configuration you need then you can certainly take a snapshop of that web server and deploy it as many times as you need. However, for us jack of all trade types it would be nice to see this taken a step further to include other emerging technologies and best practices. My wish list includes:

- Nginx
- Node.js
- Redis and Memcache
- Optimized WordPress/Drupal with caching and tuned PHP
- GitLabHQ

It only makes you a better programmer when you understand the underlying powerhouse of your app, but sometimes you don't give a shit and just want to build an app without messing around in web server configuration hell. I hope to see TurnKey Linux and BitNami thrive that more and more flavors become offered.

Happy Friday the 13th!