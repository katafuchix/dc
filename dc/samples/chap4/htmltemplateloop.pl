#!/usr/bin/perl
print "Content-type: text/html; charset=shift-jis\n\n";
use HTML::Template;
#�e���v���[�g�������`�B�e�[�u���̍s�����[�v�Ő�������e���v���[�g
#__FIRST__�p�����[�^���g�p���A���[�v�̐擪�̏ꍇ��th�^�O���o�͂���
$string = <<EOL
<html>
  <body>
    <table>
      <tmpl_loop name="person">
        <tmpl_if name="__FIRST__">
        <tr>
          <th>First name</th>
          <th>Last name</th>
        </tr>
        </tmpl_if>
        <tr>
          <td><tmpl_var name="fn"></td>
          <td><tmpl_var name="ln"></td>
        </tr>
      </tmpl_loop>
    </table>
  </body>
</html>
EOL
;
$template = HTML::Template->new_scalar_ref(\$string,
                                           loop_context_vars => 1
                                           );
#loop_context_vars�I�v�V������1�ɐݒ�
#�e���v���[�g�𕶎��񂩂�ǂݍ���
$template->param(person =>  [
  { fn => "Taroh" , ln => "Yamada"},
  { fn => "Tsuyoshi" , ln => "Doi"}
  ]); #person�p�����[�^��2�̘A�z�z���v�f�Ƃ��Ď��z���ݒ�
print $template->output(); #�e���v���[�g���o��
