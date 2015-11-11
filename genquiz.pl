#!/usr/bin/perl  -s
#*************************************************************************
#
#   Program:    genquiz
#   File:       genquiz.pl
#   
#   Version:    V2.0
#   Date:       11.11.15
#   Function:   Generate a JavaScript quiz
#   
#   Copyright:  (c) Dr. Andrew C. R. Martin 2003-2015
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
#   V1.0  11.11.15 Moved the code that does the work out into genquiz.pm
#
#*************************************************************************
# Add the path of the executable to the library path
use FindBin;
use lib $FindBin::Bin;
# Or if we have a bin directory and a lib directory
#use Cwd qw(abs_path);
#use FindBin;
#use lib abs_path("$FindBin::Bin/../lib");
use strict;
use genquiz;

$::title  = "";
$::css    = "";

my $doHTMLHeader = (defined($::n)?0:1);
my $giveAnswer   = (defined($::answer)?1:0);

UsageDie() if(defined($::h));
ExampleDie() if(defined($::example));

my @lines = ReadFile();

genquiz::ParseQuiz(@lines);

my $html = '';

$html .= genquiz::WriteHTMLHeader($::title, $::css) if($doHTMLHeader);
$html .= genquiz::WriteJavaScript($giveAnswer, $::css, 
                                  \@::correct, \@::explanations, \@::notes);
$html .= genquiz::WriteQuiz($::title, $::subtitle);
$html .= genquiz::WriteHTMLFooter() if($doHTMLHeader);

print $html;


##########################################################################
sub ReadFile
{
    my @lines = ();
    while(<>)
    {
        push @lines, $_;
    }
    return(@lines);
}

##########################################################################
sub UsageDie
{
    print <<__EOF;

genquiz V2.0 Dr. Andrew C.R. Martin, 2003-2015

Usage: genquiz [-answer] [-n] quiz.in >quiz.html
       --or--
       genquiz -example > quiz.in

       -answer  Show correct answers in the results of the quiz
       -n       Do not print HTML header and footer
       -example Generate an example input file

Generates a JavaScript-based quiz. The input format is as follows:

T: title (optional)
S: subtitle (optional)
L: Link to a CSS style sheet
Q: question
A: incorrect answer
C: correct answer
E: explanation when a wrong answer is given (optional)
N: notes given for a wrong or right answer (optional)
Note N: and E: may span multiple lines

Run 
   genquiz.pl -example
to create an example input file

__EOF

    exit(0);
}

sub ExampleDie
{
    print <<__EOF;
# Example input file

T: AM2C36 Practical 1
S: Proteins and Amino Acids
L: /teaching/ucl/ucl.css

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
__EOF

    exit(0);
}
