#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$string = "CGI/Perl";
print uc $string;      #���ʁFCGI/PERL
print "\n";
print ucfirst $string; #���ʁFCGI/Perl
print "\n";
print lc $string;      #���ʁFcgi/perl
print "\n";
print lcfirst $string; #���ʁFcGI/Perl
print "\n";
$string2 = "Perl";
print uc $string2;     #���ʁFPERL
print "\n";
print ucfirst $string2;#���ʁFPerl
print "\n";
print lc $string2;     #���ʁFperl
print "\n";
print lcfirst $string2;#���ʁFperl
print "</PRE></BODY></HTML>";
