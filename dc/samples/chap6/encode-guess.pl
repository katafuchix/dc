print "Content-type: text/html\n\n"; #HTTP�w�b�_�o��

use Encode;
use Encode::Guess;
$data = "hoge";
$enc = guess_encoding( $data );   # $data�̃G���R�[�h�`�����擾
print $enc->name;                 # �G���R�[�h�`����\�� ���ʁF ascii
print "</body></html>";              #HTML�o��
