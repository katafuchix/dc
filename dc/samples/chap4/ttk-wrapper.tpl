[%# ブロックを定義 %]
[% BLOCK bold %]<b>[% content %]</b>[% END %]
[% BLOCK italic %]<i>[% content %]</i>[% END %]
<html>
[%# -- タイトルを"wrapper"として外部テンプレートを読み込み-- %]
[% INCLUDE templates/html/header title = 'wrapper'%]
<!-- ブロックをラッパー -->
[% WRAPPER bold+italic %]Hello World !![% END %]
<!-- フッターを読み込み-->
[% INCLUDE templates/html/footer %]
