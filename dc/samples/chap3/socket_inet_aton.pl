#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTP�w�b�_�o��
use Socket;                          # �\�P�b�g���W���[���ǂݍ���
$ip = inet_aton("localhost");        # localhost��IP�A�h���X���擾
print $ip."<br>";                    # ���ʁi���������j�F��
print "</body></html>";              # HTML�o��
exit;