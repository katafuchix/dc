#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOM���W���[��
$xml = new XML::DOM::Parser();               #XML::DOM::Parser�C���X�^���X����
$document = $xml->parsefile("sample2.xml");   #XML�t�@�C���ǂݍ���
$newNode = $document->createElement("newTag"); #�v�f�쐬
$document->getDocumentElement->appendChild($newNode); #���[�g�v�f�ɒǉ�
print $document->toString(); #�o��
print "</PRE></BODY></HTML>";
