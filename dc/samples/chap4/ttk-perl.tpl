<html>
[%# �^�C�g����"perl"�Ƃ��ĊO���e���v���[�g��ǂݍ��� %]
[% INCLUDE templates/html/header title = 'perl'%]
[%# PERL�^�O��Perl�R�[�h���L�q����%]
[% PERL %]
my $msg = $stash->get("message"); #message���擾
$stash->set("value"=> 10);        #value��10�ɃZ�b�g
print "perl:".$msg;
[% END %]<br>
[% value %]<br>
[%# RAWPERL�^�O��Perl�R�[�h���L�q����%]
[% RAWPERL %]
$output .= 'raw perl:Hello World !!';
[% END %]<br>
<!-- �t�b�^�[��ǂݍ���-->
[% INCLUDE templates/html/footer %]
