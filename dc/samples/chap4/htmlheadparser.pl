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
);#•¶Žš—ñ‰ðÍ
print $parser->header('title');#titleƒ^ƒO“à—eo—ÍBŒ‹‰ÊFTest Title
print "\n";
print $parser->header('content-base');#baseƒ^ƒOhref‘®«o—ÍBŒ‹‰ÊF/
print "\n";
print $parser->header('isindex');#isindexƒ^ƒOprompt‘®«o—ÍBŒ‹‰ÊFprompt test
print "\n";
print $parser->header('content-type'); #Œ‹‰ÊFtext/html; charset=iso-8859-1
#http-equiv‘®«‚ª"content-type"‚Ìmetaƒ^ƒO‚Ìcontent‘®«o—ÍB
print "</PRE></BODY></HTML>";
