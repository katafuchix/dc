#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$str1 = "abc\n";
$str2 = "def";
@array = ("abc\n","def\n","ghi");
print $str1.$str2; #���ʁFabc�i���s�jdef
print "\n";
chomp $str1;
print $str1.$str2; #str1�̖�����\n����菜���B���ʁFabcdef
print "\n";
print @array;      #���ʁFabc�i���s�jdef�i���s�jghi
print "\n";
chomp @array;      #�z��̂��ׂĂ̖����̉��s��������菜��
print @array;      #���ʁFabcdefghi
print "</PRE></BODY></HTML>";
