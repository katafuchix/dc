#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,400,300); #PDF�o�[�W����1.5�A400x300�|�C���g�ŕ�������
$doc->new_page();                    #�y�[�W����
$doc->print("-");
