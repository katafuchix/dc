#!/user/local/perl

print "Content-type: image/png\n\n";  #HTTPヘッダ出力

use GD::Graph::linespoints;           # 折れ線／点グラフモジュールの読込み
@data = (                             # グラフのデータを設定
  ["1st","2nd","3rd","4th","5th"],
  [-3,1,3,5,15],
  [2,4,6,8,10],
);
$graph = new GD::Graph::linespoints();# 折れ線／点グラフオブジェクトを生成
$graph->set(                          # オプションを設定
  title => "sample title",            # タイトルを設定
  x_label => "X LABEL",               # x軸のラベルを設定
  y_label => "Y LABEL",               # y軸のラベルを設定
  # x軸／y軸ラベル値を2つ飛ばしで表示
  x_label_skip => 2, y_label_skip => 2,
  show_values => 1,                   # グラフ上にデータ値を表示
  valuesclr => "black",               # データ値の色を黒に設定
  # グラフの上下左右のマージンを設定
  t_margin => 10,  b_margin => 10,  l_margin => 10,  r_margin => 10,
  long_ticks => 1,                    # x軸y軸に目盛をいれる
  x_tick_number => 6,                 # x軸の目盛数を6に設定
  y_tick_number => 10,                # y軸の目盛数を10に設定
  dclrs => [ qw(red blue) ],          # 折れ線の色を赤、青に設定
  # 折れ線の種類をドット線、ドット-ダッシュ線に設定
  line_types => [3, 4], 
  # ｙ軸ラベル値の最大値と最小値を設定
  y_min_value => -5,  y_max_value => 20,
  axis_space  => 10,                  # 軸とラベル値の間隔を10に変更
  # 点の種類を塗りつぶされた菱形、塗りつぶされた四角に設定
  markers => [5,1],
  ); 
binmode STDOUT;                       # バイナリ出力に設定
print $graph->plot(\@data)-> png;     # PNG形式でグラフを描画


