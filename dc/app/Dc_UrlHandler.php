<?php
/**
 *  Dc_UrlHandler.php
 *
 *  @author     {$author}
 *  @package    Dc
 *  @version    $Id: app.url_handler.php 470 2007-07-08 17:48:26Z ichii386 $
 */

/**
 *  URL�ϥ�ɥ饯�饹
 *
 *  @author     {$author}
 *  @access     public
 *  @package    Dc
 */
class Dc_UrlHandler extends Ethna_UrlHandler
{
    /** @var    array   ���������ޥåԥ� */
    var $action_map = array(
        /*
        'user'  => array(
            'user_login' => array(
                'path'          => 'login',
                'path_regexp'   => false,
                'path_ext'      => false,
                'option'        => array(),
            ),
        ),
         */
    );

    /**
     *  Dc_UrlHandler���饹�Υ��󥹥��󥹤��������
     *
     *  @access public
     */
    function &getInstance($class_name = null)
    {
        $instance =& parent::getInstance(__CLASS__);
        return $instance;
    }

    // {{{ �����ȥ������ꥯ������������
    /**
     *  �ꥯ������������(user�����ȥ�����)
     *
     *  @access private
     */
    /*
    function _normalizeRequest_User($http_vars)
    {
        return $http_vars;
    }
     */
    // }}}

    // {{{ �����ȥ������ѥ�����
    /**
     *  �ѥ�����(user�����ȥ�����)
     *
     *  @access private
     */
    /*
    function _getPath_User($action, $param)
    {
        return array("/user", array());
    }
     */
    // }}}

    // {{{ �ե��륿
    // }}}
}

// vim: foldmethod=marker tabstop=4 shiftwidth=4 autoindent
?>
