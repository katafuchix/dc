#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use MIME::Base64;                     #MIME::Base64���W���[���ǂݍ���
$enc = encode_base64("Hello World!"); #�������Base64�G���R�[�h
print $enc;          #�G���R�[�h���ʏo�́B���ʁFSGVsbG8gV29ybGQh
$dec = decode_base64($enc);           #�������Base64�f�R�[�h
print $dec;          #�f�R�[�h���ʏo�́B���ʁFHello World!
print "\n";
no MIME::Base64;                      #MIME::Base64���W���[��������
use MIME::Base64 ();                  #���\�b�h���C���|�[�g���Ȃ��ꍇ
$enc = MIME::Base64::encode_base64("Hello World!"); #�p�b�P�[�W���t���ŌĂяo��
$dec = MIME::Base64::decode_base64($enc);           #�p�b�P�[�W���t���ŌĂяo��
print $dec;          #�f�R�[�h���ʏo�́B���ʁFHello World!
print "</PRE></BODY></HTML>";
