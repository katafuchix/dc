#!/user/local/perl

print "Content-type: image/png\n\n";  #HTTP�w�b�_�o��

use GD::Graph::lines;                     # �܂���O���t���W���[���̓Ǎ���
@data = (                                 # �O���t�̃f�[�^��ݒ�
  ["1st","2nd","3rd","4th","5th"],
  [1,3,5,7,9],                            # legend_1�p�f�[�^��ݒ�
  [2,4,6,8,10],                           # legend_2�p�f�[�^��ݒ�
);
$graph = new GD::Graph::lines();          # �܂���O���t�I�u�W�F�N�g���쐬
$graph->set_legend(                       #�}��̐ݒ�
                   "legend_1",
                   "legend_2",
);
$graph->set(                              #�}��̃I�v�V������ݒ�
            "legend_placement" => "RT",   #�E��ɔz�u
            "legend_spacing" => 5,        #�O���t�Ɩ}��̊Ԋu���w��
            "legend_marker_width" => 24,  #�}�[�J�[�̕����w��
            "legend_marker_height" => 16, #�}�[�J�[�̍������w��
);
binmode STDOUT;                          # �o�C�i���o�͂ɐݒ�
print $graph->plot(\@data)-> png;        # PNG�`���ŃO���t��`��

