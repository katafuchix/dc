#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::Parser;                #XML::Parser���W���[��
$xml = new XML::Parser();
$xml->setHandlers(Start,\&handlerStart);
#�v�f�J�n�C�x���g�Ƀn���h���o�^
$xml->parsefile("sample.xml"); #XML�t�@�C�����
$xml->parse("<parsetest><test/></parsetest>"); #XML��������
sub handlerStart(){
  ($expat,$element) = @_; #�v�f�����擾
  print $element; #���ʁFsample test1 content content test2 parsetest test
  print "\n";
}
print "</PRE></BODY></HTML>";
