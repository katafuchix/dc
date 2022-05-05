<?php

require_once('Mail.php');
require_once('Mail/mime.php');

class Dc_MailManager extends Ethna_AppManager
{

    /**
     * @access public
     */
	
	var $to;
	var $from;
	var $subject;
	var $message;
	
    /**
     * @access private
     */

    /**
     * @access public
     */

    /**
     * メールを送信する
     *
     * @param string $name
     * @return mixed
     * @static
     */
     
	function simple_send(
	
						$from_name,
						$from_mail,
						$subject,
						$body,
						$to
	){
	
		$result = $this->encoding(
									$from_name,	//from_name
									$from_mail,	//from_mail
									$subject,	//subject
									$body,	//message
									$to		//to
		);
		
		return $result;	
	
	}
	
	
	function encoding(
						$from_name,
						$from_mail,
						$subject,
						$body,
						$send
		){
		
		//sendmailのパス
		$params['sendmail_path'] = '/usr/sbin/sendmail';
		
		//実行時間の最大値の延長設定
		set_time_limit(1000);
		
		//fromの名前をエンコード
		$from_name = mb_convert_encoding($from_name, "JIS", "EUC-JP");
		$from_name = "=?iso-2022-jp?B?" . base64_encode($from_name) . "?=";
		$from = ($from_mail) ? "$from_name<$from_mail>" : "$from_name<root@$HTTP_POST>";
		
		//タイトルをエンコード
		$subject = mb_convert_encoding($subject, "JIS", "EUC-JP");
		$subject = "=?iso-2022-jp?B?" . base64_encode($subject) . "?=";
		
		//bodyをエンコード
		$body = str_replace("\r\n", "\n", $body);
		$body = str_replace("\r", "\n", $body);
		$body = mb_convert_encoding($body, "JIS", "EUC-JP");
		
		//ヘッダを整理
		$recipients = $send;
		$headers['From']    = $from;
		$headers['To']      = $send;
		$headers['Subject'] = $subject;
		$headers['MIME-version'] = '1.0';
		$headers['Content-Type'] = 'text/plain; charset="iso-2022-jp"';
		$headers['Content-Transfer-Encoding'] = '7bit';

			//メールの送信
			$mail_object =& Mail::factory('sendmail', $params);
			$mail_object->send($recipients, $headers, $body);
		
		return true;
		
	}
		
    /**
     * @access private
     */


	function getMailStructure($id,$pass){

			$array = $this->mail_receive($id,$pass);

			$params['include_bodies'] = true;
			$params['decode_bodies']  = true;
			$params['decode_headers'] = true;
			$params['crlf'] = "\r\n";

			$mail =& new Mail_mimeDecode($array[1]);
														
			$mailStructure = $mail->decode( $params );
																		
			return $mailStructure;

	}


	function mail_receive($user, $pwd)
	{
		    $host = "mail406.lolipop.jp";
		    $port = 110;

			$fp = fsockopen($host, $port);

			// ログイン
			$line = fgets($fp, 512);
			fputs($fp, "USER $user\r\n");	// USER名
			$line = fgets($fp, 512);		
			fputs($fp, "PASS $pwd\r\n");	// パスワード
			$line = fgets($fp, 512);
			if( !eregi("OK", $line) )	// ログイン失敗？
			{
				fclose($fp);
				return false;
			}

			// メールボックス内のデータを取得
			fputs($fp, "STAT\r\n");
			$line = fgets($fp, 512);
	    	    list($stat, $num, $size) = explode(' ', $line);
		    	if( 0+$num == 0 )	// データがない？
			    {
				    fclose($fp);
					return false;
				}

				// それぞれ受信して、配列に納める 
				for($id=1;$id<=$num;$id++)
				{
					fputs($fp, "RETR $id\r\n");
					$line = fgets($fp);

					$msg[$id] = "";
					while( !eregi("^\.\r?\n", $line) )
		        	{
				    	$line = fgets($fp, 512);
					    $msg[$id] .= $line;
					}

					// fputs($fp, "DELE $id\r\n");	
					 // $line = fgets($fp, 512);
				}

				fputs($fp, "QUIT\r\n");
				fclose($fp);

			 return $msg;

	}


	
}

?>
