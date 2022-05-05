#!/usr/bin/perl

use strict;
use Jcode;
use Image::Magick;
use Encode;

# ���������
my $file = "sample1.JPG";

# ����������ʸ����
my $text = "��aaaABC123���ܸ�";

my $font= 'font/anzu.ttf';

# UTF-8���Ѵ�
#$text = jcode($text)->utf8;
Encode::from_to ( $text , "euc-jp" , "utf8" ); 

#$text = jcode(urldecode($text))->utf8;

# ���֥������Ⱥ���
my $image = Image::Magick->new;

# �����ɤ߹���
$image->Read($file);

# ʸ����������
#$image->Annotate(text=>$text, stroke=>'#FFFFFF', fill=>'#005599',
#                 font=>'sazanami-gothic.ttf', pointsize=>'36',
#                 x=>'20', y=>'40', encoding=>'UTF-8');

$image->Annotate(text=>$text, stroke=>'#FFFFFF', fill=>'#005599',
                 font=>$font, pointsize=>'60',
                 x=>'10', y=>'40', encoding=>'UTF-8');
                 
# ��������
print "Content-type: image/jpeg\n\n";
binmode STDOUT;
$image->Write('jpeg:-');

undef $image;
exit;
