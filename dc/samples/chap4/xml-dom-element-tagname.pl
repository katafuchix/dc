#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOM���W���[��
$xml = new XML::DOM::Parser();               #XML::DOM::Parser�C���X�^���X����
$document = $xml->parsefile("sample.xml");   #XML�t�@�C���ǂݍ���
$rootElement = $document->getDocumentElement(); #���[�g�v�f�擾
print $rootElement->getTagName();            #���̃��[�g�v�f���B���ʁFsample
print "\n";
$rootElement->setTagName("newTag");          #�v�f����ݒ�
print $rootElement->getTagName();            #�V�������[�g�v�f���B���ʁFnewTag
print "</PRE></BODY></HTML>";
