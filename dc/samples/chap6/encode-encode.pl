print "Content-type: text/html;charset=utf-8\n\n"; #HTTP�w�b�_�o��
#���̃X�N���v�g��shift-jis�ŕۑ�����Ă���
use Encode;
$string = "����ɂ���";
$decoded_str = decode("shiftjis", $string);  #Shift-JIS����f�R�[�h
$encoded_str = encode("utf-8", $decoded_str);#utf-8�ɃG���R�[�h
print $encoded_str."<br>";                   #�G���R�[�h�����������\��
# ���ʁF����ɂ���
$encoded_utf8 = encode_utf8($decoded_str);   #utf-8�ɃG���R�[�h
print $encoded_utf8; #UTF-8�ɃG���R�[�h�����������\��
# ���ʁF����ɂ���

print "</body></html>";              #HTML�o��
