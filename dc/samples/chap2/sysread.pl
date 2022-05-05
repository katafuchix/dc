#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open INFILE,"readsample.txt";     #readsample.txtはサイズ17バイト
print sysread INFILE,$str,20;     #バッファリングなし読み出し。結果：17
close INFILE;
print "</PRE></BODY></HTML>";
