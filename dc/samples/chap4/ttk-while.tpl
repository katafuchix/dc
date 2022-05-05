<html>
[%# タイトルを"loop"として外部テンプレートを読み込み %]
[% INCLUDE templates/html/header title = 'loop'%]
<!-- WHILEタグ -->
[% i = 0 %]
[% WHILE (i < 10 ) %] [%# 10回処理を繰り返す%]
[% i = i + 1 %]
[% i %],
[% END %]
<br>
<!-- FOREACHタグ -->
[% FOREACH j = list_value %] [%# 配列の要素を一つずつ取り出す =を使う %]
[% j %],
[% END %]
<br>
[% FOREACH j IN list_data %] [%# 配列の要素を一つずつ取り出す INを使う %]
[% j %],
[% END %]
<br>
<!-- LASTタグ -->
[% i = 0 %]
[% WHILE (i < 10 ) %] [%# 10回処理を繰り返す%]
[% i = i + 1 %]
[% LAST IF (i == 5) %]  [%# iが5の場合、ループ処理を終了する%]
[% i %],
[% END %]
<br>
<!-- NEXTタグ -->
[% FOREACH j IN list_value %] [%# 配列の要素を一つずつ取り出す%]
[% NEXT IF (j == 5) %]  [%# iが5の場合、ループ処理を中断して、次の処理に移る%]
[% j %],
[% END %]
<!-- フッターを読み込み-->
[% INCLUDE templates/html/footer %]
