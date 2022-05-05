#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTP�w�b�_�o��

use DBI;            # DBI���W���[���̌Ăяo��
# MySQL��sample�f�[�^�x�[�X�֐ڑ�
$dbh = DBI->connect("dbi:mysql:sample", "root", "admin");
$select_sql1 = "SELECT * FROM test_table WHERE id = %s ";
$select_sql2 = "SELECT * FROM test_table WHERE name = %s ";
@number_list = (1,"Don't",'te"st',2);
@ret_bool = DBI::looks_like_number(@number_list);  #���l�`�F�b�N
$counter = 0;
foreach(@ret_bool){
  if($_){#���l�ł����id�t�B�[���h�ɑ΂��ď���������
    $tmp_select = sprintf($select_sql1,$dbh->quote(@number_list[$counter]));
    print $tmp_select."<br>";
  }
  else{  #����ȊO�̏ꍇ��name�t�B�[���h�ɑ΂��ď���������
    $tmp_select = sprintf($select_sql2,$dbh->quote(@number_list[$counter]));
    print $tmp_select."<br>";
  }
  $sth = $dbh->prepare($tmp_select) or print $dbh->errstr; #SQL������
  $rv = $sth->execute() or print $sth->errstr; # SQL�����s
  while( my $ref = $sth->fetch ){            # �������ʂ��擾
    $ret_str_list = DBI::neat_list($ref,);
    print "�o�͌��ʁF".$ret_str_list."<br>"; # �������ʂ�\��
  }
  $counter ++;
}
$dbh = DBI->disconnect();
#����
#SELECT * FROM test_table WHERE id = '1' 
#�o�͌��ʁF'1', 'John', '99-9999-9999'
#SELECT * FROM test_table WHERE name = 'Don\'t' 
#SELECT * FROM test_table WHERE name = 'te\"st' 
#SELECT * FROM test_table WHERE id = '2' 
#�o�͌��ʁF'2', 'Perl', '99-9999-9991'

print "</body></html>";              #HTML�o��

