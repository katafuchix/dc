<?php
/**
 *  Output.php
 *
 *  @author     {$author}
 *  @package    Dc
 *  @version    $Id: skel.action.php 387 2006-11-06 14:31:24Z cocoitiban $
 */

/**
 *  Output�ե�����μ���
 *
 *  @author     {$author}
 *  @access     public
 *  @package    Dc
 */
class Dc_Form_Output extends Dc_ActionForm
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

		'text' => array(
			'name'		=> '����ʸ��',
			'required'	=> true,
			'type'		=> VAR_TYPE_TEXT,
			'form_type'	=> FORM_TYPE_TEXTAREA,
		),
		'image_file' => array(
			'name'		=> '����',
			//'required'	=> true,
			'type'		=> VAR_TYPE_TEXT,
			'form_type'	=> FORM_TYPE_HIDDEN,
		),
		'x' => array(
			'name'		=> '������',
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
			'name'		=> '�İ���',
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
			'name'		=> '�礭��',
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
			'name'		=> 'ʸ����',
//			'required'	=> true,
			'type'		=> VAR_TYPE_TEXT,
			'form_type'	=> FORM_TYPE_SELECT,
			'option'		=> 'Util, color',
		),
		'submit' => array(
			'name'		=> '����',
			'form_type'	=> FORM_TYPE_SUBMIT,
			'type'		=> VAR_TYPE_STRING,
		),
			
    );
}

/**
 *  Output���������μ���
 *
 *  @author     {$author}
 *  @access     public
 *  @package    Dc
 */
class Dc_Action_Output extends Dc_ActionClass
{
    /**
     *  Output����������������
     *
     *  @access public
     *  @return string      ����̾(���ｪλ�ʤ�null, ������λ�ʤ�false)
     */
    function prepare()
    {
        return null;
    }

    /**
     *  Output���������μ���
     *
     *  @access public
     *  @return string  ����̾
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
