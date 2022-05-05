#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$string = "CGI/Perl";
print uc $string;      #結果：CGI/PERL
print "\n";
print ucfirst $string; #結果：CGI/Perl
print "\n";
print lc $string;      #結果：cgi/perl
print "\n";
print lcfirst $string; #結果：cGI/Perl
print "\n";
$string2 = "Perl";
print uc $string2;     #結果：PERL
print "\n";
print ucfirst $string2;#結果：Perl
print "\n";
print lc $string2;     #結果：perl
print "\n";
print lcfirst $string2;#結果：perl
print "</PRE></BODY></HTML>";
