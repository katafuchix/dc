#!/user/local/perl

print "Content-type: text/html\n\n"; # HTTP�w�b�_�o��
use Socket;                          # �\�P�b�g���W���[���ǂݍ���
# �|�[�g�ԍ�:80�A���[�J���z�X�g�ɐڑ�����SOCK_ADDR�\���̂��쐬
$paddr = pack_sockaddr_in(80,inet_aton("localhost")) ;
connect SOCKET,$paddr;               # HTTP�T�[�o���N�����Ă���ΐڑ�����
print "</body></html>";              # HTML�o��
exit;