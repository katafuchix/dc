#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
%days = ("Sunday" => "日","Monday" => "月","Tuesday"=>"火");
while($str = each %days){       #キーを順に取り出す
  print $str;                   #結果：Tuesday Monday Sunday
}#whileステートメントは空リストで終了する
print "\n";
 #さらにeach関数を呼び出すと先頭に戻る
while(($str,$val) = each %days){#キーと値をセットで取り出す
  print $str.":".$val;          #結果：Tuesday:火 Monday:月 Sunday:日
}
print "\n";
while(($str,$val) = each %days){#キーと値をセットで取り出す
  $val = $val."曜日";   #値を書き換える
}
while(($str,$val) = each %days){#キーと値をセットで取り出す
  print $str.":".$val;          #元の値は書き換わらない
}
print "</PRE></BODY></HTML>";
