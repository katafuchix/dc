#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use MIME::QuotedPrint;             #MIME::QuotedPrint���W���[���ǂݍ���
$enc = encode_qp("Hello\aWorld!"); #�������QuotedPrint�G���R�[�h
print $enc;#�G���R�[�h���ʏo�́B\a��"=07"�ɃG���R�[�h�B���ʁFHello=07World!=
$dec = decode_qp($enc);            #�������QuotedPrint�f�R�[�h
print "\n";
print $dec;                        #�f�R�[�h���ʏo�́B���ʁFHello World!
no MIME::QuotedPrint;                      #MIME::QuotedPrint���W���[��������
use MIME::QuotedPrint ();                  #���\�b�h���C���|�[�g���Ȃ��ꍇ
$enc = MIME::QuotedPrint::encode_qp("Hello World!"); #�p�b�P�[�W���t���ŌĂяo��
$dec = MIME::QuotedPrint::decode_qp($enc);           #�p�b�P�[�W���t���ŌĂяo��
print "\n";
print $dec;          #�f�R�[�h���ʏo�́B���ʁFHello World!
print "</PRE></BODY></HTML>";
