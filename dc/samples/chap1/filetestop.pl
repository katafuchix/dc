#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print (-r "sample.txt");   #�t�@�C���ǂݎ��e�X�g�B���ʁF1
print "\n";
print (-w "sample.txt");   #�t�@�C���������݃e�X�g�B���ʁF1
print "\n";
print (-w "sampleRO.txt"); #�ǂݎ���p�t�@�C���̏ꍇ�͎��s�B���ʁF�i�Ȃ��j
print "\n";
print (-x "sample.bat");   #�t�@�C�����s�e�X�g�B���ʁF1
print "\n";
print (-x "sample.exe");   #�t�@�C�����s�e�X�g�B���ʁF1
print "\n";
print (-e "NotExist.txt"); #�t�@�C�����݃e�X�g�B���ʁF�i�Ȃ��j
print "\n";
print (-z "size0.txt");    #�t�@�C���T�C�Y0�e�X�g�B���ʁF1
print "\n";
print (-s "sample.txt");   #�t�@�C���T�C�Y��0�e�X�g�B���ʁF14
print "\n";
print (-T "sample.txt");   #�e�L�X�g�t�@�C���e�X�g�B���ʁF1
print "\n";
print (-T "sample.exe");   #�e�L�X�g�t�@�C���e�X�g�B���ʁF�i�Ȃ��j
print "\n";
print (-B "sample.txt");   #�o�C�i���t�@�C���e�X�g�B���ʁF�i�Ȃ��j
print "\n";
print (-B "sample.exe");   #�o�C�i���t�@�C���e�X�g�B���ʁF1
print "\n";
print (-d "subfolder");    #�f�B���N�g���e�X�g�B���ʁF1
print "\n";
print (-b STDIN);          #�u���b�N�t�@�C���e�X�g�B���ʁF�i�Ȃ��j
print "\n";
print (-c STDIN);          #�L�����N�^�t�@�C���e�X�g�B���ʁF1
print "\n";
print (-t);                #STDIN��tty�I�[�v���e�X�g�B���ʁF1
print "\n";
print (-t STDOUT);         #STDOUT��tty�I�[�v���e�X�g�B���ʁF1
print "\n";
print (-M "sample.txt");   #�X�V�����̌Â��B���ʁF1.32185185185185
print "\n";
print (-A "sample.txt");   #�A�N�Z�X�����̌Â��B���ʁF0.00121527777777778
print "\n";
print (-C "sample.txt");   #inode�ύX�����̌Â��B���ʁF1.32185185185185
print "\n";
print (-e _);              #�A���_�[�X�R�A�ōŌ�ɃA�N�Z�X�����t�@�C�����e�X�g
                           #���ʁF1
print "</PRE></BODY></HTML>";
