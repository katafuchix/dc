#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTP�w�b�_�o��

use GD;
$img = new GD::Image(100,100);
$white = $img->colorAllocate(255,255,255);   #����ݒ�
$black = $img->colorAllocate(0,0,0);         #����ݒ�
$poly = new GD::Polygon;             # ���p�`�I�u�W�F�N�g���쐬
$poly->addPt(10,10);                 # ���_���W(10,10)��ǉ�
$poly->addPt(30,10);                 # ���_���W(30,10)��ǉ�
$poly->addPt(10,35);                 # ���_���W(10,35)��ǉ�
print $poly->length."<br>";          # ���_���\���F3
@poly_vertices = $poly->vertices;    # 3�̒��_���W�̃��X�g���擾
foreach $v ($poly->vertices){        # ���_���W���擾
   print "(".join(',',@$v).")";      # ���ʗ�F(10,10)(30,10)(10,35)
}
# �O�p�`���͂ލŏ��̎l�p�`�̍��W���擾
print "<br>(".join(',',$poly->bounds).")";  # ���ʗ�F(10,10)(30,10)(10,35)

print "</body></html>"; #HTML�o��

