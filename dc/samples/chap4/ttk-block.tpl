[%# �u���b�N���`1 %]
[% BLOCK block_tpl1 %]
block1:[% message %]<br>
[% END %]
[%# �u���b�N���`2 %]
[% block_tpl2 = BLOCK  %]
block2:[% message %]<br>
[% END %]
<html>
[%# -- �^�C�g����"block"�Ƃ��ĊO���e���v���[�g��ǂݍ���-- %]
[% INCLUDE templates/html/header title = 'block'%]
<!-- �u���b�N�̓ǂݍ��� -->
[% INCLUDE block_tpl1 %]
[% block_tpl2 %]
<!-- �t�b�^�[��ǂݍ���-->
[% INCLUDE templates/html/footer %]
