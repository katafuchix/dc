[%# INCLUDEを使ったマクロ定義 %]
[% MACRO footer INCLUDE templates/html/footer %]
[% MACRO header(title)  INCLUDE templates/html/header %]
[%# BLOCKを使ったマクロ定義 %]
[% MACRO bold(msg) BLOCK %]
<b>[% msg %] </b>
[% END %]
[%# GETを使ったマクロ定義 %]
[% MACRO puls(val1,val2) GET val1 + val2 %]
[%# IFを使ったマクロ定義 %]
[% MACRO value_check(val) IF value == 10%]
 value is 10
[% ELSE %]
 value is not 10
[% END %]
[%# ヘッダーマクロ呼び出し %]
[% header('macro') %] 
[%# BOLDマクロ呼び出し %]
[% bold(message) %]<br>
[%# 足し算マクロ呼び出し %]
[% puls(10,2) %]<br>
[%# 値チェックマクロ呼び出し %]
[% value_check(10) %]
[%# フッターマクロ呼び出し %]
[% footer %]