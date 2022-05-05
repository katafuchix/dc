#!/user/local/perl

print "Content-type: image/png\n\n";  #HTTPヘッダ出力

use GD::Graph::lines;                     # 折れ線グラフモジュールの読込み
@data = (                                 # グラフのデータを設定
  ["1st","2nd","3rd","4th","5th"],
  [1,3,5,7,9],                            # legend_1用データを設定
  [2,4,6,8,10],                           # legend_2用データを設定
);
$graph = new GD::Graph::lines();          # 折れ線グラフオブジェクトを作成
$graph->set_legend(                       #凡例の設定
                   "legend_1",
                   "legend_2",
);
$graph->set(                              #凡例のオプションを設定
            "legend_placement" => "RT",   #右上に配置
            "legend_spacing" => 5,        #グラフと凡例の間隔を指定
            "legend_marker_width" => 24,  #マーカーの幅を指定
            "legend_marker_height" => 16, #マーカーの高さを指定
);
binmode STDOUT;                          # バイナリ出力に設定
print $graph->plot(\@data)-> png;        # PNG形式でグラフを描画

