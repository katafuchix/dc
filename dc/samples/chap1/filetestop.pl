#!/usr/bin/perl
print "Content-type: text/html\n\n";
print "<HTML><BODY><PRE>";
print (-r "sample.txt");   #ファイル読み取りテスト。結果：1
print "\n";
print (-w "sample.txt");   #ファイル書き込みテスト。結果：1
print "\n";
print (-w "sampleRO.txt"); #読み取り専用ファイルの場合は失敗。結果：（なし）
print "\n";
print (-x "sample.bat");   #ファイル実行テスト。結果：1
print "\n";
print (-x "sample.exe");   #ファイル実行テスト。結果：1
print "\n";
print (-e "NotExist.txt"); #ファイル存在テスト。結果：（なし）
print "\n";
print (-z "size0.txt");    #ファイルサイズ0テスト。結果：1
print "\n";
print (-s "sample.txt");   #ファイルサイズ非0テスト。結果：14
print "\n";
print (-T "sample.txt");   #テキストファイルテスト。結果：1
print "\n";
print (-T "sample.exe");   #テキストファイルテスト。結果：（なし）
print "\n";
print (-B "sample.txt");   #バイナリファイルテスト。結果：（なし）
print "\n";
print (-B "sample.exe");   #バイナリファイルテスト。結果：1
print "\n";
print (-d "subfolder");    #ディレクトリテスト。結果：1
print "\n";
print (-b STDIN);          #ブロックファイルテスト。結果：（なし）
print "\n";
print (-c STDIN);          #キャラクタファイルテスト。結果：1
print "\n";
print (-t);                #STDINのttyオープンテスト。結果：1
print "\n";
print (-t STDOUT);         #STDOUTのttyオープンテスト。結果：1
print "\n";
print (-M "sample.txt");   #更新日時の古さ。結果：1.32185185185185
print "\n";
print (-A "sample.txt");   #アクセス日時の古さ。結果：0.00121527777777778
print "\n";
print (-C "sample.txt");   #inode変更日時の古さ。結果：1.32185185185185
print "\n";
print (-e _);              #アンダースコアで最後にアクセスしたファイルをテスト
                           #結果：1
print "</PRE></BODY></HTML>";
