#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
$str1 = "abc\n";
$str2 = "def";
@array = ("abc\n","def\n","ghi");
chop $str1;
chop $str2;
print $str1.$str2; #str1,str2�̖�����������菜���B���ʁFabcde
print "\n";
print @array;      #���ʁFabc�i���s�jdef�i���s�jghi
chop @array;       #�z��̂��ׂĂ̖�����������菜��
print "\n";
print @array;      #���ʁFabcdefgh
print "</PRE></BODY></HTML>";
