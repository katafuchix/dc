#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOM���W���[��
$xml = new XML::DOM::Parser();               #XML::DOM::Parser�C���X�^���X����
$document = $xml->parsefile("sample.xml");   #XML�t�@�C���ǂݍ���
$nodelist = $document->getElementsByTagName("content"); #content�v�f�̏W�����擾
$textnode = $nodelist->item(0)->getFirstChild(); #�e�L�X�g�m�[�h�擾
print $textnode->getData();   #������o�́B���ʁFcontent string1
print "\n";
$textnode->appendData("+append"); #�������ǉ�
print $textnode->getData();   #������o�́B���ʁFcontent string1+append
print "</PRE></BODY></HTML>";
