#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOM���W���[��
$xml = new XML::DOM::Parser();               #XML::DOM::Parser�C���X�^���X����
$document = $xml->parsefile("sample.xml");   #XML�t�@�C���ǂݍ���
$node = $document->getDocumentElement();     #���[�g�v�f�擾
$clone = $node->cloneNode(0);                #���[�g�v�f�̂݃R�s�[
print $clone->getNodeName();                 #�v�f���o�́B���ʁFsample
print "\n";
print $clone->hasChildNodes();               #�q�m�[�h�̗L���B���ʁF�i�Ȃ��j
print "\n";
$clone2 = $node->cloneNode(1);               #�ċA�I�ɃR�s�[
print $clone2->hasChildNodes();              #�q�m�[�h�̗L���B���ʁF1
print "</PRE></BODY></HTML>";
