---
date: 2012-08-15T00:00:00Z
title: VPSCheap.Net Review for the Server Savvy
---

For a long time I considered paying for an unmanaged VPS that I can beat the crap out of by installing packages, running web apps, learning new shit, or whatever else I can come up with. I do have shell access to my [DreamHost](http://www.dreamhost.com/r.cgi?587773) account that is running this site, but since its a shared host I'm limited to what can be installed because I don't have full root access. So when I decided to pull the trigger on paying monthly for a VPS I figured out a needed the following to satisfy my needs.

- Accessible via the web with a dedicated IP
- Decent storage space, unlimited storage isn't needed
- Full root access
- Speed doesn't need to be lightning fast
- Pick my own OS option
- No pay per hour/usage/etc method just a really low monthly cost under $10

A lot of my friends speak highly of Rackspace and Linode, but I didn't need the horsepower or stability they offered for the $20+ per month cost.

After searching around for a few days I stumbled on [VPSCheap.NET](http://vpscheap.net/). Their site definitely gave me a warm and fuzzy feeling which was important for me to give them my money. Their ad for "Linux Virtual Servers" starting at $1.99 per month definately caught my eye too! Once I was completely comfortable choosing them for my VPS I was faced with which level of I wanted. So, I stared at [their offerings](http://vpscheap.net/linux-unmetered.aspx) for 20 minutes until I finally settled on their VPS 2 option for a whopping **$3.99 a month**!

### VPS 2 Features

- 256 MB RAM
- 2 CPU Cores
- 30 GB Storage
- 15 mbits/second

All options include:

- Free 1xIPv4 IP & Free IPv6 IP addresses
- RAID Protected Storage
- Full Root Access
- VPS Control Panel
- Your Choice of Linux OS
- 24/7 Support
- TUN/TAP/PPP/FUSE support

After paying my VPS was provisioned and ready to go within 20 minutes and I had all my passwords to login and manage my various accounts. I ended up with 3 total.

### Accounts

1. Billing account for payments and upgrading/downgrading my VPS on the fly
2. Root account for the server itself
3. Control panel account for general VPS settings, resetting root password, and viewing bandwidth/memory/storage usage

I know I would never remember the control panel address so a simple redirect off the IP (http://0.0.0.0/cp), which I will remember, does the trick.

### VPSCheap.NET Control Panel

![VPSCheap.NET Control Panel](http://blainsmith.com/assets/img/vpscheapnet-cp.png)

Initial Impressions
------------------

After only using my new VPS for a few days I am very satisfied with my purchase. I have been able to do all that I wanted to do without having to bog down my laptop with VMs.

### Pros

- Wicked cheap with full root
- Apache works out of the box
- Installed Git, Nginx, and Node.js with apt-get no problem

### Cons

- Performing a mass upgrade or update to packages does take time since the network is throttled so I do this and walk away
- Difference accounts for billing and control panel access

I haven't had to request support so I can't speak to that. Support was low on my priority list considering I wanted to do most of the technical work myself for the learning experience. I may have to contact them regarding billing or something else out of my control, so if I do I will be sure to update this post with my experience.

Conclusion
------------------

If you want a low cost VPS then I would definitely recommend ponying up the cost of 2 iced coffees a month over at [VPSCheap.NET](http://vpscheap.net/).
