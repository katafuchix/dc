#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOM���W���[��
$xml = new XML::DOM::Parser();               #XML::DOM::Parser�C���X�^���X����
$document = $xml->parsefile("sample.xml");   #XML�t�@�C���ǂݍ���
$node = $document->getDocumentElement();     #���[�g�v�f�擾
print $node->getFirstChild()->getNodeName(); #�ŏ��̃m�[�h�B���ʁF#text
print "\n";
print $node->getChildAtIndex(1)->getNodeName(); #1�Ԗڃm�[�h�B���ʁFtest1
print "\n";
print $node->getLastChild()->getNodeName();  #�Ō�̃m�[�h�B���ʁF#text
print "\n";
$nodelist = $node->getChildNodes();          #�q�m�[�h�W���擾
print $nodelist->item(1)->getNodeName();     #�q�m�[�h�W����1�ԖځB���ʁFtest1
print "</PRE></BODY></HTML>";
