#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
require sample;         #sample�p�b�P�[�W�����[�h
print &sample::sample1; #sample�p�b�P�[�W��sample1�T�u���[�`�����Ăяo��
#���ʁFsample::sample1
print "</PRE></BODY></HTML>";
