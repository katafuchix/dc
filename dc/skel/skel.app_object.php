<?php
/**
 *  {$app_path}
 *
 *  @author     {$author}
 *  @package    Dc
 *  @version    $Id: skel.app_object.php 387 2006-11-06 14:31:24Z cocoitiban $
 */

/**
 *  {$app_object}Manager
 *
 *  @author     {$author}
 *  @access     public
 *  @package    Dc
 */
class {$app_object}Manager extends Ethna_AppManager
{
}

/**
 *  {$app_object}
 *
 *  @author     {$author}
 *  @access     public
 *  @package    Dc
 */
class {$app_object} extends Ethna_AppObject
{
    /**
     *  �ץ�ѥƥ���ɽ��̾���������
     *
     *  @access public
     */
    function getName($key)
    {
        return $this->get($key);
    }
}
?>
