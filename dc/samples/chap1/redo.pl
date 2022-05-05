#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
open INFILE,"sample.txt"; #ファイルを開く
while(<INFILE>){          #一行ずつ読み出す
  if(/\n$/){              #行の末尾が改行文字の場合は
    chomp;                #改行文字を切り落とし
    $_ .= <INFILE>;       #次の行と結合させ
    redo;                 #先頭から処理し直す
  }
  print $_;               #ファイル内容すべてを1行に連結して出力
}
print "\n";
for($val = 0 ; $val < 10 ; $val++){
  print $val;             #値出力。結果：012345555555555...
  if($val == 5){          #値が5の場合は
#    redo; #次のループへ。増減式が処理されないので無限ループになる
  }
}
print "</PRE></BODY></HTML>";
