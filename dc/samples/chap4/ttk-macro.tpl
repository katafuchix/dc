[%# INCLUDE���g�����}�N����` %]
[% MACRO footer INCLUDE templates/html/footer %]
[% MACRO header(title)  INCLUDE templates/html/header %]
[%# BLOCK���g�����}�N����` %]
[% MACRO bold(msg) BLOCK %]
<b>[% msg %] </b>
[% END %]
[%# GET���g�����}�N����` %]
[% MACRO puls(val1,val2) GET val1 + val2 %]
[%# IF���g�����}�N����` %]
[% MACRO value_check(val) IF value == 10%]
 value is 10
[% ELSE %]
 value is not 10
[% END %]
[%# �w�b�_�[�}�N���Ăяo�� %]
[% header('macro') %] 
[%# BOLD�}�N���Ăяo�� %]
[% bold(message) %]<br>
[%# �����Z�}�N���Ăяo�� %]
[% puls(10,2) %]<br>
[%# �l�`�F�b�N�}�N���Ăяo�� %]
[% value_check(10) %]
[%# �t�b�^�[�}�N���Ăяo�� %]
[% footer %]