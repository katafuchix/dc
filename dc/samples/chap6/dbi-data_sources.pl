#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTP�w�b�_�o��

use DBI;            # DBI���W���[���̌Ăяo��
@drivers = DBI->available_drivers; # ���p�\�ȃf�[�^�x�[�X�h���C�o�̎擾
foreach(@drivers){                 # �擾�����f�[�^�x�[�X�h���C�o����\��
  print $_."<br>";
}
#DBM�ŗ��p�\�ȃf�[�^�\�[�X���X�g���擾
@sources = DBI->data_sources(DBM); 
foreach(@sources){                 # �擾�����f�[�^�\�[�X����\��
  print $_."<br>";
}

print "</body></html>";              #HTML�o��

x