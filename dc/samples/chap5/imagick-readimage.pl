#!/usr/bin/perl
print "Content-type: image/jpeg\n\n";

use Image::Magick;
$image = Image::Magick->new;           # 画像オブジェクトの生成
$image->Set(size=>"200x160");          # 200x160のキャンバスを作成
$image ->ReadImage('xc:pink');         # 背景色がピンクの空画像を読み込む
# 四角形を描く
$image->Draw(primitive=>'rectangle', points=>"50,50 150,110",
             stroke=>'blue', fill=>'red');
binmode STDOUT;
$image->Write('jpeg:-');
undef $image;                          # 画像オブジェクトを破棄してメモリを開放
exit;
