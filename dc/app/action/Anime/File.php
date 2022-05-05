<?php
/**
 *  File.php
 *
 *  @author     {$author}
 *  @package    Dc
 *  @version    $Id: skel.action.php 387 2006-11-06 14:31:24Z cocoitiban $
 */

/**
 *  Fileフォームの実装
 *
 *  @author     {$author}
 *  @access     public
 *  @package    Dc
 */
class Dc_Form_AnimeFile extends Dc_ActionForm
{
    /** @var    bool    バリデータにプラグインを使うフラグ */
    var $use_validator_plugin = true;

    /**
     *  @access private
     *  @var    array   フォーム値定義
     */
    var $form = array(
		'image_file' => array(
			'name'		=> '',
			//'required'	=> true,
			'type'		=> VAR_TYPE_TEXT,
			'form_type'	=> FORM_TYPE_TEXT,
		),
		'moji' => array(
			'name'		=> '入力文字',
			//'required'	=> true,
			'type'		=> VAR_TYPE_TEXT,
			'form_type'	=> FORM_TYPE_TEXT,
		),
		'x' => array(
			'name'		=> 'x',
			'type'		=> VAR_TYPE_TEXT,
			'form_type'	=> FORM_TYPE_TEXT,
		),
		'y' => array(
			'name'		=> 'y',
			'type'		=> VAR_TYPE_TEXT,
			'form_type'	=> FORM_TYPE_TEXT,
		),
		'size' => array(
			'name'		=> 'size',
			'type'		=> VAR_TYPE_TEXT,
			'form_type'	=> FORM_TYPE_TEXT,
		),
		'font' => array(
			'name'		=> 'font',
			'type'		=> VAR_TYPE_TEXT,
			'form_type'	=> FORM_TYPE_TEXT,
		),
		'color' => array(
			'name'		=> 'color',
			'type'		=> VAR_TYPE_TEXT,
			'form_type'	=> FORM_TYPE_TEXT,
		),
		'flg' => array(
			'name'		=> 'flg',
			'type'		=> VAR_TYPE_TEXT,
			'form_type'	=> FORM_TYPE_TEXT,
		),
    );
}

/**
 *  Fileアクションの実装
 *
 *  @author     {$author}
 *  @access     public
 *  @package    Dc
 */
class Dc_Action_AnimeFile extends Dc_ActionClass
{
    /**
     *  Fileアクションの前処理
     *
     *  @access public
     *  @return string      遷移名(正常終了ならnull, 処理終了ならfalse)
     */
    function prepare()
    {

/*
		$fp = fopen("/var/www/html/dc/test.log", "a+");

		if (!(empty($fp))) {
		flock($fp, LOCK_EX);
		fputs($fp, date('Y-m-d H:i:s') ." : ". $this->af->get('moji'));
		fputs($fp, "\n");

		flock($fp, LOCK_UN);
		fclose($fp);
		}
//		echo $this->af->get('moji');
*/
        return null;
    }
    /**
     *  Fileアクションの実装
     *
     *  @access public
     *  @return string  遷移名
     */
    function perform()
    {
    	$image =& $this->backend->getManager('AnimeGenerator');
    	$image->setImageFile($this->af->get('image_file'));
    	$image->setMoji($this->af->get('moji'));
    	$image->setFont($this->af->get('font'));
    	$image->setX($this->af->get('x'));
    	$image->setY($this->af->get('y'));
    	$image->setColor($this->af->get('color'));
    	$image->setSize($this->af->get('size'));
    	if($this->af->get('flg')){
    		$image->setFlg($this->af->get('flg'));
    	}else{
    		$image->setFlg('0');
    	}
    	$image->out();
    	exit;
    	
        return 'File';
    }
}
?>
