<?php
/**
 *  {$view_path}
 *
 *  @author     {$author}
 *  @package    Dc
 *  @version    $Id: skel.view_test.php 209 2006-03-23 13:16:37Z fujimoto $
 */

/**
 *  {$forward_name}�ӥ塼�μ���
 *
 *  @author     {$author}
 *  @access     public
 *  @package    Dc
 */
class {$view_class}_TestCase extends Ethna_UnitTestCase
{
    /**
     *  @access private
     *  @var    string  �ӥ塼̾
     */
    var $forward_name = '{$forward_name}';

    /**
     *    �ƥ��Ȥν����
     *
     *    @access public
     */
    function setUp()
    {
        $this->createPlainActionForm(); // ���������ե�����κ���
        $this->createViewClass();       // �ӥ塼�κ���
    }

    /**
     *    �ƥ��Ȥθ����
     *
     *    @access public
     */
    function tearDown()
    {
    }

    /**
     *  {$forward_name}�����������Υ���ץ�ƥ��ȥ�����
     *
     *  @access public
     */
    /*
    function test_viewSample()
    {
        // �ե����������
        $this->af->set('id', 1);

        // {$forward_name}����������
        $this->vc->preforward();
        $this->assertNull($this->af->get('data'));
    }
    */
}
?>
