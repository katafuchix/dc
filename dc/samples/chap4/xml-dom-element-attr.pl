#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOM���W���[��
$xml = new XML::DOM::Parser();               #XML::DOM::Parser�C���X�^���X����
$document = $xml->parsefile("sample.xml");   #XML�t�@�C���ǂݍ���
$test1node = $document->getDocumentElement->getChildAtIndex(1); #�v�f�擾
$attr1 = $test1node->getAttributeNode("attr1"); #�����m�[�h�擾
print $attr1->getValue();                    #�����l�o�́B���ʁFattr1 value
print "\n";
print $test1node->setAttribute("attr1","new value"); #�����l�ݒ�
print "\n";
print $test1node->getAttribute("attr1");     #�����l�o�́B���ʁFnew value
print "</PRE></BODY></HTML>";
