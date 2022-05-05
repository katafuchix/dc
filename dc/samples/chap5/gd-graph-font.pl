#!/user/local/perl

print "Content-type: image/png\n\n";  #HTTPヘッダ出力

use GD;
use GD::Graph::lines;                     # 折れ線グラフモジュールの読込み
@data = (                                 # グラフのデータを設定
  ["1st","2nd","3rd","4th","5th"],
  [1,3,5,7,9],
);
$graph = new GD::Graph::lines();          # 折れ線グラフオブジェクトを作成
$graph->set(                              # オプションを設定
  title => "sample title",                # タイトルを設定
  x_label => "X LABEL",                   # x軸のラベルを設定
  y_label => "Y LABEL",                   # y軸のラベルを設定
); 
$graph->set_title_font(gdGiantFont);      # タイトルのフォントを指定
$graph->set_x_label_font(gdSmallFont);    # x軸ラベルのフォントを指定
$graph->set_y_label_font(gdTinyFont);     # y軸ラベルのフォントを指定
binmode STDOUT;                           # バイナリ出力に設定
print $graph->plot(\@data)-> png;         # PNG形式でグラフを描画

