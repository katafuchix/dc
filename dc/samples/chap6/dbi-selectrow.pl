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
# test_table���疼�O�Ɠd�b�ԍ�����������SELECT��
$select_sql="SELECT name,tel FROM test_table";
#selectrow_array���\�b�h�Ō������A�������ʂ̐擪�f�[�^�s�̔z������o��
@arr = $dbh->selectrow_array($select_sql);
($name,$tel) = @arr;             #�z����X�J���[�ϐ��Ɋi�[
print $name."|".$tel."<br>"; #�������ʂ�\��
# ���ʁFJohn|99-9999-9999
print "<hr>";
# selectall_arrayref�őS�Ă̌������ʂ̔z��ւ̃��t�@�����X���擾
$all_ref = $dbh->selectall_arrayref($select_sql);
$num = @$all_ref;                                       #�f�[�^�������擾
for ($i = 0; $i < $num; $i++) {                         #�������ʂ�\��
  print $all_ref->[$i][0]."|". $all_ref->[$i][1]."<br>";
}
# ����
# John|99-9999-9999
# Perl|99-9999-9991
# Mike|99-9999-9992
print "<hr>";
#selectcol_arrayref���\�b�h�Ńf�[�^�̍ŏ��̃t�B�[���h
#���̏ꍇ��name�t�B�[���h�̃f�[�^���擾����
$arr_ref = $dbh->selectcol_arrayref($select_sql);
$num = @$arr_ref;                                       #�f�[�^�������擾
for ($i = 0; $i < $num; $i++) {                         #�������ʂ�\��
  print $arr_ref->[$i].",";
}
# ���ʁi���O�����擾���Ă���j�F John,Perl,Mike,
$dbh->disconnect(); #�f�[�^�x�[�X�Ɛؒf

print "</body></html>";              #HTML�o��
