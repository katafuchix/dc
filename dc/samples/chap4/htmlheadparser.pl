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
);#文字列解析
print $parser->header('title');#titleタグ内容出力。結果：Test Title
print "\n";
print $parser->header('content-base');#baseタグhref属性出力。結果：/
print "\n";
print $parser->header('isindex');#isindexタグprompt属性出力。結果：prompt test
print "\n";
print $parser->header('content-type'); #結果：text/html; charset=iso-8859-1
#http-equiv属性が"content-type"のmetaタグのcontent属性出力。
print "</PRE></BODY></HTML>";
