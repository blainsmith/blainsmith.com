---
layout: post
title: Single Command Static File Web Server
---
I have been building a lot of Javascript apps lately. I started to prototype one recently, but I did not want to set up an Apache host or a connect server to run it. I found a little gem of a command that was already installed on OSX.

```
~/Projects/static-app > python -m SimpleHTTPServer
```

This was the perfect solution for me. `SimpleHTTPServer` is a Python library and when you send that to Python with the `-m` flag it tells Python to run the library as a script. Running this within the root of your static file project just fires up a web server at <a href="http://localhost:8000">http://localhost:8000</a>.

This is perfect for:

- Wireframing and protoyping
- Javascript apps
- Designers converting their PSDs into static templates who don't want to deal with build tools right away

The next time you need something really basic to run a HTML/CSS/JS app try it out for a quick win.