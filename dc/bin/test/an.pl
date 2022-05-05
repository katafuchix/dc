#!/usr/bin/perl 
use strict; 
use warnings; 
use CGI; 
use Image::Magick;  

# CGI オブジェクト作成 
my $q = CGI->new; 
my $text = $q->param('var'); 
$text or $text = '12345';  
# Image::Magick オブジェクト作成 
my $image = Image::Magick->new; 
$image->Set(size=>'128x128'); 
# カンバスサイズ 
#$image->ReadImage('xc:white'); 
$image->ReadImage('xc:transparent');
# バック白 
$image->Annotate( 
			text=>$text, 
			fill=>'#ff0000', 
			font=>'AK-CookiesChocolate.TTF', 
			pointsize=>'24', 
			x=>'0', 
			y=>'48', 
		); 

# 文字 $image->Wave('5x20'); 
# 波状加工  
# 画像出力 
#print $q->header('image/jpeg'); 
#ヘッダ binmode STDOUT; 
 # Winの時のおまじない 
 $image->Write('moji1.gif'); 
 # JPEGで書き出し 
 undef $image;
 