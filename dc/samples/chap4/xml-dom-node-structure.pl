#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOM���W���[��
$xml = new XML::DOM::Parser();               #XML::DOM::Parser�C���X�^���X����
$document = $xml->parsefile("sample.xml");   #XML�t�@�C���ǂݍ���
$node = $document->getDocumentElement();     #���[�g�v�f�擾
$newNode = $document->createElement("newTag"); #�V�����v�f���쐬
$node->appendChild($newNode);                #�����ɒǉ�
print $node->getLastChild()->getNodeName();  #�Ō�̎q�m�[�h�̖��O�B���ʁFnewTag
print "</PRE></BODY></HTML>";
