#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
opendir INDIR,"c:\\";        #"C:\"を開く
print scalar readdir INDIR;  #最初の要素。結果：boot.ini
print "\n";
my $pos = telldir INDIR;     #現在位置保存
print scalar readdir INDIR;  #2番目の要素。結果：AUTOEXEC.BAT
print "\n";
readdir INDIR;               #位置を移動
seekdir INDIR,$pos;          #位置を復元
print scalar readdir INDIR;  #2番目の要素。結果：AUTOEXEC.BAT
print "\n";
readdir INDIR;               #位置を移動させる
rewinddir INDIR;             #位置を初期化
print scalar readdir INDIR;  #最初の要素。結果：boot.ini
closedir INDIR;
print "</PRE></BODY></HTML>";
