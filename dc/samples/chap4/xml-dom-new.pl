#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOM���W���[��
$xml = new XML::DOM::Parser();               #XML::DOM::Parser�C���X�^���X����
$document = $xml->parsefile("sample.xml");   #XML�t�@�C���ǂݍ���
print $document->getDocumentElement->getTagName();
#���[�g�v�f�̃^�O���o�́B���ʁFsample
print "\n";
$document2 = $xml->parse("<test><test2/></test>"); #XML������ǂݍ���
print $document2->getDocumentElement->getTagName();
#���[�g�v�f�̃^�O���o�́B���ʁFtest
print "</PRE></BODY></HTML>";
