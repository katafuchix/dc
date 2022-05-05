<html>
[%# タイトルを"perl"として外部テンプレートを読み込み %]
[% INCLUDE templates/html/header title = 'perl'%]
[%# PERLタグでPerlコードを記述する%]
[% PERL %]
my $msg = $stash->get("message"); #messageを取得
$stash->set("value"=> 10);        #valueを10にセット
print "perl:".$msg;
[% END %]<br>
[% value %]<br>
[%# RAWPERLタグでPerlコードを記述する%]
[% RAWPERL %]
$output .= 'raw perl:Hello World !!';
[% END %]<br>
<!-- フッターを読み込み-->
[% INCLUDE templates/html/footer %]
