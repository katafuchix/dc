#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use HTML::Parser;
$parser = HTML::Parser->new();
$parser->handler(start => \&handlerStart,"event,tagname");
$parser->parse_file("sample.html");#HTML�ǂݍ��݉��
$parser->parse("<head></head>");   #��������
sub handlerStart{            #start�C�x���g�̃n���h���T�u���[�`��
  ($event,$tagname) = @_;    #�C�x���g���ƃ^�O���擾
  print $tagname;            #�J�n�����^�O�����o�́B���ʁFhtml body a img head
  print "\n";
  if($tagname eq "head"){    #head�^�O�𔭌�������
    $parser->eof();          #��͏I��
  }
}
print "</PRE></BODY></HTML>";
