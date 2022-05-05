#!/usr/bin/perl

use strict;
use Jcode;
use Image::Magick;

# 画像を指定
my $file = "sample1.JPG";

# 合成したい文字列
my $text = "ABC123日本語";

# UTF-8へ変換
$text = jcode($text)->utf8;

# オブジェクト作成
my $image = Image::Magick->new;

# 画像読み込み
$image->Read($file);

# 文字を記入する
$image->Annotate(text=>$text, stroke=>'#FFFFFF', fill=>'#005599',
                 font=>'sazanami-gothic.ttf', pointsize=>'36',
                 x=>'20', y=>'40', encoding=>'UTF-8');

# 画像出力
print "Content-type: image/jpeg\n\n";
binmode STDOUT;
$image->Write('jpeg:-');

undef $image;
exit;
