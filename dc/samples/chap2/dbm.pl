#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
dbmopen %db,"test",0666; #test���������ݗp�ɊJ��
$db{"test"} = 10;        #�A�z�z��ɏ������݁�DBM�ɏ�������
dbmclose %db;            #��������
dbmopen %db2,"test",0644;#�ēx�ǂݍ��ݗp�ɊJ��
print $db2{"test"};      #���e�o�́B���ʁF10
dbmclose %db2;
print "</PRE></BODY></HTML>";
