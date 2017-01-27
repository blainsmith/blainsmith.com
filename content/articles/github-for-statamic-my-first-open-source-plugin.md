---
date: 2012-08-02T00:00:00Z
title: GitHub for Statamic, My First Open Source Plugin
---

Even though [Statamic](http://statamic.com/) has only been around for a short while there have been some [great plugins](http://statamic.com/learn/reference) developed for it and I wanted to get in on the action. But what to make? I didn't want to bite off more than I could chew considering the other projects I have going right now. Since Statamic has a decent following amongst web developers and designers I thought a plugin for them would be the best option.

While browsing around one night I ended up logging into my [WorkFu profile](https://workfu.com/blainsmith) and noticed my stats from all of my social networks. That's when it hit me that I should focus my efforts on a plugin to mimic that functionality. I ended up choosing GitHub for a few reasons:

1. [Public API](http://developer.github.com/) with JSON and no OAuth requirements
2. A Gists plugin already existed, so it would compliment that well
3. Targeted my web developers and designers audience
4. Twitter plugins get old

Now that I had my idea it was time to get my hands dirty, but since it was so easy to create the plugin I barely got dirt under my fingernails! It was just so enjoyable to get the plugin working because the Statamic tags mapped directly to the PHP plugin code.

### PHP Plugin Code

<pre><code>class Plugin_<span style="color:#990000;">github</span> extends Plugin {
    public class <span style="color:#009900;">profile</span>() {
        $account = $this->fetch_param('<span style="color:#000099;">account</span>', 'DEFAULT');
        ...
        return $html;
    }
}</code></pre>

### Statamic Tag

<code>{{ <span style="color:#990000;">github</span>:<span style="color:#009900;">profile</span> <span style="color:#000099;">account</span>="blainsmith" }} </code>

Very cool stuff if you ask me. So to start off I made my plugin grab generic profile stats which include the number of followers, repos, and gists you have. Then diving into the GitHub API further I was able to add listing public repository to show off your coding awesomeness. Maybe someday soon I will extend it to encompass more of the public API calls, but this will do for now. I think my next plugin will be more generic for the everyday user when Statamic is powering non-techie blogs and small business sites. Even though I do have other repos available on GitHub, this is my first official plugin for a commercial CMS.

Now all you geeks go and [grab the plugin over at GitHub](https://github.com/blainsmith/Statamic-GitHub-Plugin)!
