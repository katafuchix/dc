#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTP�w�b�_�o��

use GD::Graph::pie;                  # �~�O���t���W���[���̓Ǎ���

@data = (                            # �O���t�̃f�[�^��ݒ�
  ["1st","2nd","3rd","4th","5th"],   # �~�O���t�̍��ڂ̐ݒ�
  [1,3,5,7,9],                       # �~�O���t�̒l�̐ݒ�(
  [2,4,6,8,10]                       # �����Őݒ肵���l�͖��������
);

$graph = new GD::Graph::pie();      # �_�O���t�I�u�W�F�N�g���쐬
binmode STDOUT;                      # �o�C�i���o�͂ɐݒ�
print $graph->plot(\@data)-> png;    # PNG�`���ŃO���t��`��


