#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use HTML::PullParser;
$p = HTML::PullParser->new(file => "sample.html", #�t�@�C������ǂݍ���
       start => "tagname");  #start�C�x���g��⑫�B�^�O���擾
while ($t = $p->get_token()) { #���ɃC�x���g���擾���Ă���
  print $t->[0]; #�^�O�����o�́B���ʁFhtml body a img
  print "\n";
}
print "</PRE></BODY></HTML>";
