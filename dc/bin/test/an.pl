#!/usr/bin/perl 
use strict; 
use warnings; 
use CGI; 
use Image::Magick;  

# CGI ���֥������Ⱥ��� 
my $q = CGI->new; 
my $text = $q->param('var'); 
$text or $text = '12345';  
# Image::Magick ���֥������Ⱥ��� 
my $image = Image::Magick->new; 
$image->Set(size=>'128x128'); 
# ����Х������� 
#$image->ReadImage('xc:white'); 
$image->ReadImage('xc:transparent');
# �Хå��� 
$image->Annotate( 
			text=>$text, 
			fill=>'#ff0000', 
			font=>'AK-CookiesChocolate.TTF', 
			pointsize=>'24', 
			x=>'0', 
			y=>'48', 
		); 

# ʸ�� $image->Wave('5x20'); 
# �Ⱦ��ù�  
# �������� 
#print $q->header('image/jpeg'); 
#�إå� binmode STDOUT; 
 # Win�λ��Τ��ޤ��ʤ� 
 $image->Write('moji1.gif'); 
 # JPEG�ǽ񤭽Ф� 
 undef $image;
 