#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$_ = "abracadabra";  #�����Ώە������$_�ɑ��
if(/ab/){            #ab�Ńp�^�[���}�b�`
  print '"ab" match';#���ʁF"ab" match
}
print "\n";
while(m@a@g){        #m���Z�q���g���A@����؂蕶���Ƃ��Ag�C���q�ŌJ��Ԃ�
  print pos;         #a�̃}�b�`�ʒu���o�́B1 4 6 8 11
}
print "\n";
while(m[AB]ig){      #[]����؂蕶���Ƃ��Ai�C���q�ő啶������������
  print pos;         #AB�̃}�b�`�ʒu���o�́B2 9
}
print "\n";
$string = "abcdefg";  #�����Ώە�����
if($string =~ /cde/g){#=~���Z�q�Ńp�^�[���}�b�`�Ώۂ�$string�Ƃ���
  print pos $string;  #cde�̃}�b�`�ʒu���o�́B5
}
print "\n";
if($string !~ /zzz/){ #!~���Z�q�Ńp�^�[���}�b�`�Ώۂ�$string�Ƃ���
  print "zzz not found"; #���ʁFzzz not found
}
print "</PRE></BODY></HTML>";
