<html>
[%# タイトルを"switch"として外部テンプレートを読み込み %]
[% INCLUDE templates/html/header title = 'switch'%]
[%#  FOREACH文 %]
[% FOREACH val IN list_value %]
[%#  制御文 %]
[% SWITCH val %]
[% CASE 1 %] value is  1
[% CASE [2,3] %] value is 2 or 3
[% CASE 4 %]  value is 4
[% CASE DEFAULT %] value is not 10
[% END %]
<br>
[% END %]
<!-- フッターを読み込み-->
[% INCLUDE templates/html/footer %]
