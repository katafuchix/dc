#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
use XML::DOM;                                #XML::DOM���W���[��
$xml = new XML::DOM::Parser();               #XML::DOM::Parser�C���X�^���X����
$document = $xml->parse(<<EOL
<sample><?targetProcessor data1 data2?></sample>
EOL
); #XML��������
$pi = $document->getDocumentElement()->getFirstChild(); #�������߃m�[�h�擾
print $pi->getTarget(); #�����Ώۏo�́B���ʁFtargetProcessor
print "\n";
print $pi->getData();   #�������e�o�́B���ʁFdata1 data2
print "\n";
$pi->setData("data");   #�������e�ݒ�
print $pi->toString();  #XML�o�́B���ʁF<?targetProcessor data?>
print "</PRE></BODY></HTML>";
