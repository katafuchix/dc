#!/usr/bin/perl
print "Content-type: text/html ; charset=shift-jis\n\n";
print "<HTML><BODY><PRE>";
$string = <<'EOC'; #����EOC�܂�1�̕�����萔�Ƃ݂Ȃ��A�V���O���N�H�[�g�ň͂�
abcdefg
#�R�����g�̂悤�Ɍ����邪������萔�̈ꕔ
print $value;
���print���������̕�����萔
EOC
#'abcd�`�����̕�����萔'�܂ł��V���O���N�H�[�g�ň͂܂ꂽ������萔�Ƃ݂Ȃ����
print $string;  #���ʁFabcdefg�i���s�j#�R�����g�̂悤��...�i���s�j...
print "</PRE></BODY></HTML>";
