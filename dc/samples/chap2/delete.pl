#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
%days = ("Sunday" => "��","Monday" => "��","Tuesday"=>"��");
my $val = delete $days{"Monday"}; #�L�["Monday"���폜
print $val;                       #�폜���ꂽ�l�B���ʁF��
print "\n";
@array = (0..4);
print delete $array[2];           #�z��̃C���f�b�N�X��2�̗v�f���폜�B����2
print "\n";
foreach(@array){
  print;                          #�z����e�o�́B����0134
}
print "</PRE></BODY></HTML>";
