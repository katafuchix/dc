#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::RSS;                           #XML::RSS���W���[���ǂݍ���
$rss = new XML::RSS (version => "1.0"); #RSS1.0�w��ŃC���X�^���X����
$rss->channel(title => "Test Blog!",link => "http://virualdomain/blog/001/");
$rss->add_item(title => "2/20���L",    #�A�C�e���ǉ�
              link => "http://virualdomain/blog/001/20060220",
              description => "�����͂ǂ���Ƃ����܂��...");
print $rss->as_string();
print "</PRE></BODY></HTML>";
