<html>
[% INCLUDE templates/html/header
      title = 'process'
%]<!-- �^�C�g����"process"�Ƃ��ăw�b�_�[��ǂݍ���-->
<!-- �X�J���[�ϐ��\��-->
val:[% message %]<br>
<!-- �z��\��-->
array:[% array_value.0 %][% array_value.1 %][% array_value.2 %]<br>
<!-- �n�b�V���\��-->
hash:[% hash_value.hello %][% hash_value.world %][% hash_value.ex %]
<!-- �t�b�^�[��ǂݍ���-->
[% INCLUDE templates/html/footer %]