#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use SampleClass; #SampleClass���W���[���Ăяo���BSampleClass.pm�C���|�[�g
$sample = new SampleClass; #�C���X�^���X�𐶐����A���t�@�����X���X�J���ϐ��Ɋi�[
print $sample->getString;  #���t�@�����X�̃��\�b�h�Ăяo��
#���ʁFSampleClass::getString!
print "</PRE></BODY></HTML>";
