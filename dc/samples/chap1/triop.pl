#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$a = 1;
$b = 2;
$c = 3;
print ($a ? $b : $c); #$a���^�Ȃ̂�$b��Ԃ��B���ʁF2
print "\n";
if($a){               #if�`else���œ��l�̏������s��
  print $b;           #$a���^�Ȃ̂�$b���o�́B���ʁF2
}else{
  print $c;
}
print "\n";
($a ? $b : $c) = 4;   #���Ӓl�Ƃ��Ďg�p�B$a���^�Ȃ̂�$b��4�����B
print $b;             #���ʁF4
print "</PRE></BODY></HTML>";
