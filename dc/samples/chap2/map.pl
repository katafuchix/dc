#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
@strings = ("Volleyball","Soccer","American Football","Baseball");
@vals = map {length} @strings;#���ꂼ��̃o�C�g�����J�E���g
print join ",",@vals;         #���ʁF10,6,17,8
print "\n";
print join ",",@strings;      #���z��\���B����������Ă��Ȃ�
 #���ʁFVolleyball,Soccer,AmericanFootball,Baseball
print "\n";
@strings2 = map uc,@strings;  #���ꂼ��啶���ɕϊ�
print join ",",@strings2;     #���ʔz��\��
 #���ʁFVOLLEYBALL,SOCCER,AMERICAN FOOTBALL,BASEBALL
print "\n";
print join ",",@strings;      #���z��\���B����������Ă��Ȃ�
 #���ʁFVolleyball,Soccer,AmericanFootball,Baseball
print "\n";
map {$_ = reverse;} @strings; #��������t���ɁB�u���b�N��$_����������
print join ",",@strings;      #���̔z�񂪏��������
 #���ʁFllabyelloV,reccoS,llabtooFnaciremA,llabesaB
print "</PRE></BODY></HTML>";
