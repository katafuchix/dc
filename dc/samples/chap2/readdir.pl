#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
opendir INDIR,"c:\\";        #"C:\"を開く
while($str = readdir INDIR){ #一つずつ読み込む
  print $str."\n";           #結果：Program Files Perl temp WINDOWS...
}
closedir INDIR;
print "</PRE></BODY></HTML>";
