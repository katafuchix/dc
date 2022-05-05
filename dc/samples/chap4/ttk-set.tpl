<html>
[% INCLUDE templates/html/header
      title = 'set'
%]<!-- タイトルを"set"としてヘッダーを読み込み-->
[%# -- デフォルト値を設定 -- %]
[% DEFAULT
    font_color   = 'color="#0000FF"'
    font_size    = 'size ="-1"'
%]
[%#-- テンプレート側で変数格納 --%]
[% SET
     val = "HelloWorld!!"
     qq_val = "message is $val"
     q_val  = 'message is $val'
     list_val = [ "Hello", "World", "!!"]
     list_num = [ 1..3 ]
     hash     = { hello => "Hello", world => "World" , ex => "!!"}
%]
<!-- プログラム側で格納した変数表示 -->
<font [% font_size %] [%  font_color %]>[% message %]</font><br>
<!-- テンプレート側で格納した変数表示-->
[% val %]<br>
[% q_val %]<br>
[% qq_val %]<br>
[% list_val.0 _ list_val.1 _ list_val.2 %]<br>
[% list_num.0 _" + "_ list_num.1 _" * "_ list_num.2 %]
 = [% list_num.0 + list_num.1 * list_num.2 %]<br>
[% hash.hello _ hash.world _ hash.ex %]<br>
<!-- デフォルトを上書き -->
[% SET font_size = "size=+1" %]
<font [% font_size %] [%  font_color %]>[% message %]</font><br>
<!-- フッターを読み込み-->
[% INCLUDE templates/html/footer %]