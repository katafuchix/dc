#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOM���W���[��
$xml = new XML::DOM::Parser();               #XML::DOM::Parser�C���X�^���X����
$document = $xml->parsefile("sample.xml");   #XML�t�@�C���ǂݍ���
$nodelist = $document->getElementsByTagName("content"); #content�v�f�̏W�����擾
$textnode = $nodelist->item(0)->getFirstChild(); #�e�L�X�g�m�[�h�擾
print $textnode->getData();   #CharacterData�N���X�̃��\�b�h
 #������o�́B���ʁFcontent string1
print "\n";
$textnode->splitText(10);     #2��Text�C���X�^���X�ɕ���
print $textnode->getData();   #������o�́B���ʁFcontent st
print "\n";
$textnode2 = $textnode->getNextSibling();
#���̃m�[�h�i�������ꂽ2�߂�Text�C���X�^���X�j���擾
print $textnode2->getData();  #������o�́B���ʁFring1
print "</PRE></BODY></HTML>";
