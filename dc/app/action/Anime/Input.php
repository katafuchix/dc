<?php
/**
 *  Anime/Input.php
 *
 *  @author     {$author}
 *  @package    Dc
 *  @version    $Id: skel.action.php 387 2006-11-06 14:31:24Z cocoitiban $
 */

/**
 *  Anime_Input�ե�����μ���
 *
 *  @author     {$author}
 *  @access     public
 *  @package    Dc
 */
class Dc_Form_AnimeInput extends Dc_ActionForm
{
    /** @var    bool    �Х�ǡ����˥ץ饰�����Ȥ��ե饰 */
    var $use_validator_plugin = true;

    /**
     *  @access private
     *  @var    array   �ե����������
     */
    var $form = array(
		'file' => array(
			'name'		=> '����',
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
 *  Anime_Input���������μ���
 *
 *  @author     {$author}
 *  @access     public
 *  @package    Dc
 */
class Dc_Action_AnimeInput extends Dc_ActionClass
{
    /**
     *  Anime_Input����������������
     *
     *  @access public
     *  @return string      ����̾(���ｪλ�ʤ�null, ������λ�ʤ�false)
     */
    function prepare()
    {
        return null;
    }

    /**
     *  Anime_Input���������μ���
     *
     *  @access public
     *  @return string  ����̾
     */
    function perform()
    {
        return 'Anime_Input';
    }
}
?>
