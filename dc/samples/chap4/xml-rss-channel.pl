#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::RSS;                           #XML::RSS���W���[���ǂݍ���
$rss = new XML::RSS (version => "1.0"); #RSS1.0�w��ŃC���X�^���X����
$rss->channel(title => "Test Blog!",    #�`�����l�����ݒ�
              link => "http://virualdomain/blog/001/",
              description => "Test blog site",
              dc => {                   #Dublin Core���g�p���ă��^�f�[�^�L�q
                date => "2006-02-20",   #�X�V��
                creator => "Doi"        #����
                });
print $rss->channel(title);    #�`�����l���̃^�C�g���o�́B���ʁFTest Blog!
print "</PRE></BODY></HTML>";
