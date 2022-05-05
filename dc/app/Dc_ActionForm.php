<?php
// vim: foldmethod=marker
/**
 *  Dc_ActionForm.php
 *
 *  @author     {$author}
 *  @package    Dc
 *  @version    $Id: app.actionform.php 323 2006-08-22 15:52:26Z fujimoto $
 */

// {{{ Dc_ActionForm
/**
 *  ���������ե����९�饹
 *
 *  @author     {$author}
 *  @package    Dc
 *  @access     public
 */
class Dc_ActionForm extends Ethna_ActionForm
{
    /**#@+
     *  @access private
     */

    /** @var    array   �ե����������(�ǥե����) */
    var $form_template = array();

    /** @var    bool    �Х�ǡ����˥ץ饰�����Ȥ��ե饰 */
    var $use_validator_plugin = true;

    /**#@-*/

    /**
     *  �ե������͸��ڤΥ��顼������Ԥ�
     *
     *  @access public
     *  @param  string      $name   �ե��������̾
     *  @param  int         $code   ���顼������
     */
    function handleError($name, $code)
    {
        return parent::handleError($name, $code);
    }

    /**
     *  �ե�����������ƥ�ץ졼�Ȥ����ꤹ��
     *
     *  @access protected
     *  @param  array   $form_template  �ե������ͥƥ�ץ졼��
     *  @return array   �ե������ͥƥ�ץ졼��
     */
    function _setFormTemplate($form_template)
    {
        return parent::_setFormTemplate($form_template);
    }

    /**
     *  �ե���������������ꤹ��
     *
     *  @access protected
     */
    function _setFormDef()
    {
        return parent::_setFormDef();
    }

}
// }}}
?>
