<html>
[%# �^�C�g����"if/elseif/else/unless"�Ƃ��ĊO���e���v���[�g��ǂݍ��� %]
[% INCLUDE templates/html/header title = 'if/elseif/else/unless'%]
[%#  ���䕶 %]
[% IF val > 5  %]                [%# �������͐^ %]
"value is greater than 5";       [%# ��������� %]
[% END %]<br>
[% IF val > 10  %]               [%# �������͋U %]
"value is greater than 10";      [%# ��������Ȃ� %]
[% ELSIF val > 0  %]             [%# �������͐^ %]
"value is greater than 0";       [%# ��������� %]
[% END %]<br>
[% IF val > 100 %]               [%# �������͋U %]
"value is greater than 100";     [%# ��������Ȃ� %]
[% ELSE %]                       [%# else������������� %]
 "value is not greater than 100";[%# ��������� %]
[% END %]<br>
[% UNLESS val > 100 %]           [%# �������͋U %]
"value is greater than 100";     [%# ��������� %]
[% END %]
<!-- �t�b�^�[��ǂݍ���-->
[% INCLUDE templates/html/footer %]
