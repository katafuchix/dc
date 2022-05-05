#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTP�w�b�_�o��
# ���L�̂悤�ȍ\���̃e�[�u���itest_table�j����f�[�^���擾
#+------+-------+--------------+
#| id | name | tel |
#+----+------+--------------+
#| 1  | John | 99-9999-9999 |
#| 2  | Perl | 99-9999-9991 |
#| 3  | Mike | 99-9999-9992 |
#+----+------+--------------+
use DBI;            # DBI���W���[���̌Ăяo��
# MySQL��sample�f�[�^�x�[�X�֐ڑ�
$dbh = DBI->connect("dbi:mysql:sample", "root", "admin");
# test_table����id=2�̃f�[�^����������SELECT��
$select_sql1 = "SELECT * FROM test_table WHERE id = 2 ";
$sth = $dbh->prepare($select_sql1) or  die $dbh->errstr; #SQL������
$sth->execute()  or  die $sth->errstr;                  #SQL�����s
# bind_col�̎g�p���@
$sth->bind_col(1, \$id);                   # �t�B�[���h1��id�Ɋi�[
$sth->bind_col(2, \$name);                 # �t�B�[���h2��name�Ɋi�[
$sth->bind_col(3, \$tel);                  # �t�B�[���h3��tel�Ɋi�[
while ( $sth->fetch ){
  print $id."|".$name."|".$tel."<br>"; #�������ʂ�\��
}                                      # ���ʁF2|Perl|99-9999-9991
# �f�[�^��ǉ�����
$insert_statement = "INSERT INTO `test_table`
                      VALUES (5, 'Bob', '99-9999-9995')";
$sth = $dbh->prepare($insert_statement) or  die $dbh->errstr; #SQL������
$sth->execute()  or  die $sth->errstr;                        #SQL�����s
$row_count = $sth->rows();              #�e�����������s�����擾
print "�ǉ����ꂽ�s�F".$row_count;      #���ʗ� �ǉ����ꂽ�s�F1
# test_table����ǉ�����id=5�̃f�[�^����������SELECT��
$select_sql2 = "SELECT * FROM test_table WHERE id = 5 ";
$sth = $dbh->prepare($select_sql2) or  die $dbh->errstr;#SQL������
$sth->execute()  or  die $sth->errstr;                  #SQL�����s
#�t�B�[���h1��id2�Ƀt�B�[���h2��name2�Ƀt�B�[���h3��tel2�Ɋi�[
$sth->bind_columns(\($id2, $name2,$tel2));
while ($sth->fetch) {
  print $id2."|".$name2."|".$tel2."<br>"; #�������ʂ�\��
}                                         # ���ʁF5|Bob|99-9999-9995
$dbh->disconnect(); #�f�[�^�x�[�X�Ɛؒf

print "</body></html>";              #HTML�o��
exit;