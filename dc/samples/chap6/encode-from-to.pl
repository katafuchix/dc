print "Content-type: text/html;charset=euc-jp\n\n"; #HTTP�w�b�_�o��
#���̃X�N���v�g��Shift-JIS�ŕۑ�����Ă���
use Encode;
$string = "����ɂ���";
# Shift-JIS����EUC-JP�ɕ����R�[�h��ϊ�
Encode::from_to ( $string , 'shiftjis' , 'euc-jp' );
print $string; # �����R�[�h��ϊ������������\��
               # ���ʁF"����ɂ���"
$string = "����ɂ���";
#decode���\�b�h��encode���\�b�h�𗘗p���ĕ����R�[�h��ϊ�
$decoded_str = decode("shiftjis", $string);          #Shift-JIS����f�R�[�h
$encoded_str = encode("euc-jp", $decoded_str);       #EUC-JP�ɃG���R�[�h
print $encoded_str; # �����R�[�h��ϊ������������\��
                    # ���ʁ@�F����ɂ���
print "</body></html>";              #HTML�o��
