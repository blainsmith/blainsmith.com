---
layout: post
title: Tag Your Config Files in OSX Mavericks
---
I have always liked the concept of tagging. To me it helps organize without being too restrictive as having a predefined set of categories or even folders that I would have to manage. So when I saw the new features of OSX 10.9 Mavericks I was happy to see that tagging made it on that list.

Since I do a lot of web development and use the command line a lot I found that I have a shit load of configuration files all over my system. Projects live in one folder, [Homebrew](http://brew.sh/) installs stuff in another, the hosts file is somewhere else, and [Riak](http://basho.com/riak/) needs a [launchd.conf file to exist with certain ulimit number set](http://docs.basho.com/riak/1.3.1/cookbooks/Open-Files-Limit/#Mac-OS-X). WTF!?!?!

This is where Mavericks tags come in REALLY handy for remembering where everything lives and what custom changes I've made to my files. I have tagged all my configuration files and folders for quick terminal and Finder access.

Some of the paths I tagged are:

- /etc/hosts
- /etc/launchd.conf (OS config for setting ulimit for Riak)
- /usr/local/Cellar (Homebrew apps)
- ~/.gitconfig
- ~/.ssh
- ~/Projects

For now I just added the tags through Finder, but I had to add write permission to my account for a lot of the system files to able to modify them so be sure you do that if you want it to work. Listing all files on your system from the command line is a simple one liner and doesn't require any extra scripts.

    blainsmith@Blains-MacBook-Pro ~> mdfind "kMDItemUserTags == dev"
    /private/etc/hosts
    /usr/local/Cellar
    /private/etc/launchd.conf

This is pretty nice, but if you don't want to rely on Finder to add tags then schwa's GitHub project, [half-moon-tagging](https://github.com/schwa/half-moon-tagging), looks interesting to manage all your tags from the commend line.

Hope this tips helps out and let me know what other uses you find for tagging files.