<html>
[% INCLUDE templates/html/header
      title = 'set'
%]<!-- �^�C�g����"set"�Ƃ��ăw�b�_�[��ǂݍ���-->
[%# -- �f�t�H���g�l��ݒ� -- %]
[% DEFAULT
    font_color   = 'color="#0000FF"'
    font_size    = 'size ="-1"'
%]
[%#-- �e���v���[�g���ŕϐ��i�[ --%]
[% SET
     val = "HelloWorld!!"
     qq_val = "message is $val"
     q_val  = 'message is $val'
     list_val = [ "Hello", "World", "!!"]
     list_num = [ 1..3 ]
     hash     = { hello => "Hello", world => "World" , ex => "!!"}
%]
<!-- �v���O�������Ŋi�[�����ϐ��\�� -->
<font [% font_size %] [%  font_color %]>[% message %]</font><br>
<!-- �e���v���[�g���Ŋi�[�����ϐ��\��-->
[% val %]<br>
[% q_val %]<br>
[% qq_val %]<br>
[% list_val.0 _ list_val.1 _ list_val.2 %]<br>
[% list_num.0 _" + "_ list_num.1 _" * "_ list_num.2 %]
 = [% list_num.0 + list_num.1 * list_num.2 %]<br>
[% hash.hello _ hash.world _ hash.ex %]<br>
<!-- �f�t�H���g���㏑�� -->
[% SET font_size = "size=+1" %]
<font [% font_size %] [%  font_color %]>[% message %]</font><br>
<!-- �t�b�^�[��ǂݍ���-->
[% INCLUDE templates/html/footer %]