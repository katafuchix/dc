#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
format =
#�񍐏��t�H�[�}�b�g�w��
Name : @<<<<<<<<<<<<< @<<<<<<<<<<<
$firstName,$lastName
#�ϐ��s�B2�̕ϐ����w��
Summary : @<<<<<<<<<<<<<<<<<<<<<<<<<...
$summary
.

#�t�H�[�}�b�g�錾�B�ǂ̕ϐ����ǂ̃t�B�[���h�ɓ��邩���w�肷��
#�����ł�Name��Summary��2�̏o�͍s��3�̕ϐ����w�肵�Ă���
$firstName = "Tsuyoshi"; #Name�s�ɏo��
$lastName = "Doi";       #Name�s�ɏo��
$summary = "�n�������|�[�g�B���낢��Ɠ��e������܂���"; #Summary�s�ɏo��
write; #�t�H�[�}�b�g�ɏ]���ďo�͂���BSummary�s�͒����̂ōŌ��...���\�������
print "</PRE></BODY></HTML>";
