#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTP�w�b�_�o��

use GD;
$img = newFromPng GD::Image('./gd_sample.PNG'); #gd_sample.PNG��ǂݍ���
@img_size = $img->getBounds();                  #gd_sample.PNG�̃T�C�Y���擾
print @img_size[0]."x".@img_size[1];            #gd_sample.PNG�̃T�C�Y��\��
                                                #���ʗ�F"131x108"
print "</body></html>"; #HTML�o��

