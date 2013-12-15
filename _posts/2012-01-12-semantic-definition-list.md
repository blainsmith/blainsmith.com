---
layout: post
title: Semantic Definition List
---
<p>I have always felt awkward using the definition list <code><a href="http://www.w3.org/TR/html5/grouping-content.html#the-dl-element" target="_blank">DL</a></code> markup because of its lack of structure. Especially when using the definition term <code><a href="http://www.w3.org/TR/html5/grouping-content.html#the-dt-element" target="_blank">DT</a></code> and definition description <code><a href="http://www.w3.org/TR/html5/grouping-content.html#the-dd-element" target="_blank">DD</a></code> tags. They have no association to one another other than the order they appear.</p>

<script src="https://gist.github.com/2406260.js?file=standard.html"></script><p>You can see how there are 3 groups of terms and descriptions, but semantically they are not grouped together. I propose using a pre-existing list-related element to group each together. The list item <code><a href="http://www.w3.org/TR/html5/grouping-content.html#the-li-element" target="_blank">LI</a></code> tags makes the most semantic sense even though its only allowed with ordered and unordered lists.</p>

<script src="https://gist.github.com/2406260.js?file=proposed.html"></script><p>Now each term and description are grouped together as a single entity while still retaining the semantics of the definition list.</p>

<p>DISCLAIMER: This is a proposed solution to a problem I see, but it is not valid HTML to use. Please do not use this!</p>