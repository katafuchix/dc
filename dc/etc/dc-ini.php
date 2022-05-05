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

	// �����ƥ�ǻ��Ѥ���᡼�륢�������
	
	'mail_account' => array(
		// �������顼�ѥ᡼�륢�������
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
		40			=> array('name' => 'Ķ������'),
		70			=> array('name' => '������'),
		80			=> array('name' => '����'),
		100			=> array('name' => '�礭��'),
		//120			=> array('name' => '+120'),
		140			=> array('name' => '�礭��'),
		//160			=> array('name' => '+160'),
		180			=> array('name' => 'Ķ�礭��'),
//		200			=> array('name' => '+200'),
		240			=> array('name' => '����'),
		280			=> array('name' => '�ᥬ'),
//		260			=> array('name' => '+260'),
//		280			=> array('name' => '+280'),
		300			=> array('name' => '�ƥ�'),
	),
	'x' => array(
		0			=> array('name' => '0'),
		10			=> array('name' => '��10'),
		20			=> array('name' => '��20'),
		40			=> array('name' => '��40'),
		60			=> array('name' => '��60'),
		80			=> array('name' => '��80'),
		100			=> array('name' => '��100'),
		120			=> array('name' => '��120'),
		140			=> array('name' => '��140'),
		160			=> array('name' => '��160'),
		180			=> array('name' => '��180'),
		200			=> array('name' => '��200'),
		220			=> array('name' => '��220'),
		240			=> array('name' => '��240'),
		260			=> array('name' => '��260'),
		280			=> array('name' => '��280'),
		300			=> array('name' => '��300'),
		320			=> array('name' => '��320'),
		340			=> array('name' => '��340'),
		360			=> array('name' => '��360'),
		380			=> array('name' => '��380'),
		400			=> array('name' => '��400'),
	),
	
	// y
	'y' => array(
		10			=> array('name' => '��10'),
		20			=> array('name' => '��20'),
		40			=> array('name' => '��40'),
		60			=> array('name' => '��60'),
		80			=> array('name' => '��80'),
		100			=> array('name' => '��100'),
		120			=> array('name' => '��120'),
		140			=> array('name' => '��140'),
		160			=> array('name' => '��160'),
		180			=> array('name' => '��180'),
		200			=> array('name' => '��200'),
		220			=> array('name' => '��220'),
		240			=> array('name' => '��240'),
		260			=> array('name' => '��260'),
		280			=> array('name' => '��280'),
		300			=> array('name' => '��300'),
		320			=> array('name' => '��320'),
		340			=> array('name' => '��340'),
		360			=> array('name' => '��360'),
		380			=> array('name' => '��380'),
		400			=> array('name' => '��400'),
	),
	
	// font
	'font' => array(
		'FS-Gothic.ttf'			=> array('name' => '�����å�'),
		'FS-Mincho.ttf'			=> array('name' => '��ī'),
		
		//'hgrgm1.ttf'			=> array('name' => '�����å�'),
		'hgrpp11.ttf'			=> array('name' => '�ݥå�'),
		'hgrgy1.ttf'			=> array('name' => '�Խ���'),
		/*
			'hgrgm1.ttf'			=> array('name' => 'HG�����å�M'),
			'hgrpp11.ttf'			=> array('name' => 'HG�ϱѳѥݥå�'),
			'hgrgy1.ttf'			=> array('name' => 'HG�Խ���'),
		*/
//		' YOzB04AP.ttf'		=> array('name' => '���ʸ��'),// �׳�ǧ
//		'/usr/local/lib/X11/fonts/TrueType/kochi-mincho-subst.ttf'	=> array('name' => '��īʸ��'),
//		'/usr/local/lib/X11/fonts/TrueType/kochi-gothic-subst.ttf'		=> array('name' => '�����å�ʸ��'),
//		'/usr/local/lib/X11/fonts/TrueType/mika.ttf'			=> array('name' => '���ʸ��'),
		'mofuji.ttf'			=> array('name' => '��ջ�'),// ����ʤ�
		'azuki.ttf'				=> array('name' => '��������'),// �׳�ǧ
		'cinecaption226.ttf'		=> array('name' => '���ͤ���פ����'), // ����Ϣ��
		'HuiFont29.ttf'		=> array('name' => '�դ���'), //ok
	//	'HuiFontP29.ttf'		=> array('name' => '�դ�����'), //ok
		'AoyagiKouzanFont2.ttf'		=> array('name' => '�����ջ��ե����2'),// ok
		'kiloji.ttf'				=> array('name' => '�����'),// ����
	/*
		'azukiB.ttf'			=> array('name' => '��������B'),// �׳�ǧ
		'azukiL.ttf'			=> array('name' => '��������L'),// �׳�ǧ
		'azukiLB.ttf'			=> array('name' => '��������LB'),// �׳�ǧ
		'azukiLP.ttf'			=> array('name' => '��������LP'),// �׳�ǧ
	*/
		'uzura.ttf'			=> array('name' => '�������'),// �׳�ǧ
		'anzu.ttf'			=> array('name' => '���󤺻�'),// �׳�ǧ
		'holidaym.ttf'		=> array('name' => '�ۥ�ǡ���'),// �׳�ǧ
		'kirieji.ttf'		=> array('name' => '�ڳ���'),// ����ʤ�
//		'seap.ttf'			=> array('name' => '����'),// �׳�ǧ
//		'moonp.ttf'			=> array('name' => '���'),// �׳�ǧ
		'nagurip.ttf'		=> array('name' => '����񤭻�'),// �׳�ǧ
		'love.ttf'			=> array('name' => '��ֻ�'),// �׳�ǧ
		'onryou.ttf'		=> array('name' => '�����'),// ����ʤ�
		'ArmedBanana.ttf'	=> array('name' => '������ɡ��Хʥʻ�'),// ����ʤ�
		'hkgyokk.ttf'		=> array('name' => '��ð�Խ��'),// ����ʤ�
//		'raffs.ttf'			=> array('name' => '����'),// ����ʤ�
//		'raffh.ttf'			=> array('name' => '����'),// ����ʤ�
		'aquap.ttf'			=> array('name' => '��������'),// ����ʤ�
//		'hkgyoprokk.ttf'	=> array('name' => 'test'),
//		'AKCRAYON.TTF'	=> array('name' => 'test'),
/*
		'meiryo1.ttf'		=> array('name' => 'HG����'),
		'meiryo2.ttf'		=> array('name' => 'HGP����'),
		'hgrme1.ttf'			=> array('name' => 'HG��īE'),
		'hgrme2.ttf'			=> array('name' => 'HGP��īE'),
		'hgrme3.ttf'			=> array('name' => 'HGS��īE'),
		'hgrmb1.ttf'			=> array('name' => 'HG��īB'),
		'hgrmb2.ttf'			=> array('name' => 'HGP��īB'),
		'hgrmb3.ttf'			=> array('name' => 'HGS��īB'),
		'hgrge1.ttf'			=> array('name' => 'HG�����å�E'),
		'hgrge2.ttf'			=> array('name' => 'HGP�����å�E'),
		'hgrge3.ttf'			=> array('name' => 'HGS�����å�E'),
		'hgrgm1.ttf'			=> array('name' => 'HG�����å�M'),
		'hgrgm2.ttf'			=> array('name' => 'HGP�����å�M'),
		'hgrgm3.ttf'			=> array('name' => 'HGS�����å�M'),
		'hgrkk1.ttf'			=> array('name' => 'HG���ʽ���'),
		'hgrkk2.ttf'			=> array('name' => 'HGP���ʽ���'),
		'hgrkk3.ttf'			=> array('name' => 'HGS���ʽ���'),
		'hgrgy1.ttf'			=> array('name' => 'HG�Խ���'),
		'hgrgy2.ttf'			=> array('name' => 'HGP�Խ���'),
		'hgrgy3.ttf'			=> array('name' => 'HGS�Խ���'),
		'hgrpp11.ttf'			=> array('name' => 'HG�ϱѳѥݥå�'),
		'hgrpp12.ttf'			=> array('name' => 'HGP�ϱѳѥݥå�'),
		'hgrpp13.ttf'			=> array('name' => 'HGS�ϱѳѥݥå�'),
		'hgrpre1.ttf'			=> array('name' => 'HG�ϱѳѥץ쥼��'),
		'hgrpre2.ttf'			=> array('name' => 'HGP�ϱѳѥץ쥼��'),
		'hgrpre3.ttf'			=> array('name' => 'HGS�ϱѳѥץ쥼��'),
		'hgrsgu1.ttf'			=> array('name' => 'HG�ϱѳѥ����å�UB'),
		'hgrsgu2.ttf'			=> array('name' => 'HGP�ϱѳѥ����å�UB'),
		'hgrsgu3.ttf'			=> array('name' => 'HGS�ϱѳѥ����å�UB'),
*/
//		'AK-CookiesChocolate.TTF' => array('name' => 'test'),
//		'1' => array('name' => '�Îގ�ʸ��'),
//		'2' => array('name' => '���׎���ʸ��'),
//		'3' => array('name' => '�͎���ʸ��'),
//		'4' => array('name' => '���ގ�����ʸ��'),
	),
		
	'color' => array(
		'0'			=> array('name' => '������'),
		'1'			=> array('name' => '�ԥ󥯡��֥롼'),
		'2'			=> array('name' => '�ݥåס������'),
		'3'			=> array('name' => '�ݥåס��֥롼'),
		'4'			=> array('name' => '�ݥåס��ԥ�'),
	),
);
?>
