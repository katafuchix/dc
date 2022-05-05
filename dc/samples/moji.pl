#!/usr/bin/perl

#use strict;
use Jcode;
use Image::Magick;
use Encode;


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




# 画像を指定
my $file = "sample1.JPG";

# 合成したい文字列
#my $text = "あaaaABC123日本語";
my $text = $param_value{'text'};

my $font= '/var/www/html/dc/samples/font/anzu.ttf';

#print "Content-type: text/html\n\n";
#print $text;
#print $param_value{'stamp'};

#exit;

# UTF-8へ変換
$text = jcode($text)->utf8;
#Encode::from_to ( $text , "euc-jp" , "utf8" ); 

#$text = jcode(urldecode($text))->utf8;

# オブジェクト作成
my $image = Image::Magick->new;

# 画像読み込み
$image->Read($file);

# 文字を記入する
#$image->Annotate(text=>$text, stroke=>'#FFFFFF', fill=>'#005599',
#                 font=>'sazanami-gothic.ttf', pointsize=>'36',
#                 x=>'20', y=>'40', encoding=>'UTF-8');

$image->Annotate(text=>$text, stroke=>'#FFFFFF', fill=>'#005599',
                 font=>$font, pointsize=>'60',
                 x=>'10', y=>'40', encoding=>'UTF-8');
                 
# 画像出力
#print "Content-type: image/jpeg\n\n";
binmode STDOUT;
$image->Write('jpeg:-');

undef $image;
exit;