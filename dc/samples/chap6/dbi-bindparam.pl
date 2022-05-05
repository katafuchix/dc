#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTP�w�b�_�o��

use DBI;            # DBI���W���[���̌Ăяo��
# MySQL��sample�f�[�^�x�[�X�֐ڑ�
$dbh = DBI->connect("dbi:mysql:sample", "root", "admin");
@ids = (1,2); #�o�C���h�p��id���Z�b�g
# test_table�Ɋi�[����Ă���f�[�^��ID���w�肵�Ď擾����SQL
# ID�����Ƀv���[�X�z���_�����蓖�Ă�
$select_sql = "SELECT * FROM test_table WHERE id = ? ";
$sth = $dbh->prepare($select_sql) or print $dbh->errstr; #SQL������
foreach(@ids){
  $sth->bind_param(1,$_);  # SELECT���̃v���[�X�z���_�ɒl��������
  $rv = $sth->execute() or print $sth->errstr; # SQL�����s
  while( my $ref = $sth->fetch ){              # �������ʂ��擾
    my ($id, $name,$tel) = @$ref;
    print $id."|".$name."|".$tel."<br>";       # �������ʂ�\��
  }                                            # ���ʁF1|John|99-9999-9999
}                                              #       2|Perl|99-9999-9991
$dbh = DBI->disconnect();

print "</body></html>";              #HTML�o��
