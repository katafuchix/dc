#!/usr/bin/perl
use CGI;                                   #CGI���W���[���Ăяo��
$query = new CGI();
$uploadCookie = $ENV{'HTTP_COOKIE'};       #�N�b�L�[������擾
($name,$value) = split(/=/,$uploadCookie); #�N�b�L�[�̖��O�ƒl���擾
if($name eq 'count'){                      #'count'�Ƃ������O�̃N�b�L�[�Ȃ�
  $value ++;                               #�l��1���₷
}else{                                     #����ȊO�Ȃ�i�ŏ��̖K��Ȃ�j
  $value = 1;                              #�l��1�ɏ�����
}
$cookie = $query->cookie(-name=>'count',   #�N�b�L�[���쐬���郁�\�b�h
                 -value=>$value);          #'count'�N�b�L�[���쐬
print $query->header(-cookie=>$cookie);    #�N�b�L�[���o�͂���
print $query->start_html();                #HTML�J�n
print $value;                              #�N�b�L�[�̒l���o�́B���ʁF1,2,3,4,5...
print $query->end_html();                  #HTML�I��
