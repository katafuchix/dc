#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTP�w�b�_�o��

use GD;
$img = new GD::Image(100,100);
$blue  = $img->colorAllocate(0,0,255);       # ��ݒ�
@rgb_val = $img->rgb($blue);                 # ��RGB�l���擾
print join(",",@rgb_val);                    # RGB�l��\�� ���ʁF0,0,255

print "</body></html>"; #HTML�o��

