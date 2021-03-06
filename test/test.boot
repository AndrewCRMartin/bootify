<html>
<head>
<title>Bootify test</title>
<style type='text/css'>
pre, samp {background: #DDDDDD;
      border: 1pt solid #CCCCCC;
      border-radius: 5pt;
      padding: 1pt;
}
pre {padding: 5pt 20pt;}
</style>
</head>

<body>
<!-- [page menu='Home'] -->

<!-- [bigheading] -->
<h1>Bootify</h1>
<h2>A script to generate a set of HTML pages</h2>
<p>Bootify generates attractive Bootstrap pages from a single master HTML file
which includes additional markup using metatags.</p>
<!-- [/bigheading] -->

<h2>bootify</h2>

<p>
bootify is a small script for splitting a single large HTML file
into separate pages with a Continue button to progress through pages
and a menu, all formatted using Bootstrap. The idea is to make things
a little easier than creating pages from scratch.
</p>

<p>
Formatting is created by using metatags buried in HTML comments of the form:
</p>
<pre>
&lt;-- [tag] --&gt;
&lt;-- [/tag] --&gt;
</pre>

<p>Each page is created using:</p>
<pre>
&lt;-- [page menu='xxx'] --&gt;
&lt;-- [/page] --&gt;
</pre>

<!-- [/page] -->

<!-- [page menu='Examples'] -->

<h2>This page contains examples</h2>

<!-- [information] -->
<p>This is for information</p>
<!-- [/information] -->

<!-- [warning] -->
<p>This is a warning</p>
<!-- [/warning] -->

<!-- [callout] -->
<p>This is a callout</p>
<!-- [/callout] -->

<!-- [important] -->
<p>This text is important</p>
<!-- [/important] -->

<!-- [note] -->
<p>This is a note</p>
<!-- [/note] -->

<p>This is a <!-- [popup text='more information!'] --> popup <!-- [/popup] --></p>

<p>This is a <!-- [help text='more information!'] --> help popup <!-- [/help] --></p>

<!-- [instruction] -->
<p>This is an instruction</p>
<!-- [/instruction] -->

<p>This is a link appearing in a different tab/page:
<!-- [link] -->http://www.bioinf.org.uk<!-- [/link] -->
</p>

<!-- [accordion] -->
<!-- [ai title='Section 1' open='true'] -->
<p>This is section 1</p>
<!-- [/ai] -->
<!-- [ai title='Section 2'] -->
<p>This is section 2</p>
<!-- [/ai] -->
<!-- [ai title='Section 3'] -->
<p>This is section 3</p>
<!-- [/ai] -->
<!-- [/accordion] -->

<!-- [box title='Box title'] -->
<p>This is a boxed region</p>
<!-- [/box] -->

<!-- [quiz] -->
<!--
# Example input file

#T: AM2C36 Practical 1
#S: Proteins and Amino Acids

Q: Which of the following is <i>not</i> a role of proteins?
A: Catalysis
C: Creating a membrane
A: Enabling motion
A: Sensors
E: Membranes may contain proteins, but are formed from lipds

Q: Which of these proteins is a good example of an enzyme?
C: Catalase
A: Myoglobin

Q: How many standard amino acids are there?
A: 18
C: 20
A: 21
A: 24
N: Some amino acids undergo post-translational modification
N: (phospho-tyrosine and phospho-serine. Glutamate at the N-terminus 
N: of a protein can cyclize to form 'PCA' (L-2-Pyrrolidone-5-Carboxylic 
N: Acid, or L-Pyroglutamic Acid)

Q: What is the simplest amino acid with a sidechain?
A: Glycine
C: Alanine
A: Proline
-->
<!-- [/quiz] -->

<!-- [confirm] -->
Please confirm that you have completed this work to the best of your ability.
<!-- [/confirm] -->

<p>View a <a href='test.boot'>printable version</a> of the full set of pages.</p>

<!-- [/page] -->

</body>
</html>
