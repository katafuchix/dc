[%# �u���b�N���` %]
[% BLOCK bold %]<b>[% content %]</b>[% END %]
[% BLOCK italic %]<i>[% content %]</i>[% END %]
<html>
[%# -- �^�C�g����"wrapper"�Ƃ��ĊO���e���v���[�g��ǂݍ���-- %]
[% INCLUDE templates/html/header title = 'wrapper'%]
<!-- �u���b�N�����b�p�[ -->
[% WRAPPER bold+italic %]Hello World !![% END %]
<!-- �t�b�^�[��ǂݍ���-->
[% INCLUDE templates/html/footer %]
