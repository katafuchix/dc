<html>
[% INCLUDE templates/html/header
      title = 'valiable'
%]<!-- タイトルを"process"としてヘッダーを読み込み-->
<!-- スカラー変数表示-->
val:[% GET message %]<br>
<!-- 数値計算-->
num:[% GET num_1%]+[% GET num_2%]=[% GET num_1 + num_2 %]<br>
<!-- 配列表示-->
array:[% GET array_value.0 %][% GET array_value.1 %]
[% GET array_value.2 %]<br>
<!-- ハッシュ表示-->
hash:[% GET hash_value.hello %]
[% GET hash_value.world %][% GET hash_value.ex %]<br>
<!-- 関数表示-->
sub:[% GET sub_value('World!!') %]<br>
<!-- オブジェクト表示-->
obj:[% GET obj_value.param('message') %]
<!-- フッターを読み込み-->
[% INCLUDE templates/html/footer %]