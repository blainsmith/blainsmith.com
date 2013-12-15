---
layout: post
title: Case Insensitive Sorting in MongoDB
---
<p>I learned, while working on an app for myself, that MongoDB always sorts case sensitive. Boo. The order of sorting is:</p>

<ol><li>Numerics (0-9)</li>
<li>Upper Case Letters (A-Z)</li>
<li>Lower Case Letters (a-z)</li>
</ol><p>A few examples of the documents I have stored are:</p>

<pre><code>{ title: 'iRobot', tags: [...] }
{ title: 'Rambo', tags: [...] }
{ title: 'Con Air', tags: [...] }
</code></pre>

<p>Running sort on the <strong>title</strong> field&#8230;</p>

<pre><code>col.find().sort({ title: 1 })
</code></pre>

<p>yields&#8230;</p>

<ol><li>Con Air</li>
<li>Rambo</li>
<li>iRobot</li>
</ol><p>This doesn&#8217;t make sense to any human and since MongoDB doesn&#8217;t have the ability to specify case insensitive sorting I needed to set up a workaround. I added a sort field and set the value to all lower case when saving my documents.</p>

<pre><code>{ title: 'iRobot', stitle: 'irobot', tags: [...] }
{ title: 'Rambo', stitle: 'rambo', tags: [...] }
{ title: 'Con Air', stitle: 'con air', tags: [...] }
</code></pre>

<p>Now running I can run sort on the new <strong>stitle</strong> field&#8230;</p>

<pre><code>col.find().sort({ stitle: 1 })
</code></pre>

<p>and I get the correct human sorting&#8230;</p>

<ol><li>Con Air</li>
<li>iRobot</li>
<li>Rambo</li>
</ol><p>I hope that MongoDB will implement a way to do case insensitive sorting soon so extra fields aren&#8217;t needed.</p>