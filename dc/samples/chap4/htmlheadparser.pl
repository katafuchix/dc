#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use HTML::HeadParser;
$parser = HTML::HeadParser->new();
$parser->parse(<<EOL
<html>
  <head>
    <title lang="ja-JP">
      Test Title
    </title>
    <isindex prompt="prompt test"/>
    <base href="/"/>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  </head>
  <body>
    Test Body
  </body>
</html>
EOL
);#��������
print $parser->header('title');#title�^�O���e�o�́B���ʁFTest Title
print "\n";
print $parser->header('content-base');#base�^�Ohref�����o�́B���ʁF/
print "\n";
print $parser->header('isindex');#isindex�^�Oprompt�����o�́B���ʁFprompt test
print "\n";
print $parser->header('content-type'); #���ʁFtext/html; charset=iso-8859-1
#http-equiv������"content-type"��meta�^�O��content�����o�́B
print "</PRE></BODY></HTML>";
