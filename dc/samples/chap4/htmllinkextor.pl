#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use HTML::LinkExtor;          #HTML::LinkExtorモジュール読み込み
sub callback{                 #コールバックルーチン定義
  my ($tagname , %attr) = @_; #引数はタグ名と属性の連想配列の2つ
  if($tagname eq "a"){        #a要素の場合は
    print $attr{"href"}; #href属性を出力。結果：http://localhost/sample2.html
  }
}
$extor = HTML::LinkExtor->new(\&callback,"http://localhost/");
#コールバックルーチンとベースURLを指定
$extor->parse_file('sample.html');#HTML読み込み
#リンク発見の度にcallbackが呼び出される
print "</PRE></BODY></HTML>";
