<?php
// vim: foldmethod=marker
/**
 *  Dc_ActionClass.php
 *
 *  @author     {$author}
 *  @package    Dc
 *  @version    $Id: app.actionclass.php 323 2006-08-22 15:52:26Z fujimoto $
 */

// {{{ Dc_ActionClass
/**
 *  action�¹ԥ��饹
 *
 *  @author     {$author}
 *  @package    Dc
 *  @access     public
 */
class Dc_ActionClass extends Ethna_ActionClass
{
    /**
     *  ���������¹�����ǧ�ڽ�����Ԥ�
     *
     *  @access public
     *  @return string  ����̾(null�ʤ����ｪλ, false�ʤ������λ)
     */
    function authenticate()
    {
        return parent::authenticate();
    }

    /**
     *  ���������¹����ν���(�ե������ͥ����å���)��Ԥ�
     *
     *  @access public
     *  @return string  ����̾(null�ʤ����ｪλ, false�ʤ������λ)
     */
    function prepare()
    {
        return parent::prepare();
    }

    /**
     *  ���������¹�
     *
     *  @access public
     *  @return string  ����̾(null�ʤ����ܤϹԤ�ʤ�)
     */
    function perform()
    {
        return parent::perform();
    }
}
// }}}
?>
