#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print rand 10; #�����I��srand���Ăяo�����B���ʗ�F6.048583984375
print "\n";
print rand 10; #����2�s�͎��s���邲�Ƃɒl���ς��B
print "\n";
srand 1;       #�V�[�h�𖾎��I�Ɏw��
print rand;    #���x���s���Ă���ɓ������ʂɂȂ�B���ʗ�F0.001251220703125
print "\n";
print rand;    #���ʗ�F0.563568115234375
srand (time ^ $$ ^ unpack "%L*", `ps axww | gzip`); 
               #��胉���_���ȃV�[�h�iUNIX�nOS�̏ꍇ�j
print "</PRE></BODY></HTML>";
