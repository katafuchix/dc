#!/usr/bin/perl

use strict;
use Jcode;
use Image::Magick;

# ���������
my $file = "sample1.JPG";

# ����������ʸ����
my $text = "ABC123���ܸ�";

# UTF-8���Ѵ�
$text = jcode($text)->utf8;

# ���֥������Ⱥ���
my $image = Image::Magick->new;

# �����ɤ߹���
$image->Read($file);

# ʸ����������
$image->Annotate(text=>$text, stroke=>'#FFFFFF', fill=>'#005599',
                 font=>'sazanami-gothic.ttf', pointsize=>'36',
                 x=>'20', y=>'40', encoding=>'UTF-8');

# ��������
print "Content-type: image/jpeg\n\n";
binmode STDOUT;
$image->Write('jpeg:-');

undef $image;
exit;
