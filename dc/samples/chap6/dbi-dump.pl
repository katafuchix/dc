#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTP�w�b�_�o��

use DBI;            # DBI���W���[���̌Ăяo��
# MySQL��sample�f�[�^�x�[�X�֐ڑ�
$dbh = DBI->connect("dbi:mysql:sample", "root", "admin");
# test_table�Ɋi�[����Ă���ID��3�ȉ��̃f�[�^���擾����SQL
$select_sql = "SELECT * FROM test_table WHERE id <= 3 ";
$sth = $dbh->prepare($select_sql) or print $dbh->errstr; #SQL������
$rv = $sth->execute() or print $sth->errstr; # SQL�����s
$result = $sth->dump_results(50,"<br>","|"); # �������ʂ��o�͂���
print "<br>���������F".$result;              # ����������\��
# ����
# '1'|'John'|'99-9999-9999'
# '2'|'Perl'|'99-9999-9991'
# '3'|'Mike'|'99-9999-9992' 3 rows 
#  ���������F3
$dbh = DBI->disconnect();

print "</body></html>";              #HTML�o��
