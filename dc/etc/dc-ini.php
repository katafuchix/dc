<?php
/*
 * dc-ini.php
 *
 * update:
 */
$config = array(
    // site
    'url' => '',
	'img_dir' => '/home/test/',
		
	'font_dir' => '/home/test/font/',
	
	'font'		=> array(
						'font' => '2009',
						'fotn' => '2010',
					),
    // debug
    // (to enable ethna_info and ethna_unittest, turn this true)
    'debug' => false,
    // db
    // sample-1: single db
    // 'dsn' => 'mysql://user:password@server/database',
    //
    // sample-2: single db w/ multiple users
    // 'dsn'   => 'mysql://rw_user:password@server/database', // read-write
    // 'dsn_r' => 'mysql://ro_user:password@server/database', // read-only
    //
    // sample-3: multiple db (slaves)
    // 'dsn'   => 'mysql://rw_user:password@master/database', // read-write(master)
    // 'dsn_r' => array(
    //     'mysql://ro_user:password@slave1/database',         // read-only(slave)
    //     'mysql://ro_user:password@slave2/database',         // read-only(slave)
    // ),

    // log
    // sample-1: sigile facility
    'log_facility'          => 'echo',
    'log_level'             => 'warning',
    'log_option'            => 'pid,function,pos',
    'log_filter_do'         => '',
    'log_filter_ignore'     => 'Undefined index.*%%.*tpl',
    // sample-2: mulitple facility
    'log' => array(
    //    'echo'  => array(
    //        'level'         => 'warning',
    //    ),
        'file'  => array(
            'level'         => 'notice',
            'file'          => '/var/www/html/dc/log/dc.log',
            'mode'          => 0666,
        ),
    //    'alertmail'  => array(
    //        'level'         => 'err',
    //        'mailaddress'   => 'alert@ml.example.jp',
    //    ),
    ),
    //'log_option'            => 'pid,function,pos',
    //'log_filter_do'         => '',
    //'log_filter_ignore'     => 'Undefined index.*%%.*tpl',

    // memcache
    // sample-1: single (or default) memcache
    // 'memcache_host' => 'localhost',
    // 'memcache_port' => 11211,
    // 'memcache_use_connect' => false,
    // 'memcache_retry' => 3,
    // 'memcache_timeout' => 3,
    //
    // sample-2: multiple memcache servers (distributing w/ namespace and ids)
    // 'memcache' => array(
    //     'namespace1' => array(
    //         0 => array(
    //             'memcache_host' => 'cache1.example.com',
    //             'memcache_port' => 11211,
    //         ),
    //         1 => array(
    //             'memcache_host' => 'cache2.example.com',
    //             'memcache_port' => 11211,
    //         ),
    //     ),
    // ),

    // csrf
    // 'csrf' => 'Session',

	// システムで使用するメールアカウント
	
	'mail_account' => array(
		// 配送エラー用メールアカウント
		'image_post' => array(
			'account' => 'alice',
			'subject' => '',
			'body' => '',
		),
	),

	// x
	'size' => array(
//		10			=> array('name' => '10'),
//		20			=> array('name' => '+20'),
		40			=> array('name' => '超小さい'),
		70			=> array('name' => '小さい'),
		80			=> array('name' => '普通'),
		100			=> array('name' => '大きめ'),
		//120			=> array('name' => '+120'),
		140			=> array('name' => '大きい'),
		//160			=> array('name' => '+160'),
		180			=> array('name' => '超大きい'),
//		200			=> array('name' => '+200'),
		240			=> array('name' => 'ギガ'),
		280			=> array('name' => 'メガ'),
//		260			=> array('name' => '+260'),
//		280			=> array('name' => '+280'),
		300			=> array('name' => 'テラ'),
	),
	'x' => array(
		0			=> array('name' => '0'),
		10			=> array('name' => '→10'),
		20			=> array('name' => '→20'),
		40			=> array('name' => '→40'),
		60			=> array('name' => '→60'),
		80			=> array('name' => '→80'),
		100			=> array('name' => '→100'),
		120			=> array('name' => '→120'),
		140			=> array('name' => '→140'),
		160			=> array('name' => '→160'),
		180			=> array('name' => '→180'),
		200			=> array('name' => '→200'),
		220			=> array('name' => '→220'),
		240			=> array('name' => '→240'),
		260			=> array('name' => '→260'),
		280			=> array('name' => '→280'),
		300			=> array('name' => '→300'),
		320			=> array('name' => '→320'),
		340			=> array('name' => '→340'),
		360			=> array('name' => '→360'),
		380			=> array('name' => '→380'),
		400			=> array('name' => '→400'),
	),
	
	// y
	'y' => array(
		10			=> array('name' => '↓10'),
		20			=> array('name' => '↓20'),
		40			=> array('name' => '↓40'),
		60			=> array('name' => '↓60'),
		80			=> array('name' => '↓80'),
		100			=> array('name' => '↓100'),
		120			=> array('name' => '↓120'),
		140			=> array('name' => '↓140'),
		160			=> array('name' => '↓160'),
		180			=> array('name' => '↓180'),
		200			=> array('name' => '↓200'),
		220			=> array('name' => '↓220'),
		240			=> array('name' => '↓240'),
		260			=> array('name' => '↓260'),
		280			=> array('name' => '↓280'),
		300			=> array('name' => '↓300'),
		320			=> array('name' => '↓320'),
		340			=> array('name' => '↓340'),
		360			=> array('name' => '↓360'),
		380			=> array('name' => '↓380'),
		400			=> array('name' => '↓400'),
	),
	
	// font
	'font' => array(
		'FS-Gothic.ttf'			=> array('name' => 'ゴシック'),
		'FS-Mincho.ttf'			=> array('name' => '明朝'),
		
		//'hgrgm1.ttf'			=> array('name' => 'ゴシック'),
		'hgrpp11.ttf'			=> array('name' => 'ポップ'),
		'hgrgy1.ttf'			=> array('name' => '行書体'),
		/*
			'hgrgm1.ttf'			=> array('name' => 'HGゴシックM'),
			'hgrpp11.ttf'			=> array('name' => 'HG創英角ポップ'),
			'hgrgy1.ttf'			=> array('name' => 'HG行書体'),
		*/
//		' YOzB04AP.ttf'		=> array('name' => '手書き文字'),// 要確認
//		'/usr/local/lib/X11/fonts/TrueType/kochi-mincho-subst.ttf'	=> array('name' => '明朝文字'),
//		'/usr/local/lib/X11/fonts/TrueType/kochi-gothic-subst.ttf'		=> array('name' => 'ゴシック文字'),
//		'/usr/local/lib/X11/fonts/TrueType/mika.ttf'			=> array('name' => '手書き文字'),
		'mofuji.ttf'			=> array('name' => 'もふ字'),// 問題なし
		'azuki.ttf'				=> array('name' => 'あずき字'),// 要確認
		'cinecaption226.ttf'		=> array('name' => 'しねきゃぷしょん'), // 事前連絡
		'HuiFont29.ttf'		=> array('name' => 'ふい字'), //ok
	//	'HuiFontP29.ttf'		=> array('name' => 'ふい字Ｐ'), //ok
		'AoyagiKouzanFont2.ttf'		=> array('name' => '青柳衡山フォント2'),// ok
		'kiloji.ttf'				=> array('name' => 'きろ字'),// 不明
	/*
		'azukiB.ttf'			=> array('name' => 'あずき字B'),// 要確認
		'azukiL.ttf'			=> array('name' => 'あずき字L'),// 要確認
		'azukiLB.ttf'			=> array('name' => 'あずき字LB'),// 要確認
		'azukiLP.ttf'			=> array('name' => 'あずき字LP'),// 要確認
	*/
		'uzura.ttf'			=> array('name' => 'うずら字'),// 要確認
		'anzu.ttf'			=> array('name' => 'あんず字'),// 要確認
		'holidaym.ttf'		=> array('name' => 'ホリデー字'),// 要確認
		'kirieji.ttf'		=> array('name' => '切絵字'),// 問題なし
//		'seap.ttf'			=> array('name' => '海字'),// 要確認
//		'moonp.ttf'			=> array('name' => '月字'),// 要確認
		'nagurip.ttf'		=> array('name' => '殴り書き字'),// 要確認
		'love.ttf'			=> array('name' => 'らぶ字'),// 要確認
		'onryou.ttf'		=> array('name' => '怨霊字'),// 問題なし
		'ArmedBanana.ttf'	=> array('name' => 'アームド・バナナ字'),// 問題なし
		'hkgyokk.ttf'		=> array('name' => '白丹行書字'),// 問題なし
//		'raffs.ttf'			=> array('name' => '居合字'),// 問題なし
//		'raffh.ttf'			=> array('name' => '居合字'),// 問題なし
		'aquap.ttf'			=> array('name' => 'アクア字'),// 問題なし
//		'hkgyoprokk.ttf'	=> array('name' => 'test'),
//		'AKCRAYON.TTF'	=> array('name' => 'test'),
/*
		'meiryo1.ttf'		=> array('name' => 'HG明瞭'),
		'meiryo2.ttf'		=> array('name' => 'HGP明瞭'),
		'hgrme1.ttf'			=> array('name' => 'HG明朝E'),
		'hgrme2.ttf'			=> array('name' => 'HGP明朝E'),
		'hgrme3.ttf'			=> array('name' => 'HGS明朝E'),
		'hgrmb1.ttf'			=> array('name' => 'HG明朝B'),
		'hgrmb2.ttf'			=> array('name' => 'HGP明朝B'),
		'hgrmb3.ttf'			=> array('name' => 'HGS明朝B'),
		'hgrge1.ttf'			=> array('name' => 'HGゴシックE'),
		'hgrge2.ttf'			=> array('name' => 'HGPゴシックE'),
		'hgrge3.ttf'			=> array('name' => 'HGSゴシックE'),
		'hgrgm1.ttf'			=> array('name' => 'HGゴシックM'),
		'hgrgm2.ttf'			=> array('name' => 'HGPゴシックM'),
		'hgrgm3.ttf'			=> array('name' => 'HGSゴシックM'),
		'hgrkk1.ttf'			=> array('name' => 'HG教科書体'),
		'hgrkk2.ttf'			=> array('name' => 'HGP教科書体'),
		'hgrkk3.ttf'			=> array('name' => 'HGS教科書体'),
		'hgrgy1.ttf'			=> array('name' => 'HG行書体'),
		'hgrgy2.ttf'			=> array('name' => 'HGP行書体'),
		'hgrgy3.ttf'			=> array('name' => 'HGS行書体'),
		'hgrpp11.ttf'			=> array('name' => 'HG創英角ポップ'),
		'hgrpp12.ttf'			=> array('name' => 'HGP創英角ポップ'),
		'hgrpp13.ttf'			=> array('name' => 'HGS創英角ポップ'),
		'hgrpre1.ttf'			=> array('name' => 'HG創英角プレゼンス'),
		'hgrpre2.ttf'			=> array('name' => 'HGP創英角プレゼンス'),
		'hgrpre3.ttf'			=> array('name' => 'HGS創英角プレゼンス'),
		'hgrsgu1.ttf'			=> array('name' => 'HG創英角ゴシックUB'),
		'hgrsgu2.ttf'			=> array('name' => 'HGP創英角ゴシックUB'),
		'hgrsgu3.ttf'			=> array('name' => 'HGS創英角ゴシックUB'),
*/
//		'AK-CookiesChocolate.TTF' => array('name' => 'test'),
//		'1' => array('name' => 'ﾃﾞｶ文字'),
//		'2' => array('name' => 'ｷﾗｷﾗ文字'),
//		'3' => array('name' => 'ﾍﾀﾚ文字'),
//		'4' => array('name' => 'ｼﾞｭｴﾙ文字'),
	),
		
	'color' => array(
		'0'			=> array('name' => 'アクア'),
		'1'			=> array('name' => 'ピンク・ブルー'),
		'2'			=> array('name' => 'ポップ・オレンジ'),
		'3'			=> array('name' => 'ポップ・ブルー'),
		'4'			=> array('name' => 'ポップ・ピンク'),
	),
);
?>
