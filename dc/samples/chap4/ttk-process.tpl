<html>
[% INCLUDE templates/html/header
      title = 'process'
%]<!-- タイトルを"process"としてヘッダーを読み込み-->
<!-- スカラー変数表示-->
val:[% message %]<br>
<!-- 配列表示-->
array:[% array_value.0 %][% array_value.1 %][% array_value.2 %]<br>
<!-- ハッシュ表示-->
hash:[% hash_value.hello %][% hash_value.world %][% hash_value.ex %]
<!-- フッターを読み込み-->
[% INCLUDE templates/html/footer %]