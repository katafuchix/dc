#!/usr/bin/perl
print "Content-type: text/html; charset=shift-jis\n\n";
print "<HTML><BODY><PRE>";
use XML::Simple;                #XML::Simple���W���[��
$xml = new XML::Simple("RootName" => "output"); #�C���X�^���X����
                                #�o�͎��̃��[�g�v�f�����w��
$sample = $xml->xml_in("sample.xml");           #XML�ǂݍ���
print "$sample->{'test1'}->{'content'}->[0]\n"; #��������e�o��
print "$sample->{'test1'}->{'content'}->[1]\n";
$sample->{'test1'}->{'content'}->[1] = "modified content"; #���e��������
print $xml->xml_out($sample);   #XML�o��
print "</PRE></BODY></HTML>";
