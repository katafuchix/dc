#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::Simple;                      #XML::Simple���W���[��
$xml = new XML::Simple();             #�C���X�^���X����
$sample = $xml->xml_in("sample.xml"); #XML�ǂݍ���
print $sample->{test1}->{attr1}; #test1�v�f��attr1������\���B���ʁFattr1 value
print "\n";
$sample2 = XMLin("sample.xml");       #�C���X�^���X���������ŌĂяo��
print $sample2->{test1}->{attr1};#test1�v�f��attr1������\���B���ʁFattr1 value
print "</PRE></BODY></HTML>";
