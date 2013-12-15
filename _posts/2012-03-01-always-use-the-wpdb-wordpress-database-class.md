---
layout: post
title: Always use the wpdb WordPress Database Class
---
<p>I just had a troubleshooting conference call with a developer and we ran into an issue with a site I installed into a WordPress Multisite instance. At first glance it looked like it was a low-level PHP error since a <code>foreach</code> function was throwing an Invalid Argument error.</p>

<p>Digging deeper the developer found that the code that he wrote was using a hard-coded table reference to <code>wp_options</code>. I told him we are using a multisite instance and the fix was clear. There is no <code>wp_options</code> table, but there is a <code>wp_8_options</code> table specific to the site.</p>

<p>He replace that reference with&#8230;</p>

<p><code>' . $wpdb-&gt;prefix . 'options</code></p>

<p>&#8230;and viola. We both learned a lesson from that.</p>

<p>Always use the <a href="http://codex.wordpress.org/Class_Reference/wpdb" target="_blank"><code>wpdb</code> class</a> to interact with the database so your code is as modular as possible.</p>