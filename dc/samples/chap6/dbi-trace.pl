#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTP�w�b�_�o��

use DBI;            # DBI���W���[���̌Ăяo��
#�g���[�X���x��1�Ńg���[�X����DBtrace.log�ɏo�͂���
DBI->trace(1, 'DBtrace.log');
# DBI���W���[�����g���Ă������̏��������s����
$dbh = DBI->connect("dbi:mysql:sample", "root", "admin");
#$dbh->trace(1);
$select_sql="SELECT * FROM test_table";
$sth = $dbh->prepare($select_sql) or  die $dbh->errstr; #SQL������
$sth->execute()  or  die $sth->errstr;                  #SQL�����s
#$sth->trace(1);
$dbh->disconnect();
# DBI���W���[�����g���������I��
open( TEXTFILE, "DBtrace.log" );       #�g���[�X�����o�͂���
@lines = <TEXTFILE>;
foreach ( @lines ) {
  print $_."<br>";
}
close( TEXTFILE );
print "</body></html>";              #HTML�o��
