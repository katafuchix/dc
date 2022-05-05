#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTP�w�b�_�o��

use DBI;            # DBI���W���[���̌Ăяo��
# MySQL��sample�f�[�^�x�[�X�֐ڑ�
$dbh = DBI->connect("dbi:mysql:sample", "root", "admin");
# test_table�Ƃ����e�[�u�����쐬����SQL�X�e�[�g�����g
$create_statement = "CREATE TABLE `test_table` (
                                               `id` int,            # ID
                                               `name` varchar(255), # ���O
                                               `tel` varchar(12)    # �d�b�ԍ�
                                               )";
# �ǉ�����f�[�^�̒l
# �@id�F1  ���O�FJohn  �d�b�ԍ��F99-9999-9999
# test_table�Ƀf�[�^��ǉ�����SQL�X�e�[�g�����g
$insert_statement = "INSERT INTO `test_table`
                     VALUES (1, 'John', '99-9999-9999')";
# test_table����w�肵��id�����f�[�^�������擾����SQL�X�e�[�g�����g
$select_statement = "SELECT COUNT(*) FROM test_table WHERE id = ? ";
# create_statemen��do���\�b�h�Ŏ��s
$rc = $dbh->do($create_statement) || die $dbh->errstr;
# insert_statement��prepare���\�b�h��execute���\�b�h��g�ݍ��킹���֐��Ŏ��s
prepare_execute_do($dbh,$insert_statement);
# id��1�����f�[�^�������擾
$sth = $dbh->prepare($select_statement) or print $dbh->errstr; #SQL������
# �v���[�X�z���_��1�����蓖�Ă�SQL�����s
$rv = $sth->execute(1) or print $sth->errstr;
while( my $ref = $sth->fetch ){              # �������ʂ��擾
  my ($count) = @$ref;
  print "id��1�����f�[�^�����F".$count;
  # ���ʁFid��11�����f�[�^�����F1
}
$dbh->disconnect(); #�f�[�^�x�[�X�Ɛؒf
print "</body></html>";              #HTML�o��

#prepare���\�b�h��execute���\�b�h��g�ݍ��킹��do���\�b�h�Ɠ��������̊֐�
sub prepare_execute_do { 
    my($dbh, $statement, $attr, @bind_values) = @_;
    my $sth = $dbh->prepare($statement, $attr) or return undef;
    $sth->execute(@bind_values) or return undef;
    my $rows = $sth->rows;
    ($rows == 0) ? "0E0" : $rows; # always return true if no error
}
