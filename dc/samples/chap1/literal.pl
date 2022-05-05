#!/usr/bin/perl
print "Content-type: text/html ; charset=shift-jis\n\n";
print "<HTML><BODY><PRE>";
print 1_2_3;               #数値リテラル。結果：123
print "\n";
print 1.2e+5;              #指数表記浮動小数点数。結果：120000
print "\n";
print 0x3d;                #16進数数値リテラル。結果：61
print "\n";
print 022;                 #8進数数値リテラル。結果：18
print "\n";
$value = 4;
print "\$value is $value"; #変数は展開される。最初は\でエスケープしている
#結果：$value is 4
print "\n";
print '\$value is $value'; #変数は展開されない。$はエスケープされない
#結果：\$value is $value
print "\n";
print "abc\a";             #ビープ音出力。結果：abc（＋ビープ音）
print "\n";
print "def\bghi";          #バックスペース出力。結果：deghi
print "\n";
print "abc\ndef";          #改行出力。結果：abc（改行）def
print "\n";
print "abc\udef\Ughij\Ek"; #大文字化。結果：abcDefGHIJ
print "\n";
print "ABC\lDEF\LGHIJ\EK"; #小文字化。結果：ABCdEFghijK
print "\n";
print "\045";              #8進数の文字コード。結果：%
print "\n";
print "\x27";              #16進数の文字コード。結果：'
print "\n";
print 'a\nbc\\def\'g';     #シングルクォート内では\'と\\以外は展開しない。
#結果：a\nbc\def'g
print "\n";
print q/"abc"/;            #シングルクォートの代わりのq//演算子。結果："abc"
print "\n";
print qq/abc\t"def"\n'ghi'\\/; #ダブルクォート代わりのqq//演算子。
#結果：abc	"def"（改行）'ghi'\
print "</PRE></BODY></HTML>";
