<?php

class Dc_UtilManager extends Ethna_AppManager
{

	/**
	 * ���ץ��������
	 */
	function getAttrList($attr_name)
	{
		switch($attr_name)
		{
			// font
			case 'font':
				return $this->config->get('font');
				break;
			// ǯ
			case 'year': 
				for($i = 2007;$i <= date('Y')+1;$i++){
					$data[$i]['name'] = $i;
				}
				return $data;
				break;
			// ��
			case 'month': 
				for($i = 1;$i <= 12;$i++){
					$data[$i]['name'] = $i;
				}
				return $data;
				break;
			// ��
			case 'day': 
				for($i = 1;$i <= 31;$i++){
					$data[$i]['name'] = $i;
				}
				return $data;
				break;
			// ��
			case 'hour': 
				for($i = 0;$i <= 23;$i++){
					$data[$i]['name'] = $i;
				}
				return $data;
				break;
			// 10ʬ�ֳ�
			case '10min': 
				for($i = 0;$i <= 50;$i=$i+10){
					$data[$i]['name'] = $i;
				}
				return $data;
				break;
			// �ǥե����
			default:
				$data = $this->config->get($attr_name);
		}
		if(count($data) > 0) return $data;
		return array(array('name' =>''));
	}
	/**
	 * ������ʸ����
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
	 * �ǥХå������ϥ᥽�å� 
	 *  �����衧�ץ�������/log/����.log
	 * 
	 * @param  ���Ϥ�����ʸ����
	 * @return true
	 */
	function trace($str)
	{
		
		$log_file = dirname(dirname(__FILE__)) .'/log/'.date('Y-m-d') .'.log';
		// �ե�����¸�ߡ��񤭹��߸��¤γ�ǧ
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
