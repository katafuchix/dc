#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTP�w�b�_�o��
use Socket;                          # �\�P�b�g���W���[���ǂݍ���
$ip = inet_aton("localhost");        # localhost��IP�A�h���X���擾
print $ip."<br>";                    # ���ʁi���������j�F��
$ip_str = inet_ntoa($ip);            # IP �A�h���X��\���\�Ȍ`���ɕϊ�����
print $ip_str."<br>";                # ���ʁF127.0.0.1
print "</body></html>";              # HTML�o��
exit;