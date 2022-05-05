#!/usr/bin/perl
print "Content-type: application/pdf\n\n";
use PDFJ;
$doc = new PDFJ::Doc(1.5); #PDFバージョン1.5で文書生成
$doc->new_page(400,300,1);   #サイズ400x300ポイントでページ生成
$doc->new_page(400,300,2,"2,Wipe,90"); #ページ生成。下から上に2秒かけてWipe処理
$doc->new_page(400,300,2,"2,Glitter,315"); #ページ生成
                                           #左上から右下に2秒かけてGlitter処理
$doc->insert_page(0,100,100);          #先頭にページ挿入
$doc->print("-");
