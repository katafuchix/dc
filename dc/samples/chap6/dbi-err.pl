#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTP�w�b�_�o��

use DBI;            # DBI���W���[���̌Ăяo��
# MySQL��sample�f�[�^�x�[�X�֐ڑ� �ڑ����s���ɂ̓G���[�o��
$db_source = "dbi:mysql:sample";
$dbh = DBI->connect($db_source, "root", "admin") || print $DBI::errstr."<br>" ;
# �G���[�o�͂����邽�߂�test_table�̎��ۂɂ͑��݂��Ȃ�aa�t�B�[���h����
# �f�[�^�擾����SQL�X�e�[�g�����g
$select_sql = "SELECT aa FROM test_table ";
# SQL������ ���s���ɂ̓G���[�o��
$sth = $dbh->prepare($select_sql) or print $dbh->errstr."<br>";
# SQL�����s ���s���ɂ̓G���[�o��
if (!$sth->execute()){
    print "�G���[�F ".$sth->err." ".$sth->errstr."<br>";
# ���ʁF�G���[�F 1054 Unknown column 'aa' in 'field list'
}
$dbh->disconnect(); #�f�[�^�x�[�X�Ɛؒf

print "</body></html>";              #HTML�o��
