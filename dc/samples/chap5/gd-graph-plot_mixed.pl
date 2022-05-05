#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTP�w�b�_�o��

use GD::Graph::mixed;                # �����O���t���W���[���̓Ǎ���
@data = (                            # �O���t�̃f�[�^��ݒ�
  ["1st","2nd","3rd","4th","5th"],   # x�����̒l�̐ݒ�
  [1,3,5,7,9],                       # y�����̒l�̐ݒ�(1�{��)
  [2,4,6,8,10]                       # y�����̒l�̐ݒ�(2�{��)
);

$graph = new GD::Graph::mixed();     # �����O���t�I�u�W�F�N�g���쐬
# �����O���t��1�{�ڂ��c�_�O���t�ɁA2�{�ڂ�܂���O���t�ɐݒ�
$graph->set(
  types => [ 'bars', 'lines'],
);

binmode STDOUT;                      # �o�C�i���o�͂ɐݒ�
print $graph->plot(\@data)-> png;    # PNG�`���ŃO���t��`��

