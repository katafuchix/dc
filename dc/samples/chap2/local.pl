#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$a = "global";        #�O���[�o���ϐ���`
{
  local $a = "local"; #���[�J���ϐ���`
  print $a;           #���ʁFlocal
}
print "\n";
print $a;             #�O���[�o���ϐ��͏��������Ȃ��B���ʁFglobal
print "\n";
{
  my $a = "my";       #���[�J���ϐ���`
  print $a;           #���ʁFmy
} 
print "</PRE></BODY></HTML>";
