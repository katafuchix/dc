#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY>\n";
foreach my $key( keys %ENV ){
    print "$key: $ENV{$key}<BR>\n";
}
print "</BODY></HTML>", "\n"; 
