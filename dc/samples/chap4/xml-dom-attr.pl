#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOM���W���[��
$xml = new XML::DOM::Parser();               #XML::DOM::Parser�C���X�^���X����
$document = $xml->parsefile("sample.xml");   #XML�t�@�C���ǂݍ���
$nodelist = $document->getElementsByTagName("test1"); #content�v�f�̏W�����擾
$test1node = $nodelist->item(0); #�e�L�X�g�m�[�h�擾
$attrNode = $test1node->getAttributes()->item(0); #�ŏ��̑����擾
print $attrNode->getName();      #�������o�́B���ʁFattr1
print "\n";
print $attrNode->getValue();     #�����l�o�́B���ʁFattr1 value
print "</PRE></BODY></HTML>";
