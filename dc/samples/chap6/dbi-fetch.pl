#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTP�w�b�_�o��

# ���L�̂悤�ȍ\���̃e�[�u���itest_table�j����f�[�^���擾
#+------+-------+--------------+
#| id   | name  | tel          |
#+------+-------+--------------+
#|    1 | John  | 99-9999-9999 |
#|    2 | Perl  | 99-9999-9991 |
#|    3 | Mike  | 99-9999-9992 |
#+------+-------+--------------+
use DBI;            # DBI���W���[���̌Ăяo��
# MySQL��sample�f�[�^�x�[�X�֐ڑ�
$dbh = DBI->connect("dbi:mysql:sample", "root", "admin");
# test_table����S�Ẵf�[�^����������SELECT��
$select_sql="SELECT * FROM test_table";
$sth = $dbh->prepare($select_sql) or  die $dbh->errstr; #SQL������
$sth->execute()  or  die $sth->errstr;                  #SQL�����s
$row_count = $sth->rows();                              #�����������擾
print "���������F".$row_count."<br>";                   #���ʗ� ���������F8
#fetch���\�b�h�Ńf�[�^���擾����
#�����Ƀf�[�^�s�̃��t�@�����X�����o��
while( my $ref = $sth->fetch ){        
  my ($id, $name,$tel) = @$ref;        #���t�@�����X���X�J���[�ϐ��Ɋi�[
  print $id."|".$name."|".$tel."<br>"; #�������ʂ�\��
}
# ���ʁF
# 1|John|99-9999-9999
# 2|Perl|99-9999-9991
# 3|Mike|99-9999-9992
print "<hr>";
# test_table���疼�O�Ɠd�b�ԍ��f�[�^����������SELECT��
$select_sql="SELECT name,tel FROM test_table";
$sth = $dbh->prepare($select_sql) or  die $dbh->errstr; #SQL������
$sth->execute()  or  die $sth->errstr;                  #SQL�����s
#fetchrow_array���\�b�h�Ńf�[�^���擾����
#�����Ƀf�[�^�s�̔z������o��
while( my @arr = $sth->fetchrow_array ){ 
  my ($name,$tel) = @arr;         #�z����X�J���[�ϐ��Ɋi�[
  print $name."|".$tel."<br>"; #�������ʂ�\��
}
# ����
# John|99-9999-9999|
# Perl|99-9999-9991|
# Mike|99-9999-9992|
print "<hr>";
# test_table����id�Ɩ��O�̃f�[�^����������SELECT��
$select_sql="SELECT id,name FROM test_table";
$sth = $dbh->prepare($select_sql) or  die $dbh->errstr; #SQL������
$sth->execute()  or  die $sth->errstr;                  #SQL�����s
#fetchrow_hashref���\�b�h�Ńf�[�^���擾����
#�����Ƀf�[�^�s�̃n�b�V�������o��
while( my $href = $sth->fetchrow_hashref() ){
  print $href->{id}."|".$href->{name}."<br>"; #�������ʂ�\��
}
# ����
# 1|John|
# 2|Perl|
# 3|Mike|
print "<hr>";
# test_table����S�Ẵf�[�^����������SELECT��
$select_sql="SELECT * FROM test_table";
$sth = $dbh->prepare($select_sql) or  die $dbh->errstr; #SQL������
$sth->execute()  or  die $sth->errstr;                  #SQL�����s
$all_ref = $sth->fetchall_arrayref([1,2]);       #2�Ԗڂ�3�Ԗڂ̃f�[�^�̂ݑI��
$num = @$all_ref;                                       #�f�[�^�������擾
for ($i = 0; $i < $num; $i++) {                         #�������ʂ�\��
  print $all_ref->[$i][0]."|". $all_ref->[$i][1]."<br>";
}
# ����
# John|99-9999-9999|
# Perl|99-9999-9991|
# Mike|99-9999-9992|
$dbh->disconnect(); #�f�[�^�x�[�X�Ɛؒf

print "</body></html>";              #HTML�o��
