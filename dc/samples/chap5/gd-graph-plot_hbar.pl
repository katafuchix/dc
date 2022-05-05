#!/user/local/perl

print "Content-type: image/png\n\n"; #HTTPヘッダ出力

use GD::Graph::hbars;                # 横棒グラフモジュールの読込み
@data = ( ["1st","2nd","3rd","4th","5th"],   # y方向の値の設定
          [1,3,5,7,9],                       # x方向の値の設定(1本目)
          [2,4,6,8,10]);                     # x方向の値の設定(2本目)
$graph = new GD::Graph::hbars();     # 横棒グラフオブジェクトを作成
binmode STDOUT;                      # バイナリ出力に設定
print $graph->plot(\@data)-> png;    # PNG形式でグラフを描画


