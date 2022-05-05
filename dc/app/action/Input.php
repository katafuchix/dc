<?php
/**
 *  Input.php
 *
 *  @author     {$author}
 *  @package    Dc
 *  @version    $Id: skel.action.php 387 2006-11-06 14:31:24Z cocoitiban $
 */

/**
 *  Inputフォームの実装
 *
 *  @author     {$author}
 *  @access     public
 *  @package    Dc
 */
class Dc_Form_Input extends Dc_ActionForm
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
			'name'		=> '画像',
			//'required'	=> true,
			'type'		=> VAR_TYPE_TEXT,
			'form_type'	=> FORM_TYPE_HIDDEN,
		),
		'font' => array(
			'type'		=> VAR_TYPE_TEXT,
			'form_type'	=> FORM_TYPE_SELECT,
			'option'		=> 'Util, font',
			/*
			'option' => array(
						'font' => '2009',
						'fotn' => '2010',
					),
			*/
			),
    );
}

/**
 *  Inputアクションの実装
 *
 *  @author     {$author}
 *  @access     public
 *  @package    Dc
 */
class Dc_Action_Input extends Dc_ActionClass
{
    /**
     *  Inputアクションの前処理
     *
     *  @access public
     *  @return string      遷移名(正常終了ならnull, 処理終了ならfalse)
     */
    function prepare()
    {
        return null;
    }

    /**
     *  Inputアクションの実装
     *
     *  @access public
     *  @return string  遷移名
     */
    function perform()
    {

		//ディレクトリ内のファイル一覧を入手。
		$img_path = $this->config->get('img_dir').date('Y-m-d');
		$file_list = scandir($img_path);
		$image_file = "";
		foreach ($file_list as $file){
			if(ereg($this->af->get('file'),$file)){
				$image_file = $file;
				break;
			}
		}
		if($image_file == ''){
			return 'Index';
		}
		
		//$this->af->clearFormVars();
		$this->af->setApp('image_file', $image_file);
		$this->af->set('image_file', $image_file);
        return 'Input';
    }
}
?>
