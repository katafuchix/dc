#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOM���W���[��
$xml = new XML::DOM::Parser();               #XML::DOM::Parser�C���X�^���X����
$document = $xml->parse("<sample attr1='attr1value' attr2='attr2value'/>");
$nnm = $document->getDocumentElement()->getAttributes(); #�����W���擾
print $nnm->item($i)->getValue(); #�����l�o�́B���ʁFattr1value
print "\n";
print $nnm->getNamedItem("attr2")->getValue(); #�����l�o�́B���ʁFattr2value
print "</PRE></BODY></HTML>";
