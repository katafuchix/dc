#!/usr/bin/perl -w
#
# PerlMagickで sfont 画像の作成をしてみたりするテスト。
# 1文字ずつ画像を作成して、最後に結合する。
#
# ・ カレントフォルダに、 .ttf が必要。
# ・ カレントフォルダに、大量の文字画像を作成するので注意。
#
# 動作環境：
# Active Perl 5.8.8 build 820
# ImageMagick 6.3.3 Q8 windows
#
# 2007/06/06 ver. 0.0.1 とりあえず作成。


use strict;
use warnings;
use Image::Magick;

# ----------------------------------------
# 設定部分

# 最終出力ファイル名
my $outfilename = "image.png";

# フォント種類指定。
# ttf ファイルをカレントフォルダに入れておいて、指定する。
# my $fontname = "VeraBd.ttf";
#my $fontname = "VL-Gothic-Regular.ttf";
my $fontname = 'elenat.ttf';

# フォントサイズ(ポイント)指定
# my $fontsize = 20;
my $fontsize = 64;

# 描画後に縮小するか否か (0=none, 1=sharp, 2=not sharp, 3=1/2)
# my $resize_enable = 0;
my $resize_enable = 1;

# 縮小する際の比率。 1 / $resize_scale の画像サイズになる。
my $resize_scale = 3;

# 文字幅を可変にするか、固定にするか。(0:可変, 1:固定)
# my $width_fix_enable = 1;
my $width_fix_enable = 0;

# 影を何ドットずらすか
# my $roll_x = 2;
# my $roll_y = 2;

my $roll_x = 6;
my $roll_y = 6;

# 文字色指定
my $foreground_color = 'white';

# グラデーション指定、
my $grade_enable = 1;
my $grade_make_enable = 1;

# $grade_make_enable == 1 なら、指定のグラデーションを作る
my $gradecol = 'gradient:' . '#00ffff-#00ff00';

# $grade_make_enable == 0 なら画像ファイルを読み込んで使う
my $gadeimagefilename = "_____testgrade.png";

# ストローク(縁取り)色指定
my $stroke_color = 'black';

# ストローク幅指定
# my $stroke_width = '3';
my $stroke_width = '8';

# 影色指定。色は、r,g,b,alpha の順で並んでる
my $background_color = '#00000080';

# 画像作成時の余白dot数。比較的余裕を持たせること
my $canvas_space = $fontsize * 2;

# グラデーション下地画像の余白dot数
# 場合によっては足りない場合もあるので調整が必要
my $grade_space = 32;

# sfontのスペースを示す線を描画するか否か
# 0:描画しない / 1:描画する
my $sfont_spc_dot_enable = 1;

# sfontのスペースを示す線の色指定
my $sfont_spc_dot_color = '#ff00ff';

# 影にぼかしをかけるか否か (0:かけない / 1:かける)
my $blur_enable = 1;

# 影にぼかしをかける場合のぼかし量
my $blur_radius = 3;
my $blur_sigma = 5;

# 数文字だけ出力してテストするなら、1 に。
my $test_output_enable = 0;

# 設定ここまで
# ----------------------------------------


# 描画する文字の情報。 「!」〜「~」までのASCII文字を描画する。
my $start_ascii = ord('!');

my $end_ascii = ord('~');
$end_ascii = ord(')') if $test_output_enable == 1;

my $textlength = $end_ascii - $start_ascii + 1;

# 各文字の描画サイズ記録用ワークを用意
my @imgsize = ();

# 必要になるであろう画像サイズを求める
my $global_w = $fontsize + $canvas_space;
my $global_h = $fontsize + $canvas_space;

# 描画位置を求める
my $dx = int(($global_w - $fontsize) / 2);
my $dy = $fontsize + int($canvas_space / 2);

# グラデーションの下地画像を作成
my $grade=Image::Magick->new;
if ( $grade_make_enable == 1 ) {
	my $gsize_str = ($fontsize + $grade_space) . 'x' . ($fontsize + $grade_space);
	$grade->Set(size=>$gsize_str);
	$grade->ReadImage($gradecol);
	$grade->Write(filename=>'_____testgrade.png');
} else {
	$grade->Read($gadeimagefilename);
}


# ----------------------------------------
# 1文字ずつ処理していく

my $idx = 0;
print "output image ...\n";

for ( my $i = 0; $i < $textlength; $i++ ) {

	# 処理をする文字を用意する
	my $text = chr($start_ascii + $i);
	print $text . " ";

	# 「\」だけ上手くいかない…
	$text = '\\\\' if ( $start_ascii + $i == 0x5c );

	if ( 1 ) {
		# 画像を新規作成

		my $w = $global_w;
		my $h = $global_h;
		my $wh = $w . "x" . $h;

		my $image=Image::Magick->new;
		$image->Set(size=>$wh);

		# 背景を透明にする
		$image->ReadImage('xc:transparent');
		# $image->ReadImage('xc:white');

		# --------------------
		# 文字を書く
		# 文字のデザインを変えるなら、ここ以降を弄る

		# 影を描画
		$image->Annotate(
			font=>$fontname,
			density=>72,
			pointsize=>$fontsize,
			x=>$dx,
			y=>$dy,
			fill=>$background_color,
			stroke=>$background_color,
			strokewidth=>$stroke_width,
			antialias=>'true',
			text=>$text);

		# 影の位置をずらす
		$image->Roll(x=>$roll_x, y=>$roll_y);

		# 影をぼかす (ぼかすときは 0 -> 1 に書き換える)
		if ( $blur_enable != 0 ) {
			if ( $blur_enable == 1 ) {
				$image->Blur(radius=>$blur_radius, sigma=>$blur_sigma, channel=>'All');
			} else {
				$image->GaussianBlur(radius=>$blur_radius, sigma=>$blur_sigma, channel=>'All');
			}
		}

		# 縁取りを描画
		$image->Annotate(
			font=>$fontname,
			density=>72,
			pointsize=>$fontsize,
			x=>$dx,
			y=>$dy,
			fill=>$stroke_color,
			stroke=>$stroke_color,
			strokewidth=>$stroke_width,
			antialias=>'true',
			text=>$text);

		if ( $grade_enable == 0 ) {
			# 前景文字を単色で描画
			$image->Annotate(
				font=>$fontname,
				density=>72,
				pointsize=>$fontsize,
				x=>$dx,
				y=>$dy,
				fill=>$foreground_color,
				stroke=>'none',
				antialias=>'true',
				text=>$text);
		} else {
			# 前景文字をグラデーションで描画

			# マスク画像を作成
			my $mask = Image::Magick->new;
			$mask->Set(size=>$wh);
			$mask->ReadImage('xc:black');

			$mask->Annotate(
				font=>$fontname,
				density=>72,
				pointsize=>$fontsize,
				x=>$dx,
				y=>$dy,
				fill=>'white',
				stroke=>'none',
				antialias=>'true',
				text=>$text);

			# $mask->Write(filename=>'testmask.png');

			# グラデーション画像とマスク画像を使って、
			# グラデーションのかかった文字画像を得る

			my $ndx = $dx-int($grade_space/2);
			my $ndy = $dy-$fontsize-int($grade_space/2);

			my $compimg = Image::Magick->new;
			$compimg->Set(size=>$wh);
			$compimg->ReadImage('xc:transparent');

			$compimg->Composite(
				image=>$grade,
				compose=>'Over',
				x=>$ndx,
				y=>$ndy,
				mask=>$mask);

			# $compimg->Write(filename=>'testcomp.png');

			$image->Composite(
				image=>$compimg,
				compose=>'Over',
				x=>0,
				y=>0);

			undef $mask;
			undef $compimg;
		}

		# 描画ここまで
		# --------------------

		# 画像をリサイズする(設定によっては縮小しない)
		if ( $resize_enable != 0 ) {
			my $r_width = $w / $resize_scale;
			my $r_height = $h / $resize_scale;

			if ( $resize_enable == 1 ) {
				# シャープにして縮小
				$image->Resize(width=>$r_width, height=>$r_height, blur=>0.7);
			} elsif ( $resize_enable == 2 ) {
				# 単に縮小
				$image->Resize(width=>$r_width, height=>$r_height);
			} else {
				# 半分のサイズに縮小
				$image->Minify();
			}
		}

		# 画像サイズを取得
		my ($width, $height) = $image->Get('width', 'height');


		# 領域サイズに枠を描画(確認用)
		if ( 0 ) {
			# 実際に描画されてる領域サイズを取得
			my ( $x_min, $y_min, $x_max, $y_max ) = split(/,/, get_image_true_size($image));

			# 枠描画
			my $linecolor = '#ff00ff80';
			$image->Draw(primitive=>'line', points=>"$x_min,$y_min,$x_max,$y_min", stroke=>$linecolor, strokewidth=>1);
			$image->Draw(primitive=>'line', points=>"$x_min,$y_max,$x_max,$y_max", stroke=>$linecolor, strokewidth=>1);
			$image->Draw(primitive=>'line', points=>"$x_min,$y_min,$x_min,$y_max", stroke=>$linecolor, strokewidth=>1);
			$image->Draw(primitive=>'line', points=>"$x_max,$y_min,$x_max,$y_max", stroke=>$linecolor, strokewidth=>1);
		}

		# 実際の描画サイズを記録しておく
		$imgsize[$i] = get_image_true_size($image);

		# png画像として出力
		# 後で1つずつ問題が無いかどうかを確認できるように
		# 1文字ずつ几帳面に出力して残しておく

		my $fname = sprintf("____%04d.gif", $i);
		$image->Write(filename=>$fname);

		undef $image;

		print "\n" if ($i % 16) == 15;
	}

	$idx++;
}
print "\n\n";

# ----------------------------------------
# 全文字の描画サイズ等を求める

my ($x_min, $y_min, $x_max, $y_max) = split(/,/, $imgsize[0]);
my $xw = $x_max - $x_min + 1;
my $yh = $y_max - $y_min + 1;
for ( my $i =0 ; $i < $textlength; $i++ ) {
	my ($x0,$y0,$x1,$y1) = split(/,/, $imgsize[$i]);
	$x_min = $x0 if $x0 < $x_min;
	$x_max = $x1 if $x1 > $x_max;
	$y_min = $y0 if $y0 < $y_min;
	$y_max = $y1 if $y1 > $y_max;
	my $w = $x1 - $x0 + 1;
	my $h = $y1 - $y0 + 1;
	$xw = $w if $w > $xw;
	$yh = $h if $h > $yh;
}
print "($x_min,$y_min)-($x_max,$y_max) (w,h)=($xw,$yh)\n\n";

# ----------------------------------------
# 各画像をトリミング？ クリッピング？ していく

print "trim image ...\n";
for ( my $i =0 ; $i < $textlength; $i++ ) {

	print chr($start_ascii + $i) . " ";

	my $fname = sprintf("____%04d.gif", $i);

	my $image = Image::Magick->new;
	$image->Read($fname);

	# 実際の描画サイズを取得
	my ($x0,$y0,$x1,$y1) = split(/,/, get_image_true_size($image));

	if ( $width_fix_enable == 1 ) {
		# 文字の横幅を固定にする場合の処理
		my $xc = int(($x0 + $x1) / 2);
		$x0 = $xc - int($xw/2);
		$x1 = $x0 + $xw - 1;
	}

	# sfont スペース用の印を入れるために、
	# 横幅を数dot増やしておく
	if ( $sfont_spc_dot_enable == 1 ) {
		$x0 -= 2;
		$x1 += 2;
	}

	# 念のために、縦方向も上下1dot余裕を持たせる
	$y0 = $y_min - 1;
	$y1 = $y_max + 1;
	my $w = $x1 - $x0 + 1;
	my $h = $y1 - $y0 + 1;

	# クリッピング
	$image->Crop(width=>$w, height=>$h, x=>$x0, y=>$y0);

	# 両脇に sfont スペース用の印を描画
	if ( $sfont_spc_dot_enable == 1 ) {
		my ($width, $height) = $image->Get('width', 'height');
		my $x0 = 0;
		my $y0 = 0;
		my $x1 = 1;
		my $linecolor = $sfont_spc_dot_color;

		$image->Draw(primitive=>'line', points=>"$x0,$y0,$x1,$y0", stroke=>$linecolor, strokewidth=>1);

		$x0 = $width - 2;
		$x1 = $width - 1;
		$image->Draw(primitive=>'line', points=>"$x0,$y0,$x1,$y0", stroke=>$linecolor, strokewidth=>1);
	}

	# 出力
	$fname = sprintf("___%04d.gif", $i);
	$image->Write(filename=>$fname);
	undef $image;

	print "\n" if ($i % 16) == 15;
}
print "\n\n";

# ----------------------------------------
# 結合して出力
if ( 1 ) {
	my $image = Image::Magick->new;

	# 一旦全画像を読み込む
	print "read image ...\n";
	for ( my $i = 0; $i < $textlength; $i++ ) {
		my $text = chr($start_ascii + $i);
		print $text . " ";

		my $fname = sprintf("___%04d.gif", $i);
		$image->Read($fname);

		print "\n" if ($i % 16) == 15;
	}
	print "\n\n";

	# 結合
	my $tilestr = $textlength . "x1";
	my $montage = $image->Montage(mode=>'Concatenate', tile=>$tilestr, background=>'transparent');

	# 出力
	$montage->Write(filename=>$outfilename);
	undef $image;

	print "... output $outfilename\n";
}

exit;


# ----------------------------------------

# 画像を1ドットずつ調べて、実際に描画されてる領域サイズを返す
sub get_image_true_size {
	my ($img) = @_;

	# 画像サイズを取得
	my ($width, $height) = $img->Get('width', 'height');

	my $x_min = $width+1;
	my $x_max = 0;
	my $y_min = $height+1;
	my $y_max = 0;

	for ( my $y = 0; $y <= $height; $y++ ) {
		for ( my $x = 0; $x <= $width; $x++ ) {
			my ($r, $g, $b, $a) = split(/,/, $img->Get("pixel[$x,$y]"));
			my $rgba = ($r << 24) | ($g << 16) | ($b << 8) | $a;

			if ( $rgba != 0x000000ff ) {
				# 透明じゃなかったら

				$x_min = $x if ($x < $x_min);
				$x_max = $x if ($x > $x_max);
				$y_min = $y if ($y < $y_min);
				$y_max = $y if ($y > $y_max);
			}
		}
		# print "\n";
	}

	# print "($x_min,$y_min)-($x_max,$y_max)\n";

	return join(",", ($x_min, $y_min, $x_max, $y_max) );
}

