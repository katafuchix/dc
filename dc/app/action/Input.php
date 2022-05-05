<?php
/**
 *  Input.php
 *
 *  @author     {$author}
 *  @package    Dc
 *  @version    $Id: skel.action.php 387 2006-11-06 14:31:24Z cocoitiban $
 */

/**
 *  Input�ե�����μ���
 *
 *  @author     {$author}
 *  @access     public
 *  @package    Dc
 */
class Dc_Form_Input extends Dc_ActionForm
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
			'name'		=> '����',
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
 *  Input���������μ���
 *
 *  @author     {$author}
 *  @access     public
 *  @package    Dc
 */
class Dc_Action_Input extends Dc_ActionClass
{
    /**
     *  Input����������������
     *
     *  @access public
     *  @return string      ����̾(���ｪλ�ʤ�null, ������λ�ʤ�false)
     */
    function prepare()
    {
        return null;
    }

    /**
     *  Input���������μ���
     *
     *  @access public
     *  @return string  ����̾
     */
    function perform()
    {

		//�ǥ��쥯�ȥ���Υե�������������ꡣ
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
