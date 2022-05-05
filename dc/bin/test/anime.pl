#!/usr/bin/perl

my $home = '/var/www/html/dc/etc/';
require $home."app_config.pm";

#use strict;
use Jcode;
use Image::Magick;
use Encode;

# オブジェクト作成
my $image = Image::Magick->new;
# 画像読み込み
$image->Read(qw(moji1.gif moji2.gif));
#$image->Set(loop=>0);
$image->Set(loop=>0);
$image->Set(dispose=>2);

$image->Set(delay=>50);


binmode STDOUT;
$image->Write('moji3.gif');

undef $image;
exit;