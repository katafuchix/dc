#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$val = 0;        #goto�֐����g�p�������[�v�B��������Ȃ�
BEFOREIF:        #�ړ��惉�x��
print $val++;    #�l�o�́B���ʁF0123456789
if($val < 10){   #�l��10�����̏ꍇ��
  goto BEFOREIF; #BEFOREIF���x���Ɉړ�
}
while(1){        #���G�ȃ��[�v
    goto AFTERLOOP; #goto�֐��ɂ�郋�[�v�E�o
                    #���̌���ł͋��e�����ꍇ�����邪�APerl�ł�last�����g�p
}
AFTERLOOP:       #���[�v�E�o��̃��x��
print "</PRE></BODY></HTML>";
