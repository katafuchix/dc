#!/usr/bin/perl
print "Content-type: image/jpeg\n\n";

use Image::Magick;
use Encode;
$string = "hello";
Encode::from_to ( $string , "shiftjis" , "utf8" ); #文字コードをUTF-8に変換
$font_path = "msgothic.ttc";
$image = Image::Magick->new;           # 画像オブジェクトの生成
$image ->Read("sample1.JPG");          # 画像（200x160サイズ）を読み込む
#$image->Annotate(                      # 文字列を画像に書き出す
#                 text=> $string,    # 書き出す文字列を設定：Annotate
#                 stroke=>"red",        # 文字列のアウトラインの色を設定（赤）
#                 strokewidth => 2,     # 文字列のアウトラインの幅を設定(2)
#                 fill=>"white",        # 文字色の設定（白）
#                 undercolor => "pink", # 背景色の設定（ピンク）
#                 font=>$font_path,     # 文字列のフォントを設定（msgothic）
#                 pointsize=>"26",      # 文字列のサイズを設定（26）
#                 x=>"150", y=>"100",   # 文字列合成の基点を座標で設定（150,100）
#                 antialias => true,    # アンチエイリアス
##                gravity => Center,    # 文字列合成の基点を方角で設定（中心）
#                 align => Left,        # 文字列合成の基点の寄せ方（左寄せ）
#                 rotate => 180,        # 文字列の回転角度を設定(180度)
#                 skewX=>12.5,          # 文字列のx方向の傾斜を設定（12.5）
#                 skewY=>5.5,           # 文字列のy方向の傾斜を設定（5.5）
#                 );

$image->Annotate(text=>$string, stroke=>'#FFFFFF', fill=>'#005599',
                 font=>'VL-Gothic-Regular.ttf', pointsize=>'36',
                 x=>'20', y=>'40', encoding=>'UTF-8');
                 
binmode STDOUT;
$image->Write("jpeg:-");               # 画像をJPEGで出力
undef $image;                          # 画像オブジェクトを破棄してメモリを開放
exit;
