<?php
/**
 *  Anime/Input.php
 *
 *  @author     {$author}
 *  @package    Dc
 *  @version    $Id: skel.action.php 387 2006-11-06 14:31:24Z cocoitiban $
 */

/**
 *  Anime_Inputフォームの実装
 *
 *  @author     {$author}
 *  @access     public
 *  @package    Dc
 */
class Dc_Form_AnimeInput extends Dc_ActionForm
{
    /** @var    bool    バリデータにプラグインを使うフラグ */
    var $use_validator_plugin = true;

    /**
     *  @access private
     *  @var    array   フォーム値定義
     */
    var $form = array(
		'file' => array(
			'name'		=> '画像',
			//'required'	=> true,
			'type'		=> VAR_TYPE_TEXT,
			'form_type'	=> FORM_TYPE_HIDDEN,
		),
		'font' => array(
			'type'		=> VAR_TYPE_TEXT,
			'form_type'	=> FORM_TYPE_SELECT,
			'option'		=> 'Util, font',
			),
    );
}

/**
 *  Anime_Inputアクションの実装
 *
 *  @author     {$author}
 *  @access     public
 *  @package    Dc
 */
class Dc_Action_AnimeInput extends Dc_ActionClass
{
    /**
     *  Anime_Inputアクションの前処理
     *
     *  @access public
     *  @return string      遷移名(正常終了ならnull, 処理終了ならfalse)
     */
    function prepare()
    {
        return null;
    }

    /**
     *  Anime_Inputアクションの実装
     *
     *  @access public
     *  @return string  遷移名
     */
    function perform()
    {
        return 'Anime_Input';
    }
}
?>
