[%# ブロックを定義1 %]
[% BLOCK block_tpl1 %]
block1:[% message %]<br>
[% END %]
[%# ブロックを定義2 %]
[% block_tpl2 = BLOCK  %]
block2:[% message %]<br>
[% END %]
<html>
[%# -- タイトルを"block"として外部テンプレートを読み込み-- %]
[% INCLUDE templates/html/header title = 'block'%]
<!-- ブロックの読み込み -->
[% INCLUDE block_tpl1 %]
[% block_tpl2 %]
<!-- フッターを読み込み-->
[% INCLUDE templates/html/footer %]
