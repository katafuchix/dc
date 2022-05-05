<?php
/**
 *  {$action_name}.php
 *
 *  @author     {$author}
 *  @package    Dc
 *  @version    $Id: skel.entry_cli.php 432 2006-11-28 04:52:54Z ichii386 $
 */
chdir(dirname(__FILE__));
require_once '{$dir_app}/Dc_Controller.php';

ini_set('max_execution_time', 0);

Dc_Controller::main_CLI('Dc_Controller', '{$action_name}');
?>
