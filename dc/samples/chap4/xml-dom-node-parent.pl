#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOM���W���[��
$xml = new XML::DOM::Parser();               #XML::DOM::Parser�C���X�^���X����
$document = $xml->parsefile("sample.xml");   #XML�t�@�C���ǂݍ���
$node = $document->getDocumentElement();     #���[�g�v�f�擾
print $node->getParentNode()->getNodeName(); #�e�m�[�h���擾���ăm�[�h���擾
 #�e�m�[�h��Document�N���X�B���ʁF#document
print "\n";
$newNode =$document->createElement("newElement"); #�V�����v�f�쐬
print $newNode->getParentNode();             #�e�m�[�h�͑��݂����B���ʁF�i�Ȃ��j
print "</PRE></BODY></HTML>";
