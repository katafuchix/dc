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
     * �᡼�����������
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
		
		//sendmail�Υѥ�
		$params['sendmail_path'] = '/usr/sbin/sendmail';
		
		//�¹Ի��֤κ����ͤα�Ĺ����
		set_time_limit(1000);
		
		//from��̾���򥨥󥳡���
		$from_name = mb_convert_encoding($from_name, "JIS", "EUC-JP");
		$from_name = "=?iso-2022-jp?B?" . base64_encode($from_name) . "?=";
		$from = ($from_mail) ? "$from_name<$from_mail>" : "$from_name<root@$HTTP_POST>";
		
		//�����ȥ�򥨥󥳡���
		$subject = mb_convert_encoding($subject, "JIS", "EUC-JP");
		$subject = "=?iso-2022-jp?B?" . base64_encode($subject) . "?=";
		
		//body�򥨥󥳡���
		$body = str_replace("\r\n", "\n", $body);
		$body = str_replace("\r", "\n", $body);
		$body = mb_convert_encoding($body, "JIS", "EUC-JP");
		
		//�إå�������
		$recipients = $send;
		$headers['From']    = $from;
		$headers['To']      = $send;
		$headers['Subject'] = $subject;
		$headers['MIME-version'] = '1.0';
		$headers['Content-Type'] = 'text/plain; charset="iso-2022-jp"';
		$headers['Content-Transfer-Encoding'] = '7bit';

			//�᡼�������
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

			// ������
			$line = fgets($fp, 512);
			fputs($fp, "USER $user\r\n");	// USER̾
			$line = fgets($fp, 512);		
			fputs($fp, "PASS $pwd\r\n");	// �ѥ����
			$line = fgets($fp, 512);
			if( !eregi("OK", $line) )	// �������ԡ�
			{
				fclose($fp);
				return false;
			}

			// �᡼��ܥå�����Υǡ��������
			fputs($fp, "STAT\r\n");
			$line = fgets($fp, 512);
	    	    list($stat, $num, $size) = explode(' ', $line);
		    	if( 0+$num == 0 )	// �ǡ������ʤ���
			    {
				    fclose($fp);
					return false;
				}

				// ���줾��������ơ������Ǽ��� 
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
