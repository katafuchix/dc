#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTP�w�b�_�o��

use Socket;                                  # �\�P�b�g���W���[���ǂݍ���
# �|�[�g�ԍ�:80�A���[�J���z�X�g�ɐڑ�����SOCK_ADDR�\���̂��쐬
$paddr = pack_sockaddr_in(80,inet_aton("localhost")) ;
($port_num,$ip) = unpack_sockaddr_in($paddr); # SOCK_ADDR�\���̂��쐬�𕪉�
print $port_num.":".inet_ntoa($ip);           # ���ʁF80:127.0.0.1

print "</body></html>";              #HTML�o��
exit;