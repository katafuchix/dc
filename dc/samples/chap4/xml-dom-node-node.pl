#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOM���W���[��
$xml = new XML::DOM::Parser();               #XML::DOM::Parser�C���X�^���X����
$document = $xml->parsefile("sample.xml");   #XML�t�@�C���ǂݍ���
print $document->getNodeName(); #Document�N���X��getNodeName�͕������Ԃ�
 #���ʁF#document
print "\n";
$node = $document->getDocumentElement();     #���[�g�v�f�擾
print $node->getNodeName(); #Element�N���X��getNodeName�̓^�O����Ԃ�
 #���ʁFsample
print "</PRE></BODY></HTML>";
