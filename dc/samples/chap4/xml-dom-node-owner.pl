#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOM���W���[��
$xml = new XML::DOM::Parser();               #XML::DOM::Parser�C���X�^���X����
$document = $xml->parsefile("sample.xml");   #XML�t�@�C���ǂݍ���
$nodelist = $document->getElementsByTagName("content"); #content�v�f�̏W�����擾
$node = $document->getDocumentElement()->getFirstChild()->getNextSibling();
$document2 = $node->getOwnerDocument(); #�[���ʒu����Document�C���X�^���X���擾
print $document2->getNodeName();   #�m�[�h���o�́B���ʁF#document
print "</PRE></BODY></HTML>";
