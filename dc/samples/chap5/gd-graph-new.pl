#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTP�w�b�_�o��

use GD::Graph::bars; # �_�O���t���W���[���̓Ǎ���
@data = ( [1..9], # x���f�[�^
[2, 1, 3, 0, 5, 6, 1, 2, 2] ); # y���f�[�^
$graph = new GD::Graph::bars(); # �_�O���t�I�u�W�F�N�g�𐶐�
binmode STDOUT; # �o�C�i���o�͂ɐݒ�
print $graph->plot(\@data)->png; # PNG�`���ŃO���t��`��

