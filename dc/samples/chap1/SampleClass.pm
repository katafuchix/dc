package SampleClass;        #�p�b�P�[�W����錾
sub new {                   #�R���X�g���N�^��錾
  my $class = shift;        #�N���X�����󂯎��
  my $self = {};            #���t�@�����X����
  return bless $self,$class;#�����N���X��錾���ă��t�@�����X��Ԃ�
}
sub getString{              #�N���X�̃��\�b�h��`
  return "SampleClass::getString!"; #�������Ԃ�
}
1;                          #�Ō�ɐ^��Ԃ�
