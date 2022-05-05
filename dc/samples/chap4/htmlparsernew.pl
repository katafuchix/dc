#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use HTML::Parser;
$parser = HTML::Parser->new(text_h => [\@array,"event,text"],
                            start_h => [\&handlerStart,"event,tagname"]);
#text�Astart�C�x���g�̃n���h���ɃT�u���[�`���A�z����w��
$parser->parse_file("sample.html");#HTML�ǂݍ���
foreach $i(@array){          #text�C�x���g�̌��ʂ����Ɏ擾
  print "event : $i->[0]\n"; #�z���0�Ԗڂ�event�B���ʁFtext
  print "text : $i->[1]\n";  #�z���1�Ԗڂ�text�B���ʁFSample 2
}
sub handlerStart{            #start�C�x���g�̃n���h���T�u���[�`��
  ($event,$tagname) = @_;    #�C�x���g���ƃ^�O���擾
  print $tagname;            #�J�n�����^�O�����o�́B���ʁFhtml body a img
}
print "</PRE></BODY></HTML>";
