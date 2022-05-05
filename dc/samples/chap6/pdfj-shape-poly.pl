#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5,200,200); #PDFƒo[ƒWƒ‡ƒ“1.5‚Å•¶‘¶¬
$page = $doc->new_page();
$shape = Shape(SStyle(fillcolor => Color("#ff0000")));#“h‚è‚Â‚Ô‚µF‚ðÝ’è
$shape->polygon([0,0,20,5,30,20,5,20,0,0],"s"); #‘½ŠpŒ`•`‰æB˜gü‚Ì‚Ý
$shape->show($page,20,100);
$doc->print("-");
