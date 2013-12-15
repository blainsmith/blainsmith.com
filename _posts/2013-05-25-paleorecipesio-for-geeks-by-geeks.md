---
layout: post
title: 'paleorecipes.io: for geeks, by geeks'
---
I spend a lot of time sitting at a desk all day like most geeks do, however I take great pride in my health and physical fitness. I go to [CrossFit](http://feral-crossfit.com) 5-6 days a week and I am 100% paleo dieting 80% of the time. A lot of us at [MadGlory](http://madgloryint.com) do CrossFit and following the same diet as well. We always mention paleo recipes to each other and eat lunch as paleo as possible, but the more I think about I wonder how popular the paleo diet really is among geeks. Even though there are a ton of paleo blogs and recipe websites out there I wanted to come up with a fun (and geeky) way to promote paleo eating throughout the geek world. 

Solution: [http://paleorecipes.io](http://paleorecipes.io)

To make this site fun and as hands off as possible I stitched together some cool tech to make it all work.

## Tech Used

- A .io domain of course because what geek doesn't like a .io domain
- [Statamic](http://statamic.com) is the flat-file CMS used to power the website
- I set up a [GitHub repo](https://github.com/blainsmith/paleo-recipes) of all the markdown recipe files that can be forked and submit pull requests so anyone can contribute
- [GitHub post-receive hooks](https://help.github.com/articles/post-receive-hooks) are used to auto-deploy new recipes that are merged into to repo
- [IFTTT.com](http://ifttt.com) is for auto-tweeting any new recipes from the [site's RSS feed](http://paleorecipes.io/recipes/feed)

All I have to do is sit back and watch the pull requests come in and make sure they are paleo recipes and the file format is good.

The website itself is pretty simple. It has taxonomies for **ingredients** (ex. chicken, bacon, tomatoes) and **for** (ex. snack, dinner, dessert) that should help find anything you want to eat. I was happy to be able to use the [Minimal theme](https://github.com/blainsmith/Statamic-Minimal-Theme) I made for Statamic a while back. Definitely saved me time on the design front.

So anyone with a GitHub account who wants to contribute feel free. But, if all you want to do is troll around the site for awesome recipes then that's fine too.