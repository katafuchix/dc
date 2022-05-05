<?php

class Dc_ImageGeneratorManager extends Ethna_AppManager
{
	/* @var string image file */
	var $image_file;
	/* @var string 出力文字列 */
	var $moji;
	/* @var int x */
	var $x;
	/* @var int y */
	var $y;
	/* @var string */
	var $flg;
	/* @var font string */
	var $font;
	/* @var color string */
	var $color;
	/* @var size int */
	var $size;
	
	function setImageFile($image_file){
		$this->image_file = $image_file;
	}
	
	function setMoji($moji)
	{
		$this->moji  = $moji;
	}

	function setX($x)
	{
		$this->x  = $x;
	}
	
	function setY($y)
	{
		$this->y  = $y;
	}

	function setFlg($flg)
	{
		$this->flg  = $flg;
	}
	
	function setFont($font)
	{
		$this->font  = $font;
	}
	function setColor($color)
	{
		$this->color  = $color;
	}
	function setSize($size)
	{
		$this->size  = $size;
	}
	function out()
	{

		$data = pathinfo($this->image_file);
		//print_r($data);
					//$data['dirname']; //ディレクトリ名
					//$data['basename']; //ファイル名
					//$data['extension']; //拡張子
					
		header("content-type: image/".$data['extension']);
		/*
		$ctl = $this->backend->getController();
		$cmd = $this->config->get('perl_path') . " " . $ctl->getDirectory('bin') . "/avatar_generator.pl ";
		$files = implode(',', $files);
		$cmd = "{$cmd} {$this->width} {$this->height} {$this->base} {$this->base_x} {$this->base_y} {$this->base_w} {$this->base_h} {$files}";
print $cmd;
		*/
		$cmd = "/usr/bin/perl /var/www/html/dc/bin/moji.pl {$this->image_file} {$this->flg} {$this->moji} {$this->font} {$this->x} {$this->y} {$this->color} {$this->size}";
//print $cmd;
/*
		$fp = fopen("/var/www/html/dc/test.log", "a+");

		if (!(empty($fp))) {
		flock($fp, LOCK_EX);
		fputs($fp, date('Y-m-d H:i:s') ." : ". $cmd);
		fputs($fp, "\n");

		flock($fp, LOCK_UN);
		fclose($fp);
		}
*/
		passthru($cmd);
	}
	
}

?>
