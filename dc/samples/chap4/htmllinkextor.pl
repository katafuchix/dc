#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use HTML::LinkExtor;          #HTML::LinkExtor���W���[���ǂݍ���
sub callback{                 #�R�[���o�b�N���[�`����`
  my ($tagname , %attr) = @_; #�����̓^�O���Ƒ����̘A�z�z���2��
  if($tagname eq "a"){        #a�v�f�̏ꍇ��
    print $attr{"href"}; #href�������o�́B���ʁFhttp://localhost/sample2.html
  }
}
$extor = HTML::LinkExtor->new(\&callback,"http://localhost/");
#�R�[���o�b�N���[�`���ƃx�[�XURL���w��
$extor->parse_file('sample.html');#HTML�ǂݍ���
#�����N�����̓x��callback���Ăяo�����
print "</PRE></BODY></HTML>";
