<html>
[%# �^�C�g����"loop"�Ƃ��ĊO���e���v���[�g��ǂݍ��� %]
[% INCLUDE templates/html/header title = 'loop'%]
<!-- WHILE�^�O -->
[% i = 0 %]
[% WHILE (i < 10 ) %] [%# 10�񏈗����J��Ԃ�%]
[% i = i + 1 %]
[% i %],
[% END %]
<br>
<!-- FOREACH�^�O -->
[% FOREACH j = list_value %] [%# �z��̗v�f��������o�� =���g�� %]
[% j %],
[% END %]
<br>
[% FOREACH j IN list_data %] [%# �z��̗v�f��������o�� IN���g�� %]
[% j %],
[% END %]
<br>
<!-- LAST�^�O -->
[% i = 0 %]
[% WHILE (i < 10 ) %] [%# 10�񏈗����J��Ԃ�%]
[% i = i + 1 %]
[% LAST IF (i == 5) %]  [%# i��5�̏ꍇ�A���[�v�������I������%]
[% i %],
[% END %]
<br>
<!-- NEXT�^�O -->
[% FOREACH j IN list_value %] [%# �z��̗v�f��������o��%]
[% NEXT IF (j == 5) %]  [%# i��5�̏ꍇ�A���[�v�����𒆒f���āA���̏����Ɉڂ�%]
[% j %],
[% END %]
<!-- �t�b�^�[��ǂݍ���-->
[% INCLUDE templates/html/footer %]
