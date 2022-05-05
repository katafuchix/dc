#!/usr/bin/perl -w
#
# PerlMagick�� sfont �摜�̍쐬�����Ă݂��肷��e�X�g�B
# 1�������摜���쐬���āA�Ō�Ɍ�������B
#
# �E �J�����g�t�H���_�ɁA .ttf ���K�v�B
# �E �J�����g�t�H���_�ɁA��ʂ̕����摜���쐬����̂Œ��ӁB
#
# ������F
# Active Perl 5.8.8 build 820
# ImageMagick 6.3.3 Q8 windows
#
# 2007/06/06 ver. 0.0.1 �Ƃ肠�����쐬�B


use strict;
use warnings;
use Image::Magick;

# ----------------------------------------
# �ݒ蕔��

# �ŏI�o�̓t�@�C����
my $outfilename = "image.png";

# �t�H���g��ގw��B
# ttf �t�@�C�����J�����g�t�H���_�ɓ���Ă����āA�w�肷��B
# my $fontname = "VeraBd.ttf";
#my $fontname = "VL-Gothic-Regular.ttf";
my $fontname = 'elenat.ttf';

# �t�H���g�T�C�Y(�|�C���g)�w��
# my $fontsize = 20;
my $fontsize = 64;

# �`���ɏk�����邩�ۂ� (0=none, 1=sharp, 2=not sharp, 3=1/2)
# my $resize_enable = 0;
my $resize_enable = 1;

# �k������ۂ̔䗦�B 1 / $resize_scale �̉摜�T�C�Y�ɂȂ�B
my $resize_scale = 3;

# ���������ςɂ��邩�A�Œ�ɂ��邩�B(0:��, 1:�Œ�)
# my $width_fix_enable = 1;
my $width_fix_enable = 0;

# �e�����h�b�g���炷��
# my $roll_x = 2;
# my $roll_y = 2;

my $roll_x = 6;
my $roll_y = 6;

# �����F�w��
my $foreground_color = 'white';

# �O���f�[�V�����w��A
my $grade_enable = 1;
my $grade_make_enable = 1;

# $grade_make_enable == 1 �Ȃ�A�w��̃O���f�[�V���������
my $gradecol = 'gradient:' . '#00ffff-#00ff00';

# $grade_make_enable == 0 �Ȃ�摜�t�@�C����ǂݍ���Ŏg��
my $gadeimagefilename = "_____testgrade.png";

# �X�g���[�N(�����)�F�w��
my $stroke_color = 'black';

# �X�g���[�N���w��
# my $stroke_width = '3';
my $stroke_width = '8';

# �e�F�w��B�F�́Ar,g,b,alpha �̏��ŕ���ł�
my $background_color = '#00000080';

# �摜�쐬���̗]��dot���B��r�I�]�T���������邱��
my $canvas_space = $fontsize * 2;

# �O���f�[�V�������n�摜�̗]��dot��
# �ꍇ�ɂ���Ă͑���Ȃ��ꍇ������̂Œ������K�v
my $grade_space = 32;

# sfont�̃X�y�[�X����������`�悷�邩�ۂ�
# 0:�`�悵�Ȃ� / 1:�`�悷��
my $sfont_spc_dot_enable = 1;

# sfont�̃X�y�[�X���������̐F�w��
my $sfont_spc_dot_color = '#ff00ff';

# �e�ɂڂ����������邩�ۂ� (0:�����Ȃ� / 1:������)
my $blur_enable = 1;

# �e�ɂڂ�����������ꍇ�̂ڂ�����
my $blur_radius = 3;
my $blur_sigma = 5;

# �����������o�͂��ăe�X�g����Ȃ�A1 �ɁB
my $test_output_enable = 0;

# �ݒ肱���܂�
# ----------------------------------------


# �`�悷�镶���̏��B �u!�v�`�u~�v�܂ł�ASCII������`�悷��B
my $start_ascii = ord('!');

my $end_ascii = ord('~');
$end_ascii = ord(')') if $test_output_enable == 1;

my $textlength = $end_ascii - $start_ascii + 1;

# �e�����̕`��T�C�Y�L�^�p���[�N��p��
my @imgsize = ();

# �K�v�ɂȂ�ł��낤�摜�T�C�Y�����߂�
my $global_w = $fontsize + $canvas_space;
my $global_h = $fontsize + $canvas_space;

# �`��ʒu�����߂�
my $dx = int(($global_w - $fontsize) / 2);
my $dy = $fontsize + int($canvas_space / 2);

# �O���f�[�V�����̉��n�摜���쐬
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
# 1�������������Ă���

my $idx = 0;
print "output image ...\n";

for ( my $i = 0; $i < $textlength; $i++ ) {

	# ���������镶����p�ӂ���
	my $text = chr($start_ascii + $i);
	print $text . " ";

	# �u\�v������肭�����Ȃ��c
	$text = '\\\\' if ( $start_ascii + $i == 0x5c );

	if ( 1 ) {
		# �摜��V�K�쐬

		my $w = $global_w;
		my $h = $global_h;
		my $wh = $w . "x" . $h;

		my $image=Image::Magick->new;
		$image->Set(size=>$wh);

		# �w�i�𓧖��ɂ���
		$image->ReadImage('xc:transparent');
		# $image->ReadImage('xc:white');

		# --------------------
		# ����������
		# �����̃f�U�C����ς���Ȃ�A�����ȍ~��M��

		# �e��`��
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

		# �e�̈ʒu�����炷
		$image->Roll(x=>$roll_x, y=>$roll_y);

		# �e���ڂ��� (�ڂ����Ƃ��� 0 -> 1 �ɏ���������)
		if ( $blur_enable != 0 ) {
			if ( $blur_enable == 1 ) {
				$image->Blur(radius=>$blur_radius, sigma=>$blur_sigma, channel=>'All');
			} else {
				$image->GaussianBlur(radius=>$blur_radius, sigma=>$blur_sigma, channel=>'All');
			}
		}

		# ������`��
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
			# �O�i������P�F�ŕ`��
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
			# �O�i�������O���f�[�V�����ŕ`��

			# �}�X�N�摜���쐬
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

			# �O���f�[�V�����摜�ƃ}�X�N�摜���g���āA
			# �O���f�[�V�����̂������������摜�𓾂�

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

		# �`�悱���܂�
		# --------------------

		# �摜�����T�C�Y����(�ݒ�ɂ���Ă͏k�����Ȃ�)
		if ( $resize_enable != 0 ) {
			my $r_width = $w / $resize_scale;
			my $r_height = $h / $resize_scale;

			if ( $resize_enable == 1 ) {
				# �V���[�v�ɂ��ďk��
				$image->Resize(width=>$r_width, height=>$r_height, blur=>0.7);
			} elsif ( $resize_enable == 2 ) {
				# �P�ɏk��
				$image->Resize(width=>$r_width, height=>$r_height);
			} else {
				# �����̃T�C�Y�ɏk��
				$image->Minify();
			}
		}

		# �摜�T�C�Y���擾
		my ($width, $height) = $image->Get('width', 'height');


		# �̈�T�C�Y�ɘg��`��(�m�F�p)
		if ( 0 ) {
			# ���ۂɕ`�悳��Ă�̈�T�C�Y���擾
			my ( $x_min, $y_min, $x_max, $y_max ) = split(/,/, get_image_true_size($image));

			# �g�`��
			my $linecolor = '#ff00ff80';
			$image->Draw(primitive=>'line', points=>"$x_min,$y_min,$x_max,$y_min", stroke=>$linecolor, strokewidth=>1);
			$image->Draw(primitive=>'line', points=>"$x_min,$y_max,$x_max,$y_max", stroke=>$linecolor, strokewidth=>1);
			$image->Draw(primitive=>'line', points=>"$x_min,$y_min,$x_min,$y_max", stroke=>$linecolor, strokewidth=>1);
			$image->Draw(primitive=>'line', points=>"$x_max,$y_min,$x_max,$y_max", stroke=>$linecolor, strokewidth=>1);
		}

		# ���ۂ̕`��T�C�Y���L�^���Ă���
		$imgsize[$i] = get_image_true_size($image);

		# png�摜�Ƃ��ďo��
		# ���1����肪�������ǂ������m�F�ł���悤��
		# 1�������{���ʂɏo�͂��Ďc���Ă���

		my $fname = sprintf("____%04d.gif", $i);
		$image->Write(filename=>$fname);

		undef $image;

		print "\n" if ($i % 16) == 15;
	}

	$idx++;
}
print "\n\n";

# ----------------------------------------
# �S�����̕`��T�C�Y�������߂�

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
# �e�摜���g���~���O�H �N���b�s���O�H ���Ă���

print "trim image ...\n";
for ( my $i =0 ; $i < $textlength; $i++ ) {

	print chr($start_ascii + $i) . " ";

	my $fname = sprintf("____%04d.gif", $i);

	my $image = Image::Magick->new;
	$image->Read($fname);

	# ���ۂ̕`��T�C�Y���擾
	my ($x0,$y0,$x1,$y1) = split(/,/, get_image_true_size($image));

	if ( $width_fix_enable == 1 ) {
		# �����̉������Œ�ɂ���ꍇ�̏���
		my $xc = int(($x0 + $x1) / 2);
		$x0 = $xc - int($xw/2);
		$x1 = $x0 + $xw - 1;
	}

	# sfont �X�y�[�X�p�̈�����邽�߂ɁA
	# ������dot���₵�Ă���
	if ( $sfont_spc_dot_enable == 1 ) {
		$x0 -= 2;
		$x1 += 2;
	}

	# �O�̂��߂ɁA�c�������㉺1dot�]�T����������
	$y0 = $y_min - 1;
	$y1 = $y_max + 1;
	my $w = $x1 - $x0 + 1;
	my $h = $y1 - $y0 + 1;

	# �N���b�s���O
	$image->Crop(width=>$w, height=>$h, x=>$x0, y=>$y0);

	# ���e�� sfont �X�y�[�X�p�̈��`��
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

	# �o��
	$fname = sprintf("___%04d.gif", $i);
	$image->Write(filename=>$fname);
	undef $image;

	print "\n" if ($i % 16) == 15;
}
print "\n\n";

# ----------------------------------------
# �������ďo��
if ( 1 ) {
	my $image = Image::Magick->new;

	# ��U�S�摜��ǂݍ���
	print "read image ...\n";
	for ( my $i = 0; $i < $textlength; $i++ ) {
		my $text = chr($start_ascii + $i);
		print $text . " ";

		my $fname = sprintf("___%04d.gif", $i);
		$image->Read($fname);

		print "\n" if ($i % 16) == 15;
	}
	print "\n\n";

	# ����
	my $tilestr = $textlength . "x1";
	my $montage = $image->Montage(mode=>'Concatenate', tile=>$tilestr, background=>'transparent');

	# �o��
	$montage->Write(filename=>$outfilename);
	undef $image;

	print "... output $outfilename\n";
}

exit;


# ----------------------------------------

# �摜��1�h�b�g�����ׂāA���ۂɕ`�悳��Ă�̈�T�C�Y��Ԃ�
sub get_image_true_size {
	my ($img) = @_;

	# �摜�T�C�Y���擾
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
				# ��������Ȃ�������

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
