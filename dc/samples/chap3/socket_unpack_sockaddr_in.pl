#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTPヘッダ出力

use Socket;                                  # ソケットモジュール読み込み
# ポート番号:80、ローカルホストに接続するSOCK_ADDR構造体を作成
$paddr = pack_sockaddr_in(80,inet_aton("localhost")) ;
($port_num,$ip) = unpack_sockaddr_in($paddr); # SOCK_ADDR構造体を作成を分解
print $port_num.":".inet_ntoa($ip);           # 結果：80:127.0.0.1

print "</body></html>";              #HTML出力
exit;