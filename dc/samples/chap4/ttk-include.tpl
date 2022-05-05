<html>
[%# -- タイトルを"include"として外部テンプレートを読み込み-- %]
[% INCLUDE templates/html/header title = 'include'%]
<!-- プログラム側で格納した変数表示 -->
[% message %]<br>
<!-- 外部ファイルの読み込み -->
[% INSERT insert.txt %]
<!-- 外部テンプレートの読み込み -->
[% INCLUDE include.txt + include.txt %]
<!-- フッターを読み込み-->
[% INCLUDE templates/html/footer %]