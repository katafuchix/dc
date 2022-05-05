<?php
/**
 *  Output.php
 *
 *  @author     {$author}
 *  @package    Dc
 *  @version    $Id: skel.action.php 387 2006-11-06 14:31:24Z cocoitiban $
 */

/**
 *  Outputフォームの実装
 *
 *  @author     {$author}
 *  @access     public
 *  @package    Dc
 */
class Dc_Form_Output extends Dc_ActionForm
{
    /** @var    bool    バリデータにプラグインを使うフラグ */
    var $use_validator_plugin = true;

    /**
     *  @access private
     *  @var    array   フォーム値定義
     */
    var $form = array(
        /*
        'sample' => array(
            // フォームの定義
            'type'          => VAR_TYPE_INT,    // 入力値型
            'form_type'     => FORM_TYPE_TEXT,  // フォーム型
            'name'          => 'サンプル',      // 表示名

            // バリデータ(記述順にバリデータが実行されます)
            'required'      => true,            // 必須オプション(true/false)
            'min'           => null,            // 最小値
            'max'           => null,            // 最大値
            'regexp'        => null,            // 文字種指定(正規表現)

            // フィルタ
            'filter'        => null,            // 入力値変換フィルタオプション
        ),
        */

		'text' => array(
			'name'		=> '入力文字',
			'required'	=> true,
			'type'		=> VAR_TYPE_TEXT,
			'form_type'	=> FORM_TYPE_TEXTAREA,
		),
		'image_file' => array(
			'name'		=> '画像',
			//'required'	=> true,
			'type'		=> VAR_TYPE_TEXT,
			'form_type'	=> FORM_TYPE_HIDDEN,
		),
		'x' => array(
			'name'		=> '横位置',
			'required'	=> true,
			'type'		=> VAR_TYPE_INT,
			'form_type'	=> FORM_TYPE_SELECT,
			'option'		=> 'Util, x',
			/*
			'option'	=> array(
							10 => '10', 
							20 => '20',
							30 => '30',
							40 => '40',
							50 => '50',
							60 => '60',
							70 => '70',
							),
			*/
		),
		'y' => array(
			'name'		=> '縦位置',
			'required'	=> true,
			'type'		=> VAR_TYPE_INT,
			'form_type'	=> FORM_TYPE_SELECT,
			'option'		=> 'Util, y',
			/*
			'option'	=> array(
							10 => '10', 
							20 => '20',
							30 => '30',
							40 => '40',
							50 => '50',
							60 => '60',
							70 => '70',
							80 => '80',
							90 => '90',
							100 => '100',
							110 => '110',
							120 => '120',
							130 => '130',
							),
			*/
		),
		'size' => array(
			'name'		=> '大きさ',
			'required'	=> true,
			'type'		=> VAR_TYPE_INT,
			'form_type'	=> FORM_TYPE_SELECT,
			'option'		=> 'Util, size',
		),
		'font' => array(
			'name'		=> '',
//			'required'	=> true,
			'type'		=> VAR_TYPE_TEXT,
			'form_type'	=> FORM_TYPE_SELECT,
			'option'		=> 'Util, font',
		),
		'color' => array(
			'name'		=> '文字色',
//			'required'	=> true,
			'type'		=> VAR_TYPE_TEXT,
			'form_type'	=> FORM_TYPE_SELECT,
			'option'		=> 'Util, color',
		),
		'submit' => array(
			'name'		=> '送信',
			'form_type'	=> FORM_TYPE_SUBMIT,
			'type'		=> VAR_TYPE_STRING,
		),
			
    );
}

/**
 *  Outputアクションの実装
 *
 *  @author     {$author}
 *  @access     public
 *  @package    Dc
 */
class Dc_Action_Output extends Dc_ActionClass
{
    /**
     *  Outputアクションの前処理
     *
     *  @access public
     *  @return string      遷移名(正常終了ならnull, 処理終了ならfalse)
     */
    function prepare()
    {
        return null;
    }

    /**
     *  Outputアクションの実装
     *
     *  @access public
     *  @return string  遷移名
     */
    function perform()
    {
		$string = str_replace("\n", "RR", $this->af->get('text'));
		//$string = str_replace("\r\n", ",", $string);
		$string = str_replace("\r", "BB", $string);
		//$string = str_replace("\n\r", ",", $string);
    	$this->af->setApp('image_file',$this->af->get('image_file'));
    	$this->af->setApp('text', urlencode($this->af->get('text')));
    	$this->af->setApp('font', urlencode($this->af->get('font')));
    	$this->af->setApp('color', urlencode($this->af->get('color')));
    	$this->af->setApp('text', urlencode($string));
    	$this->af->setApp('x', $this->af->get('x'));
    	$this->af->setApp('y', $this->af->get('y'));
		$this->af->setApp('size', $this->af->get('size'));
		
        return 'Output';
    }
}
?>
