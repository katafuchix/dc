#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOM���W���[��
$xml = new XML::DOM::Parser();               #XML::DOM::Parser�C���X�^���X����
$document = $xml->parsefile("sample.xml");   #XML�t�@�C���ǂݍ���
$rootNode = $document->getDocumentElement(); #���[�g�v�f�擾
$nodelist = $rootNode->getChildNodes();      #�q�v�f�W���擾
for($i = 0 ; $i < $nodelist->getLength() ; $i++){ #�m�[�h���܂�for���[�v
  $node = $nodelist->item($i);               #�m�[�h�擾
  print $node->getNodeName(); #�m�[�h���o�́B���ʁF#text test1 test2 #text
  print "\n";
}
print "</PRE></BODY></HTML>";
