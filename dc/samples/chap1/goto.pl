#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$val = 0;        #goto関数を使用したループ。推奨されない
BEFOREIF:        #移動先ラベル
print $val++;    #値出力。結果：0123456789
if($val < 10){   #値が10未満の場合は
  goto BEFOREIF; #BEFOREIFラベルに移動
}
while(1){        #複雑なループ
    goto AFTERLOOP; #goto関数によるループ脱出
                    #他の言語では許容される場合もあるが、Perlではlast文を使用
}
AFTERLOOP:       #ループ脱出先のラベル
print "</PRE></BODY></HTML>";
