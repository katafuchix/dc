#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
opendir INDIR,"c:\\";        #"C:\"���J��
while($str = readdir INDIR){ #����ǂݍ���
  print $str."\n";           #���ʁFProgram Files Perl temp WINDOWS...
}
closedir INDIR;
print "</PRE></BODY></HTML>";
