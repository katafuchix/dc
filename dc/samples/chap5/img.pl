#!/usr/bin/perl
print "Content-type: image/jpeg\n\n";

use Image::Magick;
use Encode;
$string = "hello";
Encode::from_to ( $string , "shiftjis" , "utf8" ); #ʸ�������ɤ�UTF-8���Ѵ�
$font_path = "msgothic.ttc";
$image = Image::Magick->new;           # �������֥������Ȥ�����
$image ->Read("sample1.JPG");          # ������200x160�������ˤ��ɤ߹���
#$image->Annotate(                      # ʸ���������˽񤭽Ф�
#                 text=> $string,    # �񤭽Ф�ʸ��������ꡧAnnotate
#                 stroke=>"red",        # ʸ����Υ����ȥ饤��ο���������֡�
#                 strokewidth => 2,     # ʸ����Υ����ȥ饤�����������(2)
#                 fill=>"white",        # ʸ��������������
#                 undercolor => "pink", # �طʿ�������ʥԥ󥯡�
#                 font=>$font_path,     # ʸ����Υե���Ȥ������msgothic��
#                 pointsize=>"26",      # ʸ����Υ������������26��
#                 x=>"150", y=>"100",   # ʸ��������δ������ɸ�������150,100��
#                 antialias => true,    # ����������ꥢ��
##                gravity => Center,    # ʸ��������δ��������Ѥ�������濴��
#                 align => Left,        # ʸ��������δ����δ����ʺ��󤻡�
#                 rotate => 180,        # ʸ����β�ž���٤�����(180��)
#                 skewX=>12.5,          # ʸ�����x�����η��Ф������12.5��
#                 skewY=>5.5,           # ʸ�����y�����η��Ф������5.5��
#                 );

$image->Annotate(text=>$string, stroke=>'#FFFFFF', fill=>'#005599',
                 font=>'VL-Gothic-Regular.ttf', pointsize=>'36',
                 x=>'20', y=>'40', encoding=>'UTF-8');
                 
binmode STDOUT;
$image->Write("jpeg:-");               # ������JPEG�ǽ���
undef $image;                          # �������֥������Ȥ��˴����ƥ������
exit;
