#!/usr/bin/perl
use CGI;                #CGI���W���[���̃C���|�[�g
$cgi = new CGI;         #CGI�I�u�W�F�N�g�̐���
print $cgi->header(-type=>'text/html', #�w�b�_�o�� �R���e���g�^�C�v�w��
                   -status=>'200 OK',  #�X�e�[�^�X�R�[�h�w��
                   -expires=>'+20m',   #�L������20����
                   -charset=>'shift-jis', #�����R�[�h��Shift-JIS
                   -unknown => 'unknown header', #����`�̈���
                   -cookie=>'cookie-string'); #�N�b�L�[������w��
                        #�{���͌Œ�ł͂Ȃ����炩�̃��[���ŕ�����𐶐�����
