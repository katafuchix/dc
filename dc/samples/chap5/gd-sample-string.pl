#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTPヘッダ出力

use GD;
$img = new GD::Image(300,150); #画像オブジェクトを設定
$white = $img->colorAllocate(255,255,255); #白を設定
$black = $img->colorAllocate(0,0,0); #黒を設定
#gdGiantFontで文字列を描画
$img->string(gdGiantFont,10,10,"GiantFont",$black);
#gdLargeFontで文字列を描画
$img->string(gdLargeFont,10,30,"LargeFont",$black);
#gdMediumBoldFontで文字列を描画
$img->string(gdMediumBoldFont,10,50,"MediumBoldFont",$black);
#gdSmallFontで文字列を描画
$img->string(gdSmallFont,10,70,"SmallFont",$black);
#gdTinyFontで文字列を描画
$img->string(gdTinyFont,10,90,"TinyFont",$black);
#gdGiantFontで文字列を描画(90度回転)
$img->stringUp(gdGiantFont,150,120,"GiantFont90",$black);
#gdLargeFontで文字列を描画(90度回転)
$img->stringUp(gdLargeFont,170,120,"LargeFont90",$black);
#gdMediumBoldFontで文字列を描画(90度回転)
$img->stringUp(gdMediumBoldFont,190,120,"MediumBoldFont90",$black);
#gdSmallFontで文字列を描画(90度回転)
$img->stringUp(gdSmallFont,210,120,"SmallFont90",$black);
#gdTinyFontで文字列を描画(90度回転)
$img->stringUp(gdTinyFont,230,120,"TinyFont90",$black);
binmode STDOUT; # バイナリ出力に設定
print $img->png(); #PNG形式で画像を出力する

