#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOM���W���[��
$xml = new XML::DOM::Parser();               #XML::DOM::Parser�C���X�^���X����
$document = $xml->parsefile("sample.xml");   #XML�t�@�C���ǂݍ���
$node = $document->getDocumentElement();     #���[�g�v�f�擾
$firstElement = $node->getFirstChild();      #�ŏ��̃m�[�h
$secondElement = $firstElement->getNextSibling(); #���̃m�[�h���擾
$attrs = $secondElement->getAttributes();         #�����W���擾
print $attrs->item(0)->getValue();           #0�Ԗڂ̑����l�o�́B����attr1 value
print "</PRE></BODY></HTML>";
