#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print hex '0x64'; #��ʓI��16�i�\�L�B���ʁF100
print "\n";
print hex '014';  #�擪��0���t���Ă��Ă�16�i���ŕ]���B���ʁF20
print "\n";
print hex '64';   #�擪�ɉ����t���Ă��Ȃ��Ă�16�i�ŕ]���B���ʁF100
print "\n";
print oct '014';  #8�i���ŕ]���B���ʁF12
print "\n";
print oct '0x14'; #�擪��0x��t�����16�i���ŕ]���B���ʁF20
print "\n";
print oct '14';   #�擪�ɉ����t���Ȃ���8�i���ŕ]���B���ʁF12
print "</PRE></BODY></HTML>";
