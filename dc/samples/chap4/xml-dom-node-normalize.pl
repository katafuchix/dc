#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOM���W���[��
$xml = new XML::DOM::Parser();               #XML::DOM::Parser�C���X�^���X����
$document = $xml->parsefile("sample.xml");   #XML�t�@�C���ǂݍ���
$root = $document->getDocumentElement();
$text = $document->createTextNode("test");   #Text�m�[�h�V�K�쐬
$root->appendChild($text);                   #���[�g�����ɒǉ�
$text2 = $document->createTextNode("test");  #Text�m�[�h�V�K�쐬
$root->appendChild($text2);                  #���[�g�����ɒǉ�
$text3 = $document->createTextNode("test");  #Text�m�[�h�V�K�쐬
$root->appendChild($text3);                  #���[�g�����ɒǉ�
print $root->getChildNodes()->getLength();   #���[�g�����̃m�[�h���o�́B���ʁF8
print "\n";
$root->normalize();                          #�e�L�X�g�m�[�h����
print $root->getChildNodes()->getLength();   #���[�g�����̃m�[�h���o�́B���ʁF5
print "</PRE></BODY></HTML>";
