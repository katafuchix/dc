<html>
[%# タイトルを"if/elseif/else/unless"として外部テンプレートを読み込み %]
[% INCLUDE templates/html/header title = 'if/elseif/else/unless'%]
[%#  制御文 %]
[% IF val > 5  %]                [%# 条件式は真 %]
"value is greater than 5";       [%# 処理される %]
[% END %]<br>
[% IF val > 10  %]               [%# 条件式は偽 %]
"value is greater than 10";      [%# 処理されない %]
[% ELSIF val > 0  %]             [%# 条件式は真 %]
"value is greater than 0";       [%# 処理される %]
[% END %]<br>
[% IF val > 100 %]               [%# 条件式は偽 %]
"value is greater than 100";     [%# 処理されない %]
[% ELSE %]                       [%# else文が処理される %]
 "value is not greater than 100";[%# 処理される %]
[% END %]<br>
[% UNLESS val > 100 %]           [%# 条件式は偽 %]
"value is greater than 100";     [%# 処理される %]
[% END %]
<!-- フッターを読み込み-->
[% INCLUDE templates/html/footer %]
