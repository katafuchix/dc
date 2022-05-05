#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTPヘッダ出力
use Socket;                          # ソケットモジュール読み込み
$ip = inet_aton("localhost");        # localhostのIPアドレスを取得
print $ip."<br>";                    # 結果（文字化け）：･･
print "</body></html>";              # HTML出力
exit;