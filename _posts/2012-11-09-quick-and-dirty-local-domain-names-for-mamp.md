---
layout: post
title: Quick and Dirty Local Domain Names for MAMP
---
More often than not I've been needing to run web projects under their own domain instead of the simple sub-folder method. One major advantage to developing this way is deployment to production only has to rely on the domain name instead of sub-folder paths which can get annoying to work with. Since I have always leaned towards MAMP as my goto stack for development on my Mac I figured I can just tweak minor pieces of it without having to set up a custom stack. 

Going through these steps will allow you to enter **http://my-blog.dev** into your browser and it will respond as if it had its own domain.

Now, for all you non-techie designers out there, fear not. We are making minor text file changes which can be undone.

A few assumptions I am making:

- You are running [MAMP basic/free/non-pro](http://mamp.info/) with default settings
- All of the sites you want domains for are in the same directory

Step 1 - Edit the hosts File
------------------

Open up your hosts file in your text editor. The file is located at:

    /etc/hosts

At the end of that file add the sites you wish to respond. You will need to enter 1 line per site you want in the following format:

    127.0.0.1    my-site.dev

Make note of the name **my-site.dev** because will be using it later on. I have included a few more examples of what can be put into the hosts file.

<script src="https://gist.github.com/blainsmith/4046733.js?file=hosts"></script>

Step 2 - Create the Website Folder
------------------

Open up the **MAMP->Preferences->Apache** settings pane and make note of the **Document Root** path. The default path may be

    /Applictions/MAMP/htdocs

Now create your new website folder there called **my-site.dev** so your new site should be living in:

    /Applictions/MAMP/htdocs/my-site.dev

It is important that you name the folder the same name you used in Step 1.

Step 3 - Enable Virtual Hosts in Apache
------------------

There is specific file for Apache that handles virtual hosts in:

    /Applications/MAMP/conf/apache/extra/httpd-vhosts.conf

Open that file and change it to the version I included for you here:

<script src="https://gist.github.com/blainsmith/4046733.js?file=httpd-vhosts.conf"></script>

Make sure the **VirtualDocumentRoot** is the same path as the **Document Root** path you found in Step 2, but that it ends with **/%0**.

Step 4 - Edit Main Apache httpd.conf File
------------------

By default Apache will listen to port 8888 in MAMP. However, we want to be able to visit **http://my-site.dev** and not **http://my-site.dev:8888**, but we still want to leave port 8888 available for sub-folder sites and the built-in MAMP settings site running at [http://localhost:8888/MAMP/](http://localhost:8888/MAMP/). This turns out to be a very each change. We need to edit the main Apache config file located in:

    /Applications/MAMP/conf/apache/httpd.conf

Also, while we have this file open we are going to uncomment a line to make sure Apache loads the virtual host settings we set up in Step 3.

You will need to add **Listen 80** above the **Listen 8888** line in your own file and uncomment the line below **# Virtual hosts**. Here is a snippet of the httpd.conf file and how yours should look once you make those 2 changes.

<script src="https://gist.github.com/blainsmith/4046733.js?file=httpd.conf"></script>

Once you have all of these changed and saved just stop and start MAMP and you should be able to visit [http://my-site.dev](http://my-site.dev) in your browser. Now to add more sites just repeat Steps 1 & 2. You can even set up existing sites this way as well.

I hope this helps developers and designers alike. It is simple and doesn't require paying for MAMP Pro.