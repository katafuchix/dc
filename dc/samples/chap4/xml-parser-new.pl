#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::Parser;                #XML::Parser���W���[��
$xml = new XML::Parser(Handlers => {Init => \&handlerInit,
                                    Start => \&handlerStart});
#��͊J�n�C�x���g�A�v�f�J�n�C�x���g�Ƀn���h���o�^
$sample = $xml->parsefile("sample.xml");           #XML�ǂݍ���

sub handlerInit(){
  print "Init handler\n"; #�J�n���ɌĂяo�����B���ʁFInit handler
}
sub handlerStart(){
  ($expat,$element) = @_; #�v�f�����擾
  print $element; #���ʁFsample test1 content content test2
  print "\n";
}
print "</PRE></BODY></HTML>";
