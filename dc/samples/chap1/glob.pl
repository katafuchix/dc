#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$var = "value";     #�X�J���ϐ�
@var = (1,2,3,4,5); #�z��ϐ�
%var = ("key1"=>"value1","key2"=>"value2"); #�A�z�z��ϐ�
*zzz = *var;        #�^�O���u�𑼂̌^�O���u�ɑ��
print $zzz;         #���ۂɂ�$var�̒l���o�́B���ʁFvalue
print "\n";
print @zzz;         #���ۂɂ�@var�̒l���o�́B���ʁF12345
print "\n";
print %zzz;         #���ۂɂ�%var�̒l���o�́B���ʁFkey2value2key1value1
print "\n";
*CONSTVALUE = \10;  #�X�J���̃��t�@�����X���^�O���u�ɑ���B�萔�l�쐬
*CONSTVALUE = [1,2,3,4,5]; #���X�g�̃��t�@�����X���^�O���u�ɑ���B�萔�l�쐬
print $CONSTVALUE;  #�X�J���l�o�́B���ʁF10
print "\n";
print @CONSTVALUE;  #���X�g�l�o�́B���ʁF12345
print "</PRE></BODY></HTML>";
