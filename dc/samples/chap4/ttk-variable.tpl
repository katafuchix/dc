<html>
[% INCLUDE templates/html/header
      title = 'valiable'
%]<!-- �^�C�g����"process"�Ƃ��ăw�b�_�[��ǂݍ���-->
<!-- �X�J���[�ϐ��\��-->
val:[% GET message %]<br>
<!-- ���l�v�Z-->
num:[% GET num_1%]+[% GET num_2%]=[% GET num_1 + num_2 %]<br>
<!-- �z��\��-->
array:[% GET array_value.0 %][% GET array_value.1 %]
[% GET array_value.2 %]<br>
<!-- �n�b�V���\��-->
hash:[% GET hash_value.hello %]
[% GET hash_value.world %][% GET hash_value.ex %]<br>
<!-- �֐��\��-->
sub:[% GET sub_value('World!!') %]<br>
<!-- �I�u�W�F�N�g�\��-->
obj:[% GET obj_value.param('message') %]
<!-- �t�b�^�[��ǂݍ���-->
[% INCLUDE templates/html/footer %]