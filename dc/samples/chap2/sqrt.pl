#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use Math::BigFloat;
print sqrt 3;        #3�̕������B���ʁF1.73205080756888
print "\n";
print sqrt sqrt 625; #625��4�捪�B���ʁF5
print "\n";
print nroot(625,4);  #625��4�捪�B���ʁF5
print "\n";
print nroot(8,3);    #8��3�捪�B���ʁF2
print "\n";
print nroot(100,3);  #100��3�捪�B���ʁF4.64158883361278
print "\n";
$float = new Math::BigFloat(100); #Math::BigFloat����
print $float->broot(3); #100��3�捪
 #���ʁF4.641588833612778892410076350919446576551
sub nroot { $_[0] ** (1 / $_[1] )} #n�捪�֐�
print "</PRE></BODY></HTML>";
