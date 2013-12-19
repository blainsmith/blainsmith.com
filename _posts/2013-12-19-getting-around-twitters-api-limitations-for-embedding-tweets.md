---
layout: post
title: Getting Around Twitter's API Limitations for Embedding Tweets
---
Remember the good old days when you could just make an AJAX call to Twitter's API, get some JSON back and embed your tweets as you saw fit? Then Twitter had to get all high and mighty about their [display requirements](https://dev.twitter.com/terms/display-requirements). Now, in order to get your own tweets via JSON you have to now authenticate and register a widget and all sorts of bullshit. All for what? Displaying a single tweet of your own on your website? Fuck that.

Luckily there is [App.net](http://app.net) and [IFTTT](http://ifttt.com) we can leverage.

1. Sign up for App.net account
2. Sign up for an IFTTT account
3. Create a new IFTTT recipe so that every time you tweet it posts that same status to your App.net account
4. Use a little jQuery on your website and do what you want with your App.net status updates

{% gist 8046165 %}

This was one "legal" way I set up getting tweets into a site. I am sure there are others, but it's working quite well.