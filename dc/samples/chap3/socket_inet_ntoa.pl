#!/user/local/perl

print "Content-type: text/html\n\n"; #HTTPヘッダ出力
use Socket;                          # ソケットモジュール読み込み
$ip = inet_aton("localhost");        # localhostのIPアドレスを取得
print $ip."<br>";                    # 結果（文字化け）：･･
$ip_str = inet_ntoa($ip);            # IP アドレスを表示可能な形式に変換する
print $ip_str."<br>";                # 結果：127.0.0.1
print "</body></html>";              # HTML出力
exit;