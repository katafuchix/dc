#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOM���W���[��
$xml = new XML::DOM::Parser();               #XML::DOM::Parser�C���X�^���X����
$document = $xml->parsefile("sample.xml");   #XML�t�@�C���ǂݍ���
$node = $document->getDocumentElement();     #���[�g�v�f�擾
print $document->hasChildNodes();            #�q�m�[�h�̗L���B���ʁF1
print "</PRE></BODY></HTML>";
