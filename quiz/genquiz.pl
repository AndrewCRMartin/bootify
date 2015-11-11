#!/usr/bin/perl  -s
#*************************************************************************
#
#   Program:    genquiz
#   File:       genquiz.pl
#   
#   Version:    V1.2
#   Date:       26.09.13
#   Function:   Generate a JavaScript quiz
#   
#   Copyright:  (c) Dr. Andrew C. R. Martin 2003-2013
#   Author:     Dr. Andrew C. R. Martin
#   Address:    Biomolecular Structure & Modelling Unit,
#               Department of Biochemistry & Molecular Biology,
#               University College,
#               Gower Street,
#               London.
#               WC1E 6BT.
#   EMail:      andrew@bioinf.org.uk
#               
#*************************************************************************
#
#   This program is not in the public domain, but it may be copied
#   according to the conditions laid out in the accompanying file
#   COPYING.DOC
#
#   The code may be modified as required, but any modifications must be
#   documented so that the person responsible can be identified. If 
#   someone else breaks this code, I don't want to be blamed for code 
#   that does not work! 
#
#   The code may not be sold commercially or included as part of a 
#   commercial product except as described in the file COPYING.DOC.
#
#*************************************************************************
#
#   Description:
#   ============
#   A little script to generate a web page for a JavaScript quiz
#   The JavaScript is based on a script downloaded from
#   http://javascript.internet.com/miscellaneous/javascript-quiz.html
#   and available for free use.
#
#*************************************************************************
#
#   Usage:
#   ======
#   Input to this script is as follows:
#   --------------------------------------------------------------------
#   T: AM2C36 Practical 1
#   S: Proteins and Amino Acids
#   L: /teaching/ucl/ucl.css
#   
#   Q: Which of the following is <i>not</i> a role of proteins?
#   A: Catalysis
#   C: Creating a membrane
#   A: Enabling motion
#   A: Sensors
#   E: Membranes may contain proteins, but are formed from lipds
#   
#   Q: Which of these proteins is a good example of an enzyme?
#   C: Catalase
#   A: Myoglobin
#   
#   Q: How many standard amino acids are there?
#   A: 18
#   C: 20
#   A: 21
#   A: 24
#   N: Some amino acids undergo post-translational modification
#   N: (phospho-tyrosine and phospho-serine. Glutamate at the N-terminus 
#   N: of a protein can cyclize to form 'PCA' (L-2-Pyrrolidone-5-Carboxylic 
#   N: Acid, or L-Pyroglutamic Acid)
#   
#   Q: What is the simplest amino acid with a sidechain?
#   A: Glycine
#   C: Alanine
#   A: Proline
#   --------------------------------------------------------------------
#   Lines are as follows...
#   T: title (optional)
#   S: subtitle (optional)
#   L: Link to a CSS style sheet
#   Q: question
#   A: incorrect answer
#   C: correct answer
#   E: explanation when a wrong answer is given (optional)
#   N: notes given for a wrong or right answer (optional)
#   Note N: and E: may span multiple lines
#
#*************************************************************************
#
#   Revision History:
#   =================
#   V1.0  01.12.03 Original
#   V1.1  10.11.04 HTML is now XHTML1.1 compliant and added CSS link 
#                  support
#   V1.2  26.09.13 Added -n option
#
#*************************************************************************
use strict;

$::answer = "";
$::title  = "";
$::css    = "";

my $doHTMLHeader = (defined($::n)?0:1);

UsageDie() if(defined($::h));
ReadFile();

WriteHTMLHeader($::title, $::css) if($doHTMLHeader);

WriteJavaScript($::answer, $::css, 
            \@::correct, \@::explanations, \@::notes);
WriteQuiz($::title, $::subtitle);

WriteHTMLFooter() if($doHTMLHeader);


##########################################################################
sub WriteHTMLHeader
{
    my($title, $css) = @_;

    $title = "Quiz" if(!defined($title));

    print <<__EOF;
<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html>
<head>
<title>$title</title>
<!-- JAVASCRIPT QUIZ FRAMEWORK FROM 
     http://javascript.internet.com/miscellaneous/javascript-quiz.html
-->
$css

</head>

__EOF
}
##########################################################################
sub WriteHTMLFooter
{
    print "\n</body>\n</html>\n";
}
##########################################################################
sub UsageDie
{
    print <<__EOF;

genquiz V1.2 Dr. Andrew C.R. Martin, 2003-2013

Usage: genquiz [-answer] [-n] quiz.in >quiz.html
       -answer  Show correct answers in the results of the quiz
       -n       Do not print HTML header and footer

Generates a JavaScript-based quiz - see the program for explanation
of the input format

__EOF

    exit(0);
}

##########################################################################
sub WriteQuiz
{
    my($title, $subtitle) = @_;
    my($qnum, $q, $anum, $a);

    print "<body>\n";
    print "<h1>$title</h1>\n\n" if($title ne "");
    print "<h2>$subtitle</h2>\n" if($subtitle ne "");
    print "<form action='null'>\n";
    for($qnum = 1; $qnum <@::questions; $qnum++)
    {
        print "<p>\n";
        $q = $::questions[$qnum];
        print "<b>${qnum}. $q</b><br />\n";
        $anum = 'a';
        foreach $a (@{$::answers[$qnum]})
        {
#            print "<input type='radio' name='q$qnum' value='$anum' onclick='Engine($qnum, this.value)' /> $anum) $a<br />\n";
            print "<input type='radio' name='q$qnum' value='$anum' onclick='Engine($qnum, this.value)' /> $a<br />\n";
            $anum++;
        }
        print "</p>\n";
    }

    print "<p><input type='button' onclick='Score()' value='How did I do?' /></p>\n";
    print "</form>\n";

}

##########################################################################
sub ReadFile
{
    my($qnum, $anum, $c);

    $qnum = 0;
    $anum = 0;
    while(<>)
    {
        chomp;
        s/^\s+//;
        if(/^T:\s+(.*)/)        # Match the T: line for the title
        {
            $::title = $1;
        }
        if(/^L:\s+(.*)/)        # Match the L: line for CSS link
        {
            $::css = "<link rel='stylesheet' href='$1' />";
        }
        if(/^S:\s+(.*)/)        # Match the S: line for the subtitle
        {
            $::subtitle = $1;
        }
        elsif(/^Q:\s+(.*)/)     # Match the Q: line for a question
        {
            $qnum++;
            $::questions[$qnum] = $1;
            $anum = 0;
        }
        elsif(/^([AC]):\s+(.*)/)# Match the A: or C: line for an answer
        {
            push @{$::answers[$qnum]}, $2;
            push @::correct, $anum if($1 eq "C");
            $anum++;
        }
        elsif(/^E:\s+(.*)/)     # Match the E: for explanation
        {
            $::explanations[$qnum] .= $1 . " ";
        }
        elsif(/^N:\s+(.*)/)     # Match the N: for notes
        {
            $::notes[$qnum] .= $1 . " ";
        }
    }

    # Fix the 'corrects' to a....z
    foreach $c (@::correct)
    {
        $c =~ tr/[0123456789]/[abcdefghij]/;
    }
}

##########################################################################
sub WriteJavaScript
{
    my($giveAnswer, $css, $answers_p, $explanations_p, $notes_p) = @_;
    my($nques, $answer, $expl, $j, $note);

    print <<__EOF;
<script type="text/javascript">

<!-- This script and many more are available free online at -->
<!-- The JavaScript Source!! http://javascript.internet.com -->

<!-- Begin
var ans = new Array;
var done = new Array;
var yourAns = new Array;
var explainAnswer = new Array;
var notes = new Array;

__EOF

### Print the answers and explanations
    $nques=0;
    foreach $answer (@{$answers_p})
    {
        printf "ans[%d] = \"$answer\";\n", $nques+1;
        $nques++;
    }
    print "\n";

    for($j=1; $j<=$nques; $j++)
    {
        $expl = ${$explanations_p}[$j];
        printf "explainAnswer[%d] = \"$expl\";\n", $j;
    }
    print "\n";
    
    for($j=1; $j<=$nques; $j++)
    {
        $note = ${$notes_p}[$j];
        printf "notes[%d] = \"$note\";\n", $j;
    }
    print "\n";
    
### Continue with the header

    print <<__EOF;
function Engine(question, answer) {
yourAns[question]=answer;
}
__EOF

    if($giveAnswer)
    {
    print <<__EOF;
function Score()
{
   var score = 0;
   var answerText = "";
   for(i=1;i<=$nques;i++)
   {
      answerText=answerText+"<p><i>Question "+i+":</i><br />\\n";
      if(ans[i]!=yourAns[i])
      {
         answerText=answerText+"    The correct answer was "+ans[i]+"</p>\\n<p>"+explainAnswer[i]+"</p>\\n<p>"+notes[i]+"</p><hr />\\n";
      }
      else
      {
         answerText=answerText+"    Correct! </p>\\n<p>"+notes[i]+"</p><hr />\\n";
         score++;
      }
   }
__EOF
    }
    else
    {
    print <<__EOF;
function Score()
{
   var score = 0;
   var answerText = "";
   for(i=1;i<=$nques;i++)
   {
      answerText=answerText+"<p><i>Question "+i+":</i> ";
     if(ans[i]!=yourAns[i])
     {
        answerText=answerText+"    Try again!</p>\\n<p>"+explainAnswer[i]+"</p>\\n<p>"+notes[i]+"</p><hr />\\n";
     }
     else
     {
        answerText=answerText+"    Correct!</p>\\n<p>"+notes[i]+"</p><hr />\\n";
        score++;
     }
   }
__EOF
}

    print <<__EOF;
   answerText=answerText+"<p align='center'><b>Your total score was: "+score+" out of $nques</b></p>\\n";

// now score the user
   answerText=answerText+"<p align='center'>";
   if(score==$nques)
   {
      answerText=answerText+"Excellent! You got them all right";
   }
   else if(score<$nques*0.5)
   {
      answerText=answerText+"You need to learn a lot more - try again!";
   }
   else if(score<$nques*0.70)
   {
      answerText=answerText+"You need more practice - try again";
   }
   else 
   {
      answerText=answerText+"Good try - see if you can get them all";
   }
   answerText=answerText+"<\p>";

   ShowResults(answerText);

}

function ShowResults(text)
{
    win = window.open("", 'quiz_results', "toolbar=no,location=no,directories=no,status=no,menubar=no, scrollbars=yes,resizable=no,width=640,height=400");
    win.document.writeln("<html><head><title>How did I do?</title>$css</head><body>");
    win.document.writeln("<h1>How did I do?</h1>");
    win.document.writeln("<form action='null'><p align='right'><input type='button' onclick='window.close()' value='Close Window' /></p></form>");

    win.document.writeln(text);
    win.document.writeln("<form action='null'><p align='right'><input type='button' onclick='window.close()' value='Close Window' /></p></form>");
    win.document.writeln("</body></html>");
    win.document.close();
}

//  End -->
</script>

<!-- ************************************************************************  -->

__EOF

}


