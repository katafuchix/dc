#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
opendir INDIR,"c:\\";        #"C:\"‚ğŠJ‚­
while($str = readdir INDIR){ #ˆê‚Â‚¸‚Â“Ç‚İ‚Ş
  print $str."\n";           #Œ‹‰ÊFProgram Files Perl temp WINDOWS...
}
closedir INDIR;
print "</PRE></BODY></HTML>";
