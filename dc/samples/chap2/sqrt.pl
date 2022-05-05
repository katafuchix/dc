#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Math::BigFloat;
print sqrt 3;        #3Μ½ϋͺBΚF1.73205080756888
print "\n";
print sqrt sqrt 625; #625Μ4ζͺBΚF5
print "\n";
print nroot(625,4);  #625Μ4ζͺBΚF5
print "\n";
print nroot(8,3);    #8Μ3ζͺBΚF2
print "\n";
print nroot(100,3);  #100Μ3ζͺBΚF4.64158883361278
print "\n";
$float = new Math::BigFloat(100); #Math::BigFloatΆ¬
print $float->broot(3); #100Μ3ζͺ
 #ΚF4.641588833612778892410076350919446576551
sub nroot { $_[0] ** (1 / $_[1] )} #nζͺΦ
print "</PRE></BODY></HTML>";
