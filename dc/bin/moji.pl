#!/usr/bin/perl

my $home = '/var/www/html/dc/etc/';
require $home."app_config.pm";

#use strict;
use Jcode;
use Image::Magick;
use Encode;

%AI = app_config->config(%AI);

if($ENV{'REQUEST_METHOD'} eq "GET"){

        $buffer = $ENV{'QUERY_STRING'} . '&';
        @pairs = split(/&/,$buffer);

}elsif ($ENV{'REQUEST_METHOD'} eq "POST"){

        $length = $ENV{'CONTENT_LENGTH'};
        read(STDIN, $buffer, $length);
        @pairs = split(/&/,$buffer);

}

        foreach $pair (@pairs){
                ($name,$value) = split(/=/, $pair);
                $value =~ tr/+/ /;
                $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
                $param_value{$name} = $value;
        }


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
my $flg			= $ARGV[1];
my $text		= $ARGV[2];
my $font		= $font_dir.$ARGV[3];
my $x			= $ARGV[4];
my $y			= $ARGV[5];
my $color		= $ARGV[6];
my $size		= $ARGV[7];

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

# オブジェクト作成
my $image = Image::Magick->new;

# 画像読み込み
$image->Read($file);

# 文字を記入する
#$image->Annotate(text=>$text, stroke=>'#FFFFFF', fill=>'#005599',
#                 font=>'sazanami-gothic.ttf', pointsize=>'36',
#                 x=>'20', y=>'40', encoding=>'UTF-8');

if($text){
	$text =~ s/BBRR/\n/g;

	$image->Annotate(
						text		=>	$text, 
						stroke		=>	$stroke, 
						strokewidth	=>	2,
						fill		=>	$fill,
						#fill		=>	'#005599',
						font		=>	$font, 
						pointsize	=>	$size,
						x			=>	$x, 
						y			=>	$y, 
						encoding	=>	'UTF-8'
					);
}

my $set_w = 240;
# 画像の情報を得る（幅、高さ）
my ($width, $height) = $image->Get('width', 'height');

if($set_w<$width && $flg>0){
	my $b = $set_w/$width;

	$width  = $b * $width;
	$height = $b * $height;

	# 画像をリサイズする
	$image->Resize(width=>$width, height=>$height, blur=>$b);
}

# 画像出力
#print "Content-type: image/jpeg\n\n";

binmode STDOUT;
$image->Write('jpeg:-');

undef $image;
exit;