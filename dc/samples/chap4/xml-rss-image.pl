#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::RSS;                           #XML::RSS���W���[���ǂݍ���
$rss = new XML::RSS (version => "1.0"); #RSS1.0�w��ŃC���X�^���X����
$rss->channel(title => "Test Blog!",link => "http://virualdomain/blog/001/");
$rss->image(title => "2/20�̋�͗l",    #�A�C�e���ǉ�
            link => "http://virualdomain/blog/001/20060220",
            url => "http://virualdomain/blog/001/200602201430.jpg");
print $rss->as_string();
print "</PRE></BODY></HTML>";
