<?php
/**
 * Receive.php
 * 
 * @author 
 * @package DC
 */
 
/**
 * メール受信アクションクラス
 * 
 * @author 
 * @access public
 * @package DC
 */
class Dc_Cli_Action_MailReceive extends Dc_ActionClass
{
	/* メールソース */
	var $mail_source;
	/* メール本文 */
	var $mail_body;
	/* メールヘッダ */
	var $mail_headers;
	/* 送信元メールアドレス */
	var $mail_from;
	/* 受信メールアドレス */
	var $mail_to;
	/* メールタイプ */
	var $mail_type;
	/* メールハッシュ */
	var $mail_hash;
	/* メール送信オブジェクト */
	var $ms;
	/* ユーザオブジェクト */
	var $user;
	
	/**
	 * 処理実行
	 */
	function perform()
	{
		require_once 'Mail/mimeDecode.php';
		
		// メールデータの取得
		$this->getMailData();
		
		$mail_account = $this->config->get('mail_account');
		switch($this->mail_type)
		{
			case $mail_account['image_post']['account']:
					$util =& $this->backend->getManager('Util');
					$rand = $util->getRandomStr();
					
					$data = pathinfo($this->mail_body['files'][0]['name']);
					//$data['dirname']; //ディレクトリ名
					//$data['basename']; //ファイル名
					//$data['extension']; //拡張子
					
					$d = getdate();
					$img_file = $d[0].$rand;
					$img_str = $img_file.'.'.$data['extension'];
					$img_path = $this->config->get('img_dir').date('Y-m-d');
					mkdir($img_path, 0777);
					
					$this->save( $img_path.'/'.$img_str,$this->mail_body['files'][0]['body']);
					
					//$fp = fopen("/home/test/test.log", "a+");
					
					$log_file = '/home/test/'.date('Y-m-d') .'.log';
					// ファイル存在＆書き込み権限の確認
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
	 * メールデータの取得
	 */
	function getMailData()
	{
		//メールソースを標準入力から読み込み
		$source = "";
		if (php_sapi_name()=="cli") {
			while(!feof(STDIN)) {
				$source .= fread(STDIN, 4096);
			}
		} elseif (php_sapi_name()=="cgi") {
			$fp = fopen('php://stdin', 'r');//標準入力がない場合ストールするので注意
			while(!feof($fp)) {
				$source .= fread($fp, 4096);
			}
		}
		
		//メールソースの解析
		if($source == "") exit();
		
		//文字コード検出順番
		mb_detect_order("ASCII, JIS, UTF-8, EUC-JP, SJIS");
		
		//解析
		$decoder = new Mail_mimeDecode($source);
		$params['include_bodies'] = true; //ボディを解析する
		$params['decode_bodies']  = true; //ボディをコード変換する
		$params['decode_headers'] = true; //ヘッダをコード変換する
		$structure = $decoder->decode($params);
		
		//メールヘッダ情報の取得
		$headers['date'] = date("Y-m-d H:i:s", strtotime($structure->headers['date']));
		$headers['from'] = mb_convert_encoding(mb_decode_mimeheader($structure->headers['from']), mb_internal_encoding(), mb_detect_order());
		$headers['to'] = mb_convert_encoding(mb_decode_mimeheader($structure->headers['to']), mb_internal_encoding(), mb_detect_order());
		$headers['subject'] = mb_convert_encoding(mb_decode_mimeheader($structure->headers['subject']), mb_internal_encoding(), mb_detect_order());
		
		//メールボディの取得
		$body = $this->getMailBody($structure);
		
		// メールアドレス取得エラーの場合は処理終了
		if(!$headers['from'] || !$headers['to']) exit;
		
		// 送信者メールアドレスの分割
		if (mb_eregi('^.*<([^>]+)>', $headers['from'], $senderArray)) {
			$mail_from = trim($senderArray[1]);
		}else{
			$mail_from = trim($headers['from']);
		}
		
		// 携帯メールアドレスキャリアの取得
		//$GLOBALS['EMOJIOBJ']->to_carrier = $GLOBALS['EMOJIOBJ']->get_mailaddress_carrier($mail_from);
		
		// PCを排除する場合
		//if($this->config->get('mobile_only') && $GLOBALS['EMOJIOBJ']->to_carrier == 'PC'){ exit; }
		
		// 受信メールアドレスの分割
		if (mb_eregi('^.*<([^>]+)>', $headers['to'], $receiverArray)) {
			$mail_to = trim($receiverArray[1]);
		}else{
			$mail_to = trim($headers['to']);
		}
		
		// 受信メールアドレスのチェック
		$m = split('@',$mail_to);
		$mail_type = $m[0];
		
		// メールアカウントを分割
		$m = explode('_', $mail_type);
		// 先頭の文字列をメールタイプとして取り扱う
		$mail_type = $m[0];
		// メールアカウント配列から先頭の文字列を消去する
		array_shift($m);
		// 残りのメールアカウントには「_」が含まれている可能性があるので「_」で分割したら「_」で結合しておく
		$mail_hash = implode('_', $m);
		
		// メンバをセット
		$this->mail_source 	= $source;
		$this->mail_body 	= $body;
		$this->mail_headers = $headers;
		$this->mail_from 	= $mail_from;
		$this->mail_to 		= $mail_to;
		$this->mail_type 	= $mail_type;
		$this->mail_hash 	= $mail_hash;
		
		return true;
	}
	
	// 概要 メールボディの取得
	// 引数 $structure: Mail_mimeDecodeクラスで解析した構造
	// 戻値 抽出した本文、添付ファイル、画像の連想配列
	//	  $ary['body'] : メール本文（テキスト）
	//	  $ary['html'] : メール本文（HTML）
	//	  $ary['files'][n] : 添付ファイルまたは本文中(HTML)の画像ファイル nは0から連番
	//	  $ary['files'][n]['type'] : ファイルタイプ。image/jpeg など
	//	  $ary['files'][n]['name'] : ファイルのオリジナル名。xxx.jpg など 
	//	  $ary['files'][n]['body'] : ファイル本体。バイナリストリーム。
	function getMailBody($structure)
	{
		static $i = 0, $ary = array();
		
		if (strtolower($structure->ctype_primary) == "multipart") {
			//複数本文があるメール（本文を１件づつ処理する）
			foreach ($structure->parts as $part) {
				//タイプ
				if ($part->disposition=="attachment") {
					//添付ファイル
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
					case "image": //HTML本文中の画像
						$ary['files'][$i]['type'] = strtolower($part->ctype_primary)."/".strtolower($part->ctype_secondary);
						$ary['files'][$i]['name'] = $part->ctype_parameters['name'];
						$ary['files'][$i]['cid'] = trim($part->headers['content-id'], "<>");
						$ary['files'][$i]['body'] = $part->body;
						$i++;
						break;
					case "text": //テキスト本文の抽出
						if ($part->ctype_secondary=="plain") {
							$ary['body'] = trim(mb_convert_encoding($part->body, mb_internal_encoding(), mb_detect_order()));
						} else { //HTML本文
							$ary[$part->ctype_secondary] = trim(mb_convert_encoding($part->body, mb_internal_encoding(), mb_detect_order()));
						}
						break;
					case "multipart": //マルチパートの中にマルチパートがある場合（HTMLメール）
						getbody($part);
						break;
					}
				}
			}
		} elseif (strtolower($structure->ctype_primary) == "text") {
			//テキスト本文のみのメール
			$ary['body'] = trim(mb_convert_encoding($structure->body, mb_internal_encoding(), mb_detect_order()));
		}
		
		return $ary;
	}
	
	// 機能 ファイルの保存
	// 引数 $file: ファイル名
	//	  $str: ファイル内容
	// 戻値 書き込んだファイルサイズ
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