#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTP�w�b�_�o��

use DBI;            # DBI���W���[���̌Ăяo��
# MySQL��sample�f�[�^�x�[�X�֐ڑ�
$dbh = DBI->connect("dbi:mysql:sample", "root", "admin");
# �f�[�^�x�[�X�E�n���h������ selectrorw_array ���Ăяo��
$ref = $dbh->selectrow_array( "SELECT COUNT(*) FROM sample_table ");
print "sample_table�Ɋi�[����Ă���񐔁F".$ref;
# ���ʁFsample_table�Ɋi�[����Ă���񐔁F1
$dbh->disconnect(); #�f�[�^�x�[�X�Ɛؒf

print "</body></html>";              #HTML�o��
exit;