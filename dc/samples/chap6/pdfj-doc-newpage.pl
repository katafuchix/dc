#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5); #PDF�o�[�W����1.5�ŕ�������
$doc->new_page(400,300,1);   #�T�C�Y400x300�|�C���g�Ńy�[�W����
$doc->new_page(400,300,2,"2,Wipe,90"); #�y�[�W�����B��������2�b������Wipe����
$doc->new_page(400,300,2,"2,Glitter,315"); #�y�[�W����
                                           #���ォ��E����2�b������Glitter����
$doc->insert_page(0,100,100);          #�擪�Ƀy�[�W�}��
$doc->print("-");
