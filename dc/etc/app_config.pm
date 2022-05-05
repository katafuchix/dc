package app_config;
use strict;

my %AI;

$AI{'SITE_DOMAIN'} 	= '';
$AI{'DB_HOST'} 		= 'localhost';
$AI{'DB_NAME'} 		= 'yourvideo';
$AI{'DB_USER'} 		= 'root';
$AI{'DB_PW'} 		= 'mysql';
$AI{'INFO_MAIL'} 	= '';
$AI{'SITE_MAIL'} 	= '';
$AI{'SEND_MAIL'} 	= '';
$AI{'MAIL_SVR'} 	= '';
$AI{'GLOBAL_IP'} 	= '';
$AI{'COOKIE_ID'} 	= '';
$AI{'IMG_DIR'}		= '/home/test/';
$AI{'FONT_DIR'}		= '/home/test/font/';

					  #'アクア','ピンク・ブルー','ポップ・オレンジ','ポップ・ブルー','ポップ・ピンク',
$AI{'COLOR'}		= '#ffffff-#00BFFF,#FF00FF-#00BFFF,#FFFFFF-#FF8C00,#FFFFFF-#0000FF,#FFFFFF-#FF00FF';

$AI{'DSN'}		= 'DBI:mysql:' . $AI{'DB_NAME'} . ':' . $AI{'DB_HOST'};

$AI{'MAILER'} 		= '/usr/lib/sendmail';


sub config {
    my %Config = @_;
    $Config{$_} = $AI{$_} for (keys %AI);
    return %Config;
}


1;
