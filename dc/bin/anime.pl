#!/usr/bin/perl

my $home = '/var/www/html/dc/etc/';
require $home."app_config.pm";

#use strict;
use Jcode;
use Image::Magick;
use Encode;

%AI = app_config->config(%AI);

sub urldecode($) {
	my $str = shift;
	$str =~ tr/+/ /;
	$str =~ s/%([0-9A-Fa-f][0-9A-Fa-f])/pack('H2', $1)/eg;
	return $str;
}


# 画像を指定
#my $file = "/var/www/html/dc/samples/sample1.JPG";

# 合成したい文字列
#my $text = "あaaaABC123日本語";
#my $text = $param_value{'text'};

my ($sec,$min,$hour,$day,$mon,$year,$wno) = localtime(time);
	$year = $year + 1900;
	$mon = $mon +1;

my $img_dir		= $AI{'IMG_DIR'};
my $font_dir	= $AI{'FONT_DIR'};
my $file 		= $img_dir.sprintf('%4d-%02d-%02d', $year, $mon, $day).'/'.$ARGV[0];

my $flg			= $ARGV[0];
my $text		= $ARGV[1];
my $font		= $font_dir.$ARGV[2];
my $x			= $ARGV[3];
my $y			= $ARGV[4];
my $color		= $ARGV[5];
my $size		= $ARGV[6];

#print $font;
#print $color;
my @color_array = split( /,/, $AI{'COLOR'});

my @colors = split( /-/, $color_array[$color]);
my $stroke		= $colors[0];
my $fill		= $colors[1];

#print $file;
#my $font= '/usr/share/fonts/japanese/TrueType/sazanami-mincho.ttf';
#my $font = '/var/www/html/dc/samples/font/aquap.ttf';
#my $font= '/home/admin/font/anzu.ttf';
#my $font= '/home/test/font/elenat.ttf';

#print "Content-type: text/html\n\n";
#print $text;
#print $param_value{'stamp'};

#exit;

# UTF-8へ変換
#$text = jcode($text)->utf8;
#Encode::from_to ( $text , "euc-jp" , "utf8" ); 

$text = jcode(urldecode($text))->utf8;


#if($text){

	$text =~ s/BBRR/\n/g;

	my $image1 = Image::Magick->new; 
	$image1->Set(size=>'128x128'); 
	# カンバスサイズ 
	#$image->ReadImage('xc:white'); 
	$image1->ReadImage('xc:transparent');
	$image1->Annotate( 
				text=>$text, 
				fill=>'#ff0000', 
				font=>$font, 
				pointsize=>'24', 
				x=>'0', 
				y=>'48', 
			); 
	$image1->Write('/var/www/html/dc/bin/moji1.gif'); 
	
	# オブジェクト作成
	my $image2 = Image::Magick->new; 
	$image2->Set(size=>'128x128'); 
	# カンバスサイズ 
	$image2->ReadImage('xc:transparent');
	$image2->Annotate( 
				text=>$text, 
				fill=>'#ff0000', 
				font=>$font, 
				pointsize=>'24', 
				x=>'10', 
				y=>'55', 
			); 
	$image2->Write('/var/www/html/dc/bin/moji2.gif'); 
	

	# オブジェクト作成
	my $image = Image::Magick->new;
	# 画像読み込み
	$image->Read(qw(/var/www/html/dc/bin/moji1.gif /var/www/html/dc/bin/moji2.gif));
	$image->Set(loop=>0);
	$image->Set(dispose=>2);

	$image->Set(delay=>50);
	
#}

# 画像出力
#print "Content-type: image/jpeg\n\n";

#$image->Read('/var/www/html/dc/bin/moji.gif');

binmode STDOUT;
#$image->Write('/var/www/html/dc/bin/moji3.gif');

$image->Write('gif:-');

undef $image;
exit;