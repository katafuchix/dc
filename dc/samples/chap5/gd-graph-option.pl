#!/user/local/perl

print "Content-type: image/png\n\n";  #HTTP�w�b�_�o��

use GD::Graph::linespoints;           # �܂���^�_�O���t���W���[���̓Ǎ���
@data = (                             # �O���t�̃f�[�^��ݒ�
  ["1st","2nd","3rd","4th","5th"],
  [-3,1,3,5,15],
  [2,4,6,8,10],
);
$graph = new GD::Graph::linespoints();# �܂���^�_�O���t�I�u�W�F�N�g�𐶐�
$graph->set(                          # �I�v�V������ݒ�
  title => "sample title",            # �^�C�g����ݒ�
  x_label => "X LABEL",               # x���̃��x����ݒ�
  y_label => "Y LABEL",               # y���̃��x����ݒ�
  # x���^y�����x���l��2��΂��ŕ\��
  x_label_skip => 2, y_label_skip => 2,
  show_values => 1,                   # �O���t��Ƀf�[�^�l��\��
  valuesclr => "black",               # �f�[�^�l�̐F�����ɐݒ�
  # �O���t�̏㉺���E�̃}�[�W����ݒ�
  t_margin => 10,  b_margin => 10,  l_margin => 10,  r_margin => 10,
  long_ticks => 1,                    # x��y���ɖڐ��������
  x_tick_number => 6,                 # x���̖ڐ�����6�ɐݒ�
  y_tick_number => 10,                # y���̖ڐ�����10�ɐݒ�
  dclrs => [ qw(red blue) ],          # �܂���̐F��ԁA�ɐݒ�
  # �܂���̎�ނ��h�b�g���A�h�b�g-�_�b�V�����ɐݒ�
  line_types => [3, 4], 
  # �������x���l�̍ő�l�ƍŏ��l��ݒ�
  y_min_value => -5,  y_max_value => 20,
  axis_space  => 10,                  # ���ƃ��x���l�̊Ԋu��10�ɕύX
  # �_�̎�ނ�h��Ԃ��ꂽ�H�`�A�h��Ԃ��ꂽ�l�p�ɐݒ�
  markers => [5,1],
  ); 
binmode STDOUT;                       # �o�C�i���o�͂ɐݒ�
print $graph->plot(\@data)-> png;     # PNG�`���ŃO���t��`��


