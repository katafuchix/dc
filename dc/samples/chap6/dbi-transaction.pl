#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTP�w�b�_�o��

use DBI;            # DBI���W���[���̌Ăяo��
# MySQL��sample�f�[�^�x�[�X�֐ڑ�
$dbh = DBI->connect("dbi:mysql:sample", "root", "admin");
$dbh->{AutoCommit} = 0;  # �\�ł���΁A�g�����U�N�V������L���ɂ��܂�
$dbh->{RaiseError} = 1;  # �G���[�������ɗ�O�Ƃ��Ĉ���eval�֐��ɓn��
#test_table�Ɋi�[����Ă���f�[�^�������擾
$select_sql = "SELECT COUNT(*) FROM test_table ";
$ref = $dbh->selectrow_array($select_sql); # �f�[�^�ǉ��O�̃f�[�^������\��
print "sample_table�Ɋi�[����Ă���񐔁F".$ref."<br>"; #���ʁF3
eval {
    # test_table�Ƀf�[�^��ǉ�����SQL�X�e�[�g�����g
    $insert_statement = "INSERT INTO `test_table`
                            VALUES (4, 'Jim', '99-9999-9994')";
    $rc = $dbh->do($insert_statement) || die $dbh->errstr; #SQL�����s����
    $dbh->commit;   # �f�[�^�̒ǉ����R�~�b�g����
    print "�R�~�b�g���܂���<br>";
};
if ($@) {
    $dbh->rollback; # �������������܂�
    print "���[���o�b�N���܂���<br>";
}
$ref = $dbh->selectrow_array($select_sql); # �f�[�^�ǉ���̃f�[�^������\��
print "sample_table�Ɋi�[����Ă���񐔁F".$ref."<br>"; #���ʁF4
$dbh = DBI->disconnect();

print "</body></html>";              #HTML�o��
