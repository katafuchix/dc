#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@list = (1,2,3,4,5);  #�z��ϐ�
$reflist = \@list;    #���t�@�����X���X�J���ϐ��ɑ��
print $reflist->[2];  #�A���[���Z�q�ŗv�f�ɃA�N�Z�X�B���ʁF3
print "\n";
%hash = ("Sunday" => "��","Monday" => "��","Tuesday"=>"��"); #�A�z�z��ϐ�
$refhash = \%hash;           #���t�@�����X���X�J���ϐ��ɑ��
print $refhash->{"Monday"};  #�A���[���Z�q�Œl���Q�ƁB���ʁF��
print "\n";
use CGI;              #CGI�I�u�W�F�N�g��`�ǂݍ���
$cgi = new CGI;       #CGI�I�u�W�F�N�g����
print $cgi->header;   #���t�@�����X����header���\�b�h���Ăяo���B
#���ʁFContent-Type: text/html; charset=ISO-8859-1
print "</PRE></BODY></HTML>";
