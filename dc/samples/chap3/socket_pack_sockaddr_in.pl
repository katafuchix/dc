#!/user/local/perl

print "Content-type: text/html\n\n"; # HTTPヘッダ出力
use Socket;                          # ソケットモジュール読み込み
# ポート番号:80、ローカルホストに接続するSOCK_ADDR構造体を作成
$paddr = pack_sockaddr_in(80,inet_aton("localhost")) ;
connect SOCKET,$paddr;               # HTTPサーバが起動していれば接続成功
print "</body></html>";              # HTML出力
exit;