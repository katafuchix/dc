#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
opendir INDIR,"c:\\";        #"C:\"���J��
print scalar readdir INDIR;  #�ŏ��̗v�f�B���ʁFboot.ini
print "\n";
my $pos = telldir INDIR;     #���݈ʒu�ۑ�
print scalar readdir INDIR;  #2�Ԗڂ̗v�f�B���ʁFAUTOEXEC.BAT
print "\n";
readdir INDIR;               #�ʒu���ړ�
seekdir INDIR,$pos;          #�ʒu�𕜌�
print scalar readdir INDIR;  #2�Ԗڂ̗v�f�B���ʁFAUTOEXEC.BAT
print "\n";
readdir INDIR;               #�ʒu���ړ�������
rewinddir INDIR;             #�ʒu��������
print scalar readdir INDIR;  #�ŏ��̗v�f�B���ʁFboot.ini
closedir INDIR;
print "</PRE></BODY></HTML>";
