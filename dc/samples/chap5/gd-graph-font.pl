#!/user/local/perl

print "Content-type: image/png\n\n";  #HTTP�w�b�_�o��

use GD;
use GD::Graph::lines;                     # �܂���O���t���W���[���̓Ǎ���
@data = (                                 # �O���t�̃f�[�^��ݒ�
  ["1st","2nd","3rd","4th","5th"],
  [1,3,5,7,9],
);
$graph = new GD::Graph::lines();          # �܂���O���t�I�u�W�F�N�g���쐬
$graph->set(                              # �I�v�V������ݒ�
  title => "sample title",                # �^�C�g����ݒ�
  x_label => "X LABEL",                   # x���̃��x����ݒ�
  y_label => "Y LABEL",                   # y���̃��x����ݒ�
); 
$graph->set_title_font(gdGiantFont);      # �^�C�g���̃t�H���g���w��
$graph->set_x_label_font(gdSmallFont);    # x�����x���̃t�H���g���w��
$graph->set_y_label_font(gdTinyFont);     # y�����x���̃t�H���g���w��
binmode STDOUT;                           # �o�C�i���o�͂ɐݒ�
print $graph->plot(\@data)-> png;         # PNG�`���ŃO���t��`��

