#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use HTML::Parser;
$parser = HTML::Parser->new(start_h => [\&handlerTag,"tagname"]);
$parser->parse("<emptyTag/>");#�������́B�^�O����emptyTag/
$parser->xml_mode(1);         #XML���[�h�L��
$parser->parse("<emptyTag/>");#�������́B�^�O����emptyTag
sub handlerTag{           #start�C�x���g�̃n���h���T�u���[�`��
  print @_[0];            #�^�O�����o��
  print "\n";
}
print "</PRE></BODY></HTML>";
