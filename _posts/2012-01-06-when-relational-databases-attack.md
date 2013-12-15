---
layout: post
title: When Relational Databases Attack!
---
<p>I have been working with relational databases for years and they serve a great purpose, but with the new kid on the block, NoSQL, there is no reason why some data stores should still be using relational databases.</p>

<p>I have worked on a system that stores all person directory information. This information includes things like</p>

<ul><li>Name,</li>
<li>Email,</li>
<li>Job Code,</li>
<li>Office Location,</li>
<li>Phone Numbers,</li>
<li>etc.</li>
</ul><p>Obviously this is a very object oriented structure since a single person can have multiple email address, numbers, and so on so initially a relational database would make sense to use. Eventually you would end up with tables for each object. However, this is possible:</p>

<p><img src="http://media.tumblr.com/tumblr_lxe9o6YyXs1qac9ww.png" alt="Tablitis"/></p>

<p>Now you might be saying to yourself:</p>

<blockquote>
  <p>What’s wrong with that?</p>
</blockquote>

<p>But, I continually say:</p>

<blockquote>
  <p>Seriously, what the fuck!?</p>
</blockquote>

<p>Technically there is nothing wrong with this approach since all the data is normalized and related to each other. I do have ask though, is a relational database really the best method for storing this type of data? I don’t think it is because of some very basic points.</p>

<ol><li>Computational queries will never be run against this data on a consistant basis</li>
<li>Most of the time, whenever a person is requested I want ALL of their attributes</li>
<li>This type of data has high read/low write needs</li>
</ol><p>This is where a NoSQL solution would shine! Why not represent this data as it should be, in object notation.</p>

<pre>
{
    "person":
    {
        "first_name":"Blain",
        "last_name":"Smith",
        "numbers":
        {
            "phone":"111-222-3333",
            "mobile":"333-222-1111",
            "fax":"555-333-1111"
        },
        "address":
        {
            "home":
            {
                "address_1":"12 Somewhere Street",
                "address_2":"",
                "city":"Ballston Spa",
                "state":"New York",
                "postal_code":"12020",
                "country":"United States of America"
            },
            "work":
            {
                "address_1":"12 Somewhere Street",
                "address_2":"",
                "city":"Boston",
                "state":"Massachusetts",
                "postal_code":"02115",
                "country":"United States of America"
            }
        }
    }
}
</pre>

<p>Ahhhh, I like that much better. Now, the current process that is used to get this data is:</p>

<ol><li>The central relational data store runs a script</li>
<li>The script generates a single differential XML file of the data, encrypts it, and stores on an FTP site</li>
<li>A local script I wrote checks the FTP sites for a new XML file, downloads it, then decrypts it</li>
<li>Another bulk insert script runs by combining the XML file and an XSD file which makes the XML to my relational database tables</li>
<li>Once completed it does UPDATEs and DELETEs</li>
</ol><p>A few problems I see with this process:</p>

<ul><li>Separates copies of the central data store are being created which is prone to data inconsistency if the daily scripts fail</li>
<li>XML files are very bloated with tags that make the files very large during transfer</li>
<li>XML files also take longer to process because of that bloat</li>
</ul><p>Now if all this data was stored with a NoSQL database then a lot of this processing overhead can be eliminated.</p>

<ul><li>The data can stay central and an API can be made available for querying since NoSQL is great at high read situations</li>
<li>Since there is an API you never have to read/process data you don’t need</li>
<li>Since the data rarely changes there is no impact to the write process of the data</li>
<li>XML files turn into JSON responses which are much more light weight</li>
</ul><p>I plan to try and run some real world tests with these ideas and get some real numbers on processing time, storage space, and bandwidth usage…when I have some free time!</p>
