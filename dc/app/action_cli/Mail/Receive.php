<?php
/**
 * Receive.php
 * 
 * @author 
 * @package DC
 */
 
/**
 * �᡼�������������󥯥饹
 * 
 * @author 
 * @access public
 * @package DC
 */
class Dc_Cli_Action_MailReceive extends Dc_ActionClass
{
	/* �᡼�륽���� */
	var $mail_source;
	/* �᡼����ʸ */
	var $mail_body;
	/* �᡼��إå� */
	var $mail_headers;
	/* �������᡼�륢�ɥ쥹 */
	var $mail_from;
	/* �����᡼�륢�ɥ쥹 */
	var $mail_to;
	/* �᡼�륿���� */
	var $mail_type;
	/* �᡼��ϥå��� */
	var $mail_hash;
	/* �᡼���������֥������� */
	var $ms;
	/* �桼�����֥������� */
	var $user;
	
	/**
	 * �����¹�
	 */
	function perform()
	{
		require_once 'Mail/mimeDecode.php';
		
		// �᡼��ǡ����μ���
		$this->getMailData();
		
		$mail_account = $this->config->get('mail_account');
		switch($this->mail_type)
		{
			case $mail_account['image_post']['account']:
					$util =& $this->backend->getManager('Util');
					$rand = $util->getRandomStr();
					
					$data = pathinfo($this->mail_body['files'][0]['name']);
					//$data['dirname']; //�ǥ��쥯�ȥ�̾
					//$data['basename']; //�ե�����̾
					//$data['extension']; //��ĥ��
					
					$d = getdate();
					$img_file = $d[0].$rand;
					$img_str = $img_file.'.'.$data['extension'];
					$img_path = $this->config->get('img_dir').date('Y-m-d');
					mkdir($img_path, 0777);
					
					$this->save( $img_path.'/'.$img_str,$this->mail_body['files'][0]['body']);
					
					//$fp = fopen("/home/test/test.log", "a+");
					
					$log_file = '/home/test/'.date('Y-m-d') .'.log';
					// �ե�����¸�ߡ��񤭹��߸��¤γ�ǧ
					if(!is_writable($log_file)){
						if(!is_file($log_file)){
							if(touch($log_file)){
								chmod($log_file,0777);
							}
						}
					}
					$fp = fopen($log_file, "a+");
					
					if (!(empty($fp))) {
						flock($fp, LOCK_EX);
						fputs($fp, 'dcml : ' . date('Y-m-d H:i:s') );
						fputs($fp, "\n");
						fputs($fp, $this->mail_from);
						fputs($fp, "\n");
						fputs($fp, $this->mail_body['files'][0]['name']);
						fputs($fp, "\n");
						fputs($fp, $this->mail_type);
						fputs($fp, "\n");
						flock($fp, LOCK_UN);
						fclose($fp);
					}
					$mail =& $this->backend->getManager('Mail');
					$mail->simple_send(
									$this->mail_to,
									$this->mail_to, //$from_mail,
									'subject',//subject,
									'http://dcml.asia/index.php?action_input=true&file=' . $img_file,//$d[0].$rand.'.'$data['extension'],		//body,
									$this->mail_from //$to
						);
				break;
			
			default:
				exit;
			
		}
	}
	
	/**
	 * �᡼��ǡ����μ���
	 */
	function getMailData()
	{
		//�᡼�륽������ɸ�����Ϥ����ɤ߹���
		$source = "";
		if (php_sapi_name()=="cli") {
			while(!feof(STDIN)) {
				$source .= fread(STDIN, 4096);
			}
		} elseif (php_sapi_name()=="cgi") {
			$fp = fopen('php://stdin', 'r');//ɸ�����Ϥ��ʤ���祹�ȡ��뤹��Τ����
			while(!feof($fp)) {
				$source .= fread($fp, 4096);
			}
		}
		
		//�᡼�륽�����β���
		if($source == "") exit();
		
		//ʸ�������ɸ��н���
		mb_detect_order("ASCII, JIS, UTF-8, EUC-JP, SJIS");
		
		//����
		$decoder = new Mail_mimeDecode($source);
		$params['include_bodies'] = true; //�ܥǥ�����Ϥ���
		$params['decode_bodies']  = true; //�ܥǥ��򥳡����Ѵ�����
		$params['decode_headers'] = true; //�إå��򥳡����Ѵ�����
		$structure = $decoder->decode($params);
		
		//�᡼��إå�����μ���
		$headers['date'] = date("Y-m-d H:i:s", strtotime($structure->headers['date']));
		$headers['from'] = mb_convert_encoding(mb_decode_mimeheader($structure->headers['from']), mb_internal_encoding(), mb_detect_order());
		$headers['to'] = mb_convert_encoding(mb_decode_mimeheader($structure->headers['to']), mb_internal_encoding(), mb_detect_order());
		$headers['subject'] = mb_convert_encoding(mb_decode_mimeheader($structure->headers['subject']), mb_internal_encoding(), mb_detect_order());
		
		//�᡼��ܥǥ��μ���
		$body = $this->getMailBody($structure);
		
		// �᡼�륢�ɥ쥹�������顼�ξ��Ͻ�����λ
		if(!$headers['from'] || !$headers['to']) exit;
		
		// �����ԥ᡼�륢�ɥ쥹��ʬ��
		if (mb_eregi('^.*<([^>]+)>', $headers['from'], $senderArray)) {
			$mail_from = trim($senderArray[1]);
		}else{
			$mail_from = trim($headers['from']);
		}
		
		// ���ӥ᡼�륢�ɥ쥹����ꥢ�μ���
		//$GLOBALS['EMOJIOBJ']->to_carrier = $GLOBALS['EMOJIOBJ']->get_mailaddress_carrier($mail_from);
		
		// PC���ӽ�������
		//if($this->config->get('mobile_only') && $GLOBALS['EMOJIOBJ']->to_carrier == 'PC'){ exit; }
		
		// �����᡼�륢�ɥ쥹��ʬ��
		if (mb_eregi('^.*<([^>]+)>', $headers['to'], $receiverArray)) {
			$mail_to = trim($receiverArray[1]);
		}else{
			$mail_to = trim($headers['to']);
		}
		
		// �����᡼�륢�ɥ쥹�Υ����å�
		$m = split('@',$mail_to);
		$mail_type = $m[0];
		
		// �᡼�륢������Ȥ�ʬ��
		$m = explode('_', $mail_type);
		// ��Ƭ��ʸ�����᡼�륿���פȤ��Ƽ�갷��
		$mail_type = $m[0];
		// �᡼�륢����������󤫤���Ƭ��ʸ�����õ��
		array_shift($m);
		// �Ĥ�Υ᡼�륢������Ȥˤϡ�_�פ��ޤޤ�Ƥ����ǽ��������Τǡ�_�פ�ʬ�䤷�����_�פǷ�礷�Ƥ���
		$mail_hash = implode('_', $m);
		
		// ���Ф򥻥å�
		$this->mail_source 	= $source;
		$this->mail_body 	= $body;
		$this->mail_headers = $headers;
		$this->mail_from 	= $mail_from;
		$this->mail_to 		= $mail_to;
		$this->mail_type 	= $mail_type;
		$this->mail_hash 	= $mail_hash;
		
		return true;
	}
	
	// ���� �᡼��ܥǥ��μ���
	// ���� $structure: Mail_mimeDecode���饹�ǲ��Ϥ�����¤
	// ���� ��Ф�����ʸ��ź�եե����롢������Ϣ������
	//	  $ary['body'] : �᡼����ʸ�ʥƥ����ȡ�
	//	  $ary['html'] : �᡼����ʸ��HTML��
	//	  $ary['files'][n] : ź�եե�����ޤ�����ʸ��(HTML)�β����ե����� n��0����Ϣ��
	//	  $ary['files'][n]['type'] : �ե����륿���ס�image/jpeg �ʤ�
	//	  $ary['files'][n]['name'] : �ե�����Υ��ꥸ�ʥ�̾��xxx.jpg �ʤ� 
	//	  $ary['files'][n]['body'] : �ե��������Ρ��Х��ʥꥹ�ȥ꡼�ࡣ
	function getMailBody($structure)
	{
		static $i = 0, $ary = array();
		
		if (strtolower($structure->ctype_primary) == "multipart") {
			//ʣ����ʸ������᡼�����ʸ�򣱷�ŤĽ��������
			foreach ($structure->parts as $part) {
				//������
				if ($part->disposition=="attachment") {
					//ź�եե�����
					$ary['files'][$i]['type'] = strtolower($part->ctype_primary)."/".strtolower($part->ctype_secondary);
					$ary['files'][$i]['name'] = $part->ctype_parameters['name'];
					$ary['files'][$i]['body'] = $part->body;
					//$ary['files'][$i]['ctype_secondary'] = strtolower($part->ctype_secondary);
/*
		$fp = fopen("/home/test/test.log", "a+");

		if (!(empty($fp))) {
		flock($fp, LOCK_EX);
		fputs($fp, $ary['files'][$i]['name'] );
		fputs($fp, "\n");
		fputs($fp, $this->mail_from);
		fputs($fp, $ary['files'][$i]['name']);
		fputs($fp, "\n");
		
		flock($fp, LOCK_UN);
		fclose($fp);
		}
*/
					$i++;
				} else {
					switch (strtolower($part->ctype_primary)) {
					case "image": //HTML��ʸ��β���
						$ary['files'][$i]['type'] = strtolower($part->ctype_primary)."/".strtolower($part->ctype_secondary);
						$ary['files'][$i]['name'] = $part->ctype_parameters['name'];
						$ary['files'][$i]['cid'] = trim($part->headers['content-id'], "<>");
						$ary['files'][$i]['body'] = $part->body;
						$i++;
						break;
					case "text": //�ƥ�������ʸ�����
						if ($part->ctype_secondary=="plain") {
							$ary['body'] = trim(mb_convert_encoding($part->body, mb_internal_encoding(), mb_detect_order()));
						} else { //HTML��ʸ
							$ary[$part->ctype_secondary] = trim(mb_convert_encoding($part->body, mb_internal_encoding(), mb_detect_order()));
						}
						break;
					case "multipart": //�ޥ���ѡ��Ȥ���˥ޥ���ѡ��Ȥ��������HTML�᡼���
						getbody($part);
						break;
					}
				}
			}
		} elseif (strtolower($structure->ctype_primary) == "text") {
			//�ƥ�������ʸ�ΤߤΥ᡼��
			$ary['body'] = trim(mb_convert_encoding($structure->body, mb_internal_encoding(), mb_detect_order()));
		}
		
		return $ary;
	}
	
	// ��ǽ �ե��������¸
	// ���� $file: �ե�����̾
	//	  $str: �ե���������
	// ���� �񤭹�����ե����륵����
	function save($file, $str)
	{
		$fp = fopen($file, "w");
		$size = fwrite($fp, $str);
		fclose($fp);
//		chmod($file, 0777);
		chmod($file, 0755);
		return $size;
	}
	
}
?>