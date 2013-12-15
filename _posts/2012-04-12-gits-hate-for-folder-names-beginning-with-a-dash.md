---
layout: post
title: "Git's Hate for Folder Names Beginning with a Dash"
---
I was working on HTML wireframes last night for a client and I was using a <a href="http://blainsmith.com/post/929718789/the-dash-folder" target="_blank">”-” (dash) as a folder</a> name to store CSS, images, and JS. This also kept it ordered at the top of the file list.

<ul><li>client-website
					
<ul><li>-
					
<ul><li>css</li>
<li>style.css</li>
</ul></li>
<li>imgs
					
<ul><li>logo.png</li>
</ul></li>
<li>js
					
<ul><li>jquery.min.js</li>
</ul></li>
<li>favicon.ico</li>
<li>index.html</li>
</ul></li>
</ul>

You get the idea.
					
I needed to delete a file from the repo inside the dash folder so I tried:
					
<code>$ git rm -/imgs/logo.png</code>
					
However, git threw and error:
					
<code>error: unknown switch `/'</code>
					
After digging around for 20 minutes I realized that git must think the “-” was a parameter instead of a folder name. I tried escaping it and wrapping the path name in single quotes, but no luck. I ended up having to rename the folder to an underscore, but with the absolute path.
					
<code>$ git mv /Users/blainsmith/Sites/client-website/-/ /Users/blainsmith/Sites/client-website/_/</code>
					
Once I renamed it all was well. Now I know why it was changed to an underscore, just completely forgot.