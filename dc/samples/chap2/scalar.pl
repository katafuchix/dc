#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
%days = ("Sunday" => "��","Monday" => "��","Tuesday"=>"��");
print values %days;        #���X�g�R���e�L�X�g�Ƃ��ĕ]���B���ʁF�Γ���
print "\n";
print scalar values %days; #�X�J���R���e�L�X�g�Ƃ��ĕ]���B���ʁF3
print "</PRE></BODY></HTML>";
