#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
my $val = &sub1;  #���ʁF�X�J�� or void�R���e�L�X�g
print "\n";
&sub1;            #void�R���e�L�X�g�ŌĂяo���B���ʁF�X�J�� or void�R���e�L�X�g
print "\n";
my @vals = &sub1; #���ʁF���X�g�R���e�L�X�g
print "\n";
foreach (@vals){  #���X�g�R���e�L�X�g�ŋA���Ă������X�g���o��
  print;          #���ʁFlist context value
}
sub sub1{
  if(wantarray){  #�߂�l���^�Ȃ烊�X�g�A�U�Ȃ�X�J���i�������͖����j
    print "���X�g�R���e�L�X�g";
    return ("list","context","value");  #���X�g�R���e�L�X�g�ł̓��X�g��Ԃ�
  }else{
    print "�X�J�� or void�R���e�L�X�g";
    return "scalar or void";    #�������Ԃ�
  }
}
print "</PRE></BODY></HTML>";
