<?php
/**
 *  File.php
 *
 *  @author     {$author}
 *  @package    Dc
 *  @version    $Id: skel.action.php 387 2006-11-06 14:31:24Z cocoitiban $
 */

/**
 *  Get�ե�����μ���
 *
 *  @author     {$author}
 *  @access     public
 *  @package    Dc
 */
class Dc_Form_Get extends Dc_ActionForm
{
    /** @var    bool    �Х�ǡ����˥ץ饰�����Ȥ��ե饰 */
    var $use_validator_plugin = true;

    /**
     *  @access private
     *  @var    array   �ե����������
     */
    var $form = array(
        /*
        'sample' => array(
            // �ե���������
            'type'          => VAR_TYPE_INT,    // �����ͷ�
            'form_type'     => FORM_TYPE_TEXT,  // �ե����෿
            'name'          => '����ץ�',      // ɽ��̾

            // �Х�ǡ���(���ҽ�˥Х�ǡ������¹Ԥ���ޤ�)
            'required'      => true,            // ɬ�ܥ��ץ����(true/false)
            'min'           => null,            // �Ǿ���
            'max'           => null,            // ������
            'regexp'        => null,            // ʸ�������(����ɽ��)

            // �ե��륿
            'filter'        => null,            // �������Ѵ��ե��륿���ץ����
        ),
        */
		'file' => array(
			'name'		=> '',
			//'required'	=> true,
			'type'		=> VAR_TYPE_TEXT,
			'form_type'	=> FORM_TYPE_TEXT,
		),
		'moji' => array(
			'name'		=> '����ʸ��',
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
 *  Get���������μ���
 *
 *  @author     {$author}
 *  @access     public
 *  @package    Dc
 */
class Dc_Action_Get extends Dc_ActionClass
{
    /**
     *  File����������������
     *
     *  @access public
     *  @return string      ����̾(���ｪλ�ʤ�null, ������λ�ʤ�false)
     */
    function prepare()
    {
        return null;
    }
    /**
     *  File���������μ���
     *
     *  @access public
     *  @return string  ����̾
     */
    function perform()
    {
		header("content-type: image/jpeg");
		readfile($this->config->get('img_dir') . $this->af->get('file'));
    	exit;
    }
}
?>
