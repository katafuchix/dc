#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTPヘッダ出力

use GD;
$img = new GD::Image(100,100);
$blue  = $img->colorAllocate(0,0,255);       # 青を設定
@rgb_val = $img->rgb($blue);                 # 青のRGB値を取得
print join(",",@rgb_val);                    # RGB値を表示 結果：0,0,255

print "</body></html>"; #HTML出力

