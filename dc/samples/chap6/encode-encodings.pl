print "Content-type: text/html\n\n"; #HTTP�w�b�_�o��

use Encode;
@list = Encode->encodings();
@list_jp = Encode->encodings("Encode::JP");
print @list;     # Encode�Œ�`����Ă��镶���R�[�h���̈ꗗ��\��
                 # ���ʁ@�F�@""
print @list_jp;  # Encode::JP�Œ�`����Ă��镶���R�[�h���̈ꗗ��\��
                 # ���ʁ@�F�@""
                 
print "</body></html>";              #HTML�o��