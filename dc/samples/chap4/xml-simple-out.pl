#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::Simple;                       #XML::Simple���W���[��
$xml = new XML::Simple();              #�C���X�^���X����
$sample = $xml->xml_in("sample.xml");  #XML�ǂݍ���
print $xml->xml_out($sample,RootName => "output"); #XML�o��
print "</PRE></BODY></HTML>";
