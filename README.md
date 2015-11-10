makepages
=========

`makepages` is a small script for splitting a single large HTML file
into separate pages with a Continue button to progress through pages
and a menu, all formatted using Bootstrap. The idea is to make things
a little easier than creating pages from scratch.



The single page is designed to be normal viewable HTML. Additional
formatting is introduced using the following HTML comments:

    <!-- [page menu='xxx'] -->
    <!-- [/page] -->

These comments are wrapped around each page - the 'xxx' is the menu
item to access this page.

    <!-- [bigheading] -->
    <!-- [/bigheading] -->

Creates a big heading on the front page. This is expected to contain a
short <h1> heading, and maybe an <h2> heading and some <p> text.

The following are not yet implemented
-------------------------------------

    <!-- [callout] -->
    <!-- [/callout] -->

Creates a callout box

    <!-- [warning] -->
    <!-- [/warning] -->

Creates a warning box

    <!-- [important] -->
    <!-- [/important] -->

Creates an important box

    <!-- [note] -->
    <!-- [/note] -->

Creates a note box

    <!-- [information] -->
    <!-- [/information] -->

Creates an information box

    <!-- [popup text='xxx'] -->
    <!-- [/popup] -->

Creates a popup

    <!-- [help text='xxx'] -->
    <!-- [/help] -->

Creates a help text popup

    <!-- [accordion] -->
    <!-- [ai] -->
    <!-- [/ai] -->
    <!-- [/accordion] -->

Creates an accordion `ai` is analagous to `<li>`

    <!-- [instruction] -->
    <!-- [/instruction] -->

Creates an instruction that the reader might be expected to follow.

    <!-- [box title='xxx'] -->
    <!-- [/box] -->

Creates a boxed-out region of text (using a `panel`)

    <!-- [confirm script='xxx'] -->
    <!-- [/confirm] -->

Creates a confirmation box for a reader to confirm that they have done
something.












Note that any style information and the title are copied from the
normal HTML `<head>` section.