<html>
[%# �^�C�g����"switch"�Ƃ��ĊO���e���v���[�g��ǂݍ��� %]
[% INCLUDE templates/html/header title = 'switch'%]
[%#  FOREACH�� %]
[% FOREACH val IN list_value %]
[%#  ���䕶 %]
[% SWITCH val %]
[% CASE 1 %] value is  1
[% CASE [2,3] %] value is 2 or 3
[% CASE 4 %]  value is 4
[% CASE DEFAULT %] value is not 10
[% END %]
<br>
[% END %]
<!-- �t�b�^�[��ǂݍ���-->
[% INCLUDE templates/html/footer %]
