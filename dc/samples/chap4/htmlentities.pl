#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use HTML::Entities;             #HTML::Entities���W���[���ǂݍ���
$enc = encode_entities("<Hello>������"); #�������HTML�G���e�B�e�B�ɃG���R�[�h
print $enc;#�G���R�[�h���ʏo�́B<>�Ɠ��{��̓G���R�[�h
#���ʁF&lt;Hello&gt;&#130;&nbsp;&#130;&cent;&#130;&curren;
$dec = decode_entities($enc);            #�������HTML�G���e�B�e�B���f�R�[�h
print "\n";
print $dec;                     #�f�R�[�h���ʏo�́B���ʁF<Hello>������
print "</PRE></BODY></HTML>";
