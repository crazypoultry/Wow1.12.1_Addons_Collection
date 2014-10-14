<?php
if (!defined('EQDKP_INC')) {
    die('Do not access this file directly.');
}

class titandkp_Plugin_Class extends EQdkp_Plugin {

	// define the plugin
    function titandkp_plugin_class($pm) {
        global $eqdkp_root_path, $user, $SID;
        
        $this->eqdkp_plugin($pm);
        $this->pm->get_language_pack('titandkp');

        $this->add_data(array(
            'name'          => 'TitanDKP Plugin',
            'code'          => 'titandkp',
            'path'          => 'titandkp',
            'contact'       => 'patrick.d.wall@gmail.com',
            'template_path' => 'plugins/titandkp/templates/',
            'version'       => '0.91')
        );
        
        $this->add_menu('main_menu2', $this->gen_main_menu2());
        $this->add_menu('admin_menu', $this->gen_admin_menu());
        
        // Define installation
        define('MEMBERS_ALTS_TABLE', $table_prefix . 'eqdkp_alts');
        
       	$this->add_sql(SQL_INSTALL, "CREATE TABLE IF NOT EXISTS ".MEMBERS_ALTS_TABLE
       		." ( member_name VARCHAR(30), alt_name VARCHAR(30), PRIMARY KEY(member_name, alt_name) )");

        // Define uninstallation
       	$this->add_sql(SQL_UNINSTALL, "DROP TABLE IF EXISTS ".MEMBERS_ALTS_TABLE);
    }
    
    // generate the main menu
    function gen_main_menu2() {
        if ($this->pm->check(PLUGIN_INSTALLED, 'titandkp')) {
            global $user, $SID, $eqdkp;
            
            $main_menu2 = array(
                array(
                	'link' => 'plugins/' . $this->get_data('path') . '/dkp_dump.php' . $SID,
                	'text' => $user->lang['dump_dkp_data'], 
                	'check' => 'u_member_list'
                )
            );
            
            return $main_menu2;
        }
        return;
    }
    
    // generate the admin menu
    function gen_admin_menu() {
        if ($this->pm->check(PLUGIN_INSTALLED, 'titandkp')) {
            global $user, $SID, $eqdkp, $eqdkp_root_path;
            
            // have to set all links manually since we're under the plugins dir
			$admin_menu = array(
				'events' => array(
					0 => $user->lang['events'],
					1 => array('link' => $eqdkp->config['server_path'] . 'admin/addevent.php' 
						. $SID,   'text' => $user->lang['add'],  'check' => 'a_event_add'),
					2 => array('link' => $eqdkp->config['server_path'] . 'admin/listevents.php' 
						. $SID, 'text' => $user->lang['list'], 'check' => 'a_event_')
				),
				'groupadj' => array(
					0 => $user->lang['group_adjustments'],
					1 => array('link' => $eqdkp->config['server_path'] . 'admin/addadj.php' 
						. $SID,  'text' => $user->lang['add'],  'check' => 'a_groupadj_add'),
					2 => array('link' => $eqdkp->config['server_path'] . 'admin/listadj.php' 
						. $SID, 'text' => $user->lang['list'], 'check' => 'a_groupadj_')
				),
				'indivadj' => array(
					0 => $user->lang['individual_adjustments'],
					1 => array('link' => $eqdkp->config['server_path'] . 'admin/addiadj.php' 
						. $SID, 'text' => $user->lang['add'],  'check' => 'a_indivadj_add'),
					2 => array('link' => $eqdkp->config['server_path'] . 'admin/listadj.php' 
						. $SID . '&amp;' . URI_PAGE . '=individual', 'text' => $user->lang['list'], 
						'check' => 'a_indivadj_')
				),
				'items' => array(
					0 => $user->lang['items'],
					1 => array('link' => $eqdkp->config['server_path'] . 'admin/additem.php' 
						. $SID, 'text' => $user->lang['add'], 'check' => 'a_item_add'),
					2 => array('link' => $eqdkp->config['server_path'] . 'admin/listitems.php' 
						. $SID, 'text' => $user->lang['list'], 'check' => 'a_item_')
				),
				'mysql' => array(
					0 => $user->lang['mysql'],
					1 => array('link' => $eqdkp->config['server_path'] . 'admin/mysql_info.php' 
						. $SID, 'text' => $user->lang['mysql_info'], 'check' => '')
				),
				'news' => array(
					0 => $user->lang['news'],
					1 => array('link' => $eqdkp->config['server_path'] . 'admin/addnews.php' 
						. $SID,  'text' => $user->lang['add'],  'check' => 'a_news_add'),
					2 => array('link' => $eqdkp->config['server_path'] . 'admin/listnews.php' 
						. $SID, 'text' => $user->lang['list'], 'check' => 'a_news_')
				),
				'raids' => array(
					0 => $user->lang['raids'],
					1 => array('link' => $eqdkp->config['server_path'] . 'admin/addraid.php' 
						. $SID, 'text' => $user->lang['add'],  'check' => 'a_raid_add'),
					2 => array('link' => $eqdkp->config['server_path'] . 'plugins/' 
						. $this->get_data('path') . '/index.php' . $SID, 
						'text' => $user->lang['import_titandkp_data'], 'check' => 'a_raid_add'),
					3 => array('link' => $eqdkp->config['server_path'] . 'admin/listraids.php' 
						. $SID, 'text' => $user->lang['list'], 'check' => 'a_raid_')
				),
				'turnin' => array(
					0 => $user->lang['turn_ins'],
					1 => array('link' => $eqdkp->config['server_path'] . 'admin/addturnin.php' 
						. $SID, 'text' => $user->lang['add'], 'check' => 'a_turnin_add')
				),
				'general' => array(
					0 => $user->lang['general_admin'],
					1 => array('link' => $eqdkp->config['server_path'] . 'admin/config.php' 
						. $SID, 'text' => $user->lang['configuration'], 'check' => 'a_config_man'),
					2 => array('link' => $eqdkp->config['server_path'] . 'admin/manage_members.php' 
						. $SID, 'text' => $user->lang['manage_members'], 'check' => 'a_members_man'),
					3 => array('link' => $eqdkp->config['server_path'] . 'admin/plugins.php' 
						. $SID, 'text' => $user->lang['manage_plugins'], 'check' => 'a_plugins_man'),
					4 => array('link' => $eqdkp->config['server_path'] . 'admin/manage_users.php' 
						. $SID,   'text' => $user->lang['manage_users'],   'check' => 'a_users_man'),
					5 => array('link' => $eqdkp->config['server_path'] . 'admin/logs.php' 
						. $SID, 'text' => $user->lang['view_logs'], 'check' => 'a_logs_view')
				),
				'styles' => array(
					0 => $user->lang['styles'],
					1 => array('link' => $eqdkp->config['server_path'] . 'admin/styles.php' 
						. $SID . '&amp;mode=create', 'text' => $user->lang['create'], 
						'check' => 'a_styles_man'),
					2 => array('link' => $eqdkp->config['server_path'] . 'admin/styles.php' 
						. $SID, 'text' => $user->lang['manage'], 'check' => 'a_styles_man')
				)
			 );
            
            return $admin_menu;
        }
        return;
    }
}
?>