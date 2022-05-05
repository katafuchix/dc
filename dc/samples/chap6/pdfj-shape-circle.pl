#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDFƒo[ƒWƒ‡ƒ“1.5‚Å•¶‘¶¬
$page = $doc->new_page();
$shape = Shape(SStyle(strokecolor => Color("#ff0000")));#üF‚ðÝ’è
$shape->circle(20,20,20); #‰~•`‰æ
$shape->show($page,20,100);
$doc->print("-");
