package genquiz;
use strict;

##########################################################################
sub WriteHTMLHeader
{
    my($title, $css) = @_;

    $title = "Quiz" if($title eq "");

    my $html = "<?xml version='1.0' encoding='iso-8859-1'?>
<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.1//EN'
    'http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd'>

<html>
<head>
<title>$title</title>
<!-- JAVASCRIPT QUIZ FRAMEWORK FROM 
     http://javascript.internet.com/miscellaneous/javascript-quiz.html
-->
$css

</head>
";

    return($html);
}

##########################################################################
sub WriteHTMLFooter
{
    return("\n</body>\n</html>\n");
}

##########################################################################
sub WriteQuiz
{
    my($title, $subtitle) = @_;
    my($qnum, $q, $anum, $a);

    my $html = '';

    $html .= "<body>\n";
    $html .= "<h1>$title</h1>\n\n" if($title ne "");
    $html .= "<h2>$subtitle</h2>\n" if($subtitle ne "");
    $html .= "<form action='null'>\n";
    for($qnum = 1; $qnum <@::questions; $qnum++)
    {
        $html .= "<p>\n";
        $q = $::questions[$qnum];
        $html .= "<b>${qnum}. $q</b><br />\n";
        $anum = 'a';
        foreach $a (@{$::answers[$qnum]})
        {
            $html .= "<input type='radio' name='q$qnum' value='$anum' onclick='QuizEngine($qnum, this.value)' /> $a<br />\n";
            $anum++;
        }
        $html .= "</p>\n";
    }

    $html .= "<p><input type='button' onclick='Score()' value='How did I do?' /></p>\n";
    $html .= "</form>\n";

    return($html);
}

##########################################################################
sub ParseQuiz
{
    my(@lines) = @_;

    my($qnum, $anum, $c);

    $qnum = 0;
    $anum = 0;
    foreach $_ (@lines)
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

    my $html = <<__EOF;
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
        $html .= sprintf("ans[%d] = \"$answer\";\n", $nques+1);
        $nques++;
    }
    $html .= "\n";

    for($j=1; $j<=$nques; $j++)
    {
        $expl = ${$explanations_p}[$j];
        $html .= sprintf("explainAnswer[%d] = \"$expl\";\n", $j);
    }
    $html .= "\n";
    
    for($j=1; $j<=$nques; $j++)
    {
        $note = ${$notes_p}[$j];
        $html .= sprintf("notes[%d] = \"$note\";\n", $j);
    }
    $html .= "\n";
    
### Continue with the header

    $html .= <<__EOF;
function QuizEngine(question, answer) {
yourAns[question]=answer;
}
__EOF

    if($giveAnswer)
    {
        $html .= <<__EOF;
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
        $html .= <<__EOF;
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

   $html .= <<__EOF;
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

    return($html);

}


1;
