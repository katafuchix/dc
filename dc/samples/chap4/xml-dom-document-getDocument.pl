#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOM���W���[��
$xml = new XML::DOM::Parser();               #XML::DOM::Parser�C���X�^���X����
$document = $xml->parsefile("sample.xml");   #XML�t�@�C���ǂݍ���
$root = $document->getDocumentElement();     #���[�g�v�f�̎擾
print $root->getTagName();                   #�v�f���o�́B���ʁFsample
print "</PRE></BODY></HTML>";
