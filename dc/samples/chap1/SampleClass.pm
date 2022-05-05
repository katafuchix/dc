package SampleClass;        #パッケージ名を宣言
sub new {                   #コンストラクタを宣言
  my $class = shift;        #クラス名を受け取る
  my $self = {};            #リファレンス生成
  return bless $self,$class;#所属クラスを宣言してリファレンスを返す
}
sub getString{              #クラスのメソッド定義
  return "SampleClass::getString!"; #文字列を返す
}
1;                          #最後に真を返す
