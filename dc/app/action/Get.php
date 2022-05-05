<?php
/**
 *  File.php
 *
 *  @author     {$author}
 *  @package    Dc
 *  @version    $Id: skel.action.php 387 2006-11-06 14:31:24Z cocoitiban $
 */

/**
 *  Getフォームの実装
 *
 *  @author     {$author}
 *  @access     public
 *  @package    Dc
 */
class Dc_Form_Get extends Dc_ActionForm
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
		'file' => array(
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
    );
}

/**
 *  Getアクションの実装
 *
 *  @author     {$author}
 *  @access     public
 *  @package    Dc
 */
class Dc_Action_Get extends Dc_ActionClass
{
    /**
     *  Fileアクションの前処理
     *
     *  @access public
     *  @return string      遷移名(正常終了ならnull, 処理終了ならfalse)
     */
    function prepare()
    {
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
		header("content-type: image/jpeg");
		readfile($this->config->get('img_dir') . $this->af->get('file'));
    	exit;
    }
}
?>
