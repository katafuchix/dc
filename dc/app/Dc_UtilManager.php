<?php

class Dc_UtilManager extends Ethna_AppManager
{

	/**
	 * オプション選択
	 */
	function getAttrList($attr_name)
	{
		switch($attr_name)
		{
			// font
			case 'font':
				return $this->config->get('font');
				break;
			// 年
			case 'year': 
				for($i = 2007;$i <= date('Y')+1;$i++){
					$data[$i]['name'] = $i;
				}
				return $data;
				break;
			// 月
			case 'month': 
				for($i = 1;$i <= 12;$i++){
					$data[$i]['name'] = $i;
				}
				return $data;
				break;
			// 日
			case 'day': 
				for($i = 1;$i <= 31;$i++){
					$data[$i]['name'] = $i;
				}
				return $data;
				break;
			// 時
			case 'hour': 
				for($i = 0;$i <= 23;$i++){
					$data[$i]['name'] = $i;
				}
				return $data;
				break;
			// 10分間隔
			case '10min': 
				for($i = 0;$i <= 50;$i=$i+10){
					$data[$i]['name'] = $i;
				}
				return $data;
				break;
			// デフォルト
			default:
				$data = $this->config->get($attr_name);
		}
		if(count($data) > 0) return $data;
		return array(array('name' =>''));
	}
	/**
	 * ランダム文字列
	 */
	function getRandomStr(){
		$str = "abcdefghijklmnopqrstuvwxyz123456789";
		$len = strlen($str);
		$ret = "";
		for($i=0;$i<10;$i++){
			$h = rand(0, $len-1);
			$ret .= substr($str,$h,1);
		}
		return $ret;
	}
	
	
	/**
	 * デバッグログ出力メソッド 
	 *  出力先：プロジェクト/log/日付.log
	 * 
	 * @param  出力したい文字列
	 * @return true
	 */
	function trace($str)
	{
		
		$log_file = dirname(dirname(__FILE__)) .'/log/'.date('Y-m-d') .'.log';
		// ファイル存在＆書き込み権限の確認
		if(!is_writable($log_file)){
			if(!is_file($log_file)){
				if(touch($log_file)){
					chmod($log_file,0777);
				}else{
					return false;
				}
			}
		}else{
			$fp = @fopen($log_file, "a+");
			if($str){
				if (!(empty($fp))) {
					flock($fp, LOCK_EX);
					fputs($fp, date('H:i:s').' : ');
					fputs($fp, $str);
					fputs($fp, "\n");
					flock($fp, LOCK_UN);
					fclose($fp);
				}
			}
			return true;
		}
	}
}

?>
