#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$_ = "abcdefg"; #�ϊ��Ώە�����
tr/c-f/ /s;     #c-f�� �i�X�y�[�X�j�ɕϊ��Bs�C���q�ŏd����1�ɂ܂Ƃ߂�
print;          #���ʁFab g
print "\n";
$_ = "abcdefg"; #�ϊ��Ώە�����
y/a-c//d;       #a-c��ϊ��Bd�C���q�őΉ����镶�������������͍폜
print;          #���ʁFdefg
print "</PRE></BODY></HTML>";
