#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::RSS;                              #XML::RSS���W���[���ǂݍ���
$rss09 = new XML::RSS (version => '0.9');  #RSS0.9�w��ŃC���X�^���X����
$rss091 = new XML::RSS (version => '0.91');#RSS0.91�w��ŃC���X�^���X����
$rss10 = new XML::RSS (version => '1.0');  #RSS1.0�w��ŃC���X�^���X����
$rss10->parsefile("sample-rss.rdf");       #RSS1.0�t�@�C���ǂݍ���
print $rss10->channel(title);    #�`�����l���̃^�C�g���o�́B���ʁFTest Blog!
print "</PRE></BODY></HTML>";
