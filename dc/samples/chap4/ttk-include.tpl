<html>
[%# -- �^�C�g����"include"�Ƃ��ĊO���e���v���[�g��ǂݍ���-- %]
[% INCLUDE templates/html/header title = 'include'%]
<!-- �v���O�������Ŋi�[�����ϐ��\�� -->
[% message %]<br>
<!-- �O���t�@�C���̓ǂݍ��� -->
[% INSERT insert.txt %]
<!-- �O���e���v���[�g�̓ǂݍ��� -->
[% INCLUDE include.txt + include.txt %]
<!-- �t�b�^�[��ǂݍ���-->
[% INCLUDE templates/html/footer %]