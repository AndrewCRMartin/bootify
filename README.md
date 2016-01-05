bootify and genquiz
===================

bootify
-------

`bootify` is a small script for splitting a single large HTML file
into separate pages with a Continue button to progress through pages
and a menu, all formatted using Bootstrap. The idea is to make things
a little easier than creating pages from scratch.

The single page is designed to be normal viewable HTML. 

The additional markup is inserted using 'metatags' that are contained
in HTML comments. The metatags are contained in `[]` rather than `<>`:

    <!-- [tagname attribute='value'] -->
    ...Content...
    <!-- [/tagname] -->

*NOTE* - every metatag must be contained on a single line. i.e. you must do

    <!-- [tagname attribute='this is a very long attribute value that you might want to split'] -->

*NOT*

    <!-- [tagname attribute='this is a very long 
                             attribute value that 
                             you might want to split']
    -->


### Creating pages

Each page is separated with

    <!-- [page menu='xxx'] -->
    <!-- [/page] -->

These comments are wrapped around each page - the 'xxx' is the menu
item to access this page.



### The title (index) page

The title (index) page is expected to have a big heading. This should
contain a short `<h1>` heading (which will also be used as a 'home' menu
item on each page), and maybe an `<h2>` heading and some `<p>` text.

    <!-- [bigheading] -->
    <!-- [/bigheading] -->



### Information and callouts

A callout box

    <!-- [callout] -->
    <!-- [/callout] -->

A warning box

    <!-- [warning] -->
    <!-- [/warning] -->

An important box

    <!-- [important] -->
    <!-- [/important] -->

A note box

    <!-- [note] -->
    <!-- [/note] -->

An information box

    <!-- [information] -->
    <!-- [/information] -->

An instruction that the reader might be expected to follow

    <!-- [instruction] -->
    <!-- [/instruction] -->



### Popups

You can create a popup link within the text with

    <!-- [popup text='xxx'] -->
    <!-- [/popup] -->

Or, if it's specifically a help popup where you want a question mark glyph, then:

    <!-- [help text='xxx'] -->
    <!-- [/help] -->

*Don't forget that you cannot split the metatag so you can't put line
breaks in the associated text.*


### Accordions and box-outs

You can create an accordion as follows - `ai` is analagous to `<li>`

    <!-- [accordion] -->
    <!-- [ai title='xxx'] -->
    <!-- [/ai] -->
    <!-- [/accordion] -->

A box has similar styling to an accordion but doesn't shrink and expand

    <!-- [box title='xxx'] -->
    <!-- [/box] -->

### Links

You can create a link to another web page that will simply use the URL
for the clickable text and for the link and will open in a new
tab/page called 'links':

    <!-- [link] -->http://www.bioinf.org.uk<!-- [/link] -->

*Note: both the opening and closing tags this must appear on a single input line.* 

This will be translated into:

    <a href='http://www.bioinf.org.uk' target='links'>http://www.bioinf.org.uk</a>


### Confirmation box

This is designed to provide a box where a user of the page can enter a
name and email and confirm something - e.g. that they have done an
exercise to the best of their ability or that they have read terms and
conditions.

    <!-- [confirm script='xxx'] -->
    I confirm that I have done the tutorial to the best of my ability
    <!-- [/confirm] -->

A `participants` directory will be created containing a file for each
user. This file contains the name and email information and the time
at which the clicked the confirm box.

### Quizes

You can also embed a JavaScript quiz in a page using:

    <!-- [quiz] -->
    <!-- [/quiz] -->

See the `genquiz` documentation below for the format used for the quiz.


### Additional style information

If present, the contents of the first `<style>` tag in the HTML
`<head>` section will be copied onto each page.



### HTML title

If present (it should be!), the contents of the `<title>` tag in the
HTML `<head>` section will be copied onto each page.



### Favicon

You can place a file `favicon.png` in the directory if you wish to set
the favourites icon on each page.



genquiz
-------

`genquiz` is another small script for generating JavaScript quizes as
standalone web pages, or as a piece of HTML that can be embedded in an
HTML page, perhaps using the Perl template toolkit.

The JavaScript comes from the JavaScript quiz framework at
http://javascript.internet.com/miscellaneous/javascript-quiz.html


Type 

    genquiz -h

for help, or

    genquiz -example

to generate an example input file.

    T: title (optional)
    S: subtitle (optional)
    L: Link to a CSS style sheet
    Q: question
    A: incorrect answer
    C: correct answer
    E: explanation when a wrong answer is given (optional)
    N: notes given for a wrong or right answer (optional)

Note: `N:` and `E:` may span multiple lines

