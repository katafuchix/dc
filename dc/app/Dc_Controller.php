<?php
/**
 *  Dc_Controller.php
 *
 *  @author     {$author}
 *  @package    Dc
 *  @version    $Id: app.controller.php 470 2007-07-08 17:48:26Z ichii386 $
 */

/** ���ץꥱ�������١����ǥ��쥯�ȥ� */
define('BASE', dirname(dirname(__FILE__)));

/** include_path������(���ץꥱ�������ǥ��쥯�ȥ���ɲ�) */
$app = BASE . "/app";
$lib = BASE . "/lib";
ini_set('include_path', ini_get('include_path') . PATH_SEPARATOR . implode(PATH_SEPARATOR, array($app, $lib)));


/** ���ץꥱ�������饤�֥��Υ��󥯥롼�� */
require_once 'Ethna/Ethna.php';
require_once 'Dc_Error.php';
require_once 'Dc_ActionClass.php';
require_once 'Dc_ActionForm.php';
require_once 'Dc_ViewClass.php';

require_once 'Dc_ImageGenerator.php';
require_once 'Dc_Mail.php';
require_once 'Dc_UtilManager.php';

/**
 *  Dc���ץꥱ�������Υ���ȥ������
 *
 *  @author     {$author}
 *  @access     public
 *  @package    Dc
 */
class Dc_Controller extends Ethna_Controller
{
    /**#@+
     *  @access private
     */

    /**
     *  @var    string  ���ץꥱ�������ID
     */
    var $appid = 'DC';

    /**
     *  @var    array   forward���
     */
    var $forward = array(
        /*
         *  TODO: ������forward��򵭽Ҥ��Ƥ�������
         *
         *  �����㡧
         *
         *  'index'         => array(
         *      'view_name' => 'Dc_View_Index',
         *  ),
         */
    );

    /**
     *  @var    array   action���
     */
    var $action = array(
        /*
         *  TODO: ������action����򵭽Ҥ��Ƥ�������
         *
         *  �����㡧
         *
         *  'index'     => array(),
         */
    );

    /**
     *  @var    array   soap action���
     */
    var $soap_action = array(
        /*
         *  TODO: ������SOAP���ץꥱ��������Ѥ�action�����
         *  ���Ҥ��Ƥ�������
         *  �����㡧
         *
         *  'sample'            => array(),
         */
    );

    /**
     *  @var    array       ���ץꥱ�������ǥ��쥯�ȥ�
     */
    var $directory = array(
        'action'        => 'app/action',
        'action_cli'    => 'app/action_cli',
        'action_xmlrpc' => 'app/action_xmlrpc',
        'app'           => 'app',
        'plugin'        => 'app/plugin',
        'bin'           => 'bin',
        'etc'           => 'etc',
        'filter'        => 'app/filter',
        'locale'        => 'locale',
        'log'           => 'log',
        'plugins'       => array(),
        'template'      => 'template',
        'template_c'    => 'tmp',
        'tmp'           => 'tmp',
        'view'          => 'app/view',
        'www'           => 'www',
    );

    /**
     *  @var    array       DB�����������
     */
    var $db = array(
        ''              => DB_TYPE_RW,
    );

    /**
     *  @var    array       ��ĥ������
     */
    var $ext = array(
        'php'           => 'php',
        'tpl'           => 'tpl',
    );

    /**
     *  @var    array   ���饹���
     */
    var $class = array(
        /*
         *  TODO: ���ꥯ�饹�������饹��SQL���饹�򥪡��С��饤��
         *  �������ϲ����Υ��饹̾��˺�줺���ѹ����Ƥ�������
         */
        'class'         => 'Ethna_ClassFactory',
        'backend'       => 'Ethna_Backend',
        'config'        => 'Ethna_Config',
        'db'            => 'Ethna_DB_PEAR',
        'error'         => 'Ethna_ActionError',
        'form'          => 'Dc_ActionForm',
        'i18n'          => 'Ethna_I18N',
        'logger'        => 'Ethna_Logger',
        'plugin'        => 'Ethna_Plugin',
        'session'       => 'Ethna_Session',
        'sql'           => 'Ethna_AppSQL',
        'view'          => 'Dc_ViewClass',
        'renderer'      => 'Ethna_Renderer_Smarty',
        'url_handler'   => 'Dc_UrlHandler',
    );

    /**
     *  @var    array       �����оݤȤʤ�ץ饰����Υ��ץꥱ�������ID�Υꥹ��
     */
    var $plugin_search_appids = array(
        /*
         *  �ץ饰���󸡺����˸����оݤȤʤ륢�ץꥱ�������ID�Υꥹ�Ȥ򵭽Ҥ��ޤ���
         *
         *  �����㡧
         *  Common_Plugin_Foo_Bar �Τ褦��̿̾�Υץ饰���󤬥��ץꥱ��������
         *  �ץ饰����ǥ��쥯�ȥ��¸�ߤ����硢�ʲ��Τ褦�˻��ꤹ���
         *  Common_Plugin_Foo_Bar, Dc_Plugin_Foo_Bar, Ethna_Plugin_Foo_Bar
         *  �ν�˥ץ饰���󤬸�������ޤ��� 
         *
         *  'Common', 'Dc', 'Ethna',
         */
        'Dc', 'Ethna',
    );

    /**
     *  @var    array       �ե��륿����
     */
    var $filter = array(
        /*
         *  TODO: �ե��륿�����Ѥ�����Ϥ����ˤ��Υץ饰����̾��
         *  ���Ҥ��Ƥ�������
         *  (���饹̾����ꤹ���filter�ǥ��쥯�ȥ꤫��ե��륿���饹
         *  ���ɤ߹��ߤޤ�)
         *
         *  �����㡧
         *
         *  'ExecutionTime',
         */
    );

    /**
     *  @var    array   smarty modifier���
     */
    var $smarty_modifier_plugin = array(
        /*
         *  TODO: �����˥桼�������smarty modifier�����򵭽Ҥ��Ƥ�������
         *
         *  �����㡧
         *
         *  'smarty_modifier_foo_bar',
         */
    );

    /**
     *  @var    array   smarty function���
     */
    var $smarty_function_plugin = array(
        /*
         *  TODO: �����˥桼�������smarty function�����򵭽Ҥ��Ƥ�������
         *
         *  �����㡧
         *
         *  'smarty_function_foo_bar',
         */
    );

    /**
     *  @var    array   smarty block���
     */
    var $smarty_block_plugin = array(
        /*
         *  TODO: �����˥桼�������smarty block�����򵭽Ҥ��Ƥ�������
         *
         *  �����㡧
         *
         *  'smarty_block_foo_bar',
         */
    );

    /**
     *  @var    array   smarty prefilter���
     */
    var $smarty_prefilter_plugin = array(
        /*
         *  TODO: �����˥桼�������smarty prefilter�����򵭽Ҥ��Ƥ�������
         *
         *  �����㡧
         *
         *  'smarty_prefilter_foo_bar',
         */
    );

    /**
     *  @var    array   smarty postfilter���
     */
    var $smarty_postfilter_plugin = array(
        /*
         *  TODO: �����˥桼�������smarty postfilter�����򵭽Ҥ��Ƥ�������
         *
         *  �����㡧
         *
         *  'smarty_postfilter_foo_bar',
         */
    );

    /**
     *  @var    array   smarty outputfilter���
     */
    var $smarty_outputfilter_plugin = array(
        /*
         *  TODO: �����˥桼�������smarty outputfilter�����򵭽Ҥ��Ƥ�������
         *
         *  �����㡧
         *
         *  'smarty_outputfilter_foo_bar',
         */
    );

    /**#@-*/
}
?>
