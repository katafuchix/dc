#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOM���W���[��
$xml = new XML::DOM::Parser();               #XML::DOM::Parser�C���X�^���X����
$document = $xml->parsefile("sample.xml");   #XML�t�@�C���ǂݍ���
$nodelist = $document->getElementsByTagName("content"); #content�v�f�̏W�����擾
print $nodelist->getLength();                #content�v�f�̌��B���ʁF2
print "\n";
print $nodelist->item(0)->getFirstChild()->getNodeValue();
#0�Ԗڂ�content�v�f�̃e�L�X�g�m�[�h�̒l�o�́B���ʁFcontent string1
print "</PRE></BODY></HTML>";
