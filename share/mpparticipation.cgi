#!/usr/bin/perl
        use strict;
        use CGI;
        $|=1;

        my $cgi = new CGI;

        my $name      = $cgi->param('name');
        my $email     = $cgi->param('email');
        my $confirmed = $cgi->param('confirmed');
        
        print $cgi->header();
        
        my $ok = 0;
        if($confirmed)
        {
            if(StoreParticipant($name, $email))
            {
                print <<__EOFX;
                <h4>Your details have been saved as:</h4>
                    <table>
                    <tr><th>Name:</th><td>$name</td></tr>
                    <tr><th>Email:</th><td>$email</td></tr>
                    </table>
__EOFX
                $ok = 1;
            }
        }

        if(!$ok)
        {
            print <<__EOFX;
            <h4>An error occurred</h4>

                <p>You need to reload this page and tick the confirmation box. Make
                sure you do not have any non-standard characters (particularly '#') in your name or email
                address.
                </p>
                <pre>
$name
$email
                </pre>
__EOFX
        }

        sub StoreParticipant
        {
            my($name, $email) = @_;
            
            my $user = "${name}_$email";
            $user =~ s/[^A-Za-z0-9]/_/g;    # Remove odd chars and whitespace
            $user =~ s/_+/_/g;              # Collapse multiple _ to one
            $user = "./participants/${user}.txt";
            my $time = GetTime();

            if(open(my $fp, '>', $user))
            {
                print $fp "$name\t$email\t$time\n";
                close $fp;
            }
            else
            {
                return(0);
            }
            return(1);
        }

        sub GetTime
        {
            my($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
            $year += 1900;
            my $timeStr = sprintf("%02d-%02d-%04d:%02d:%02d:%02d",
                                  $mday,$mon,$year,
                                  $hour,$min,$sec);
            return($timeStr);
        }
