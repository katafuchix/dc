#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDFƒo[ƒWƒ‡ƒ“1.5‚Å•¶‘¶¬
$page = $doc->new_page();
$shape = Shape(SStyle(strokecolor => Color("#ff0000")));#üF‚ðÔÝ’è
$shape->line(0,0,10,10); #ü•`‰æ
$shape->line(10,10,10,10,SStyle(strokecolor => Color(0,.9,.2))); #—ÎŒnF‚Åü•`‰æ
$shape->line(20,20,10,10,SStyle(strokecolor => Color(0))); #•‚Åü•`‰æ
$shape->show($page,20,50);
$doc->print("-");
