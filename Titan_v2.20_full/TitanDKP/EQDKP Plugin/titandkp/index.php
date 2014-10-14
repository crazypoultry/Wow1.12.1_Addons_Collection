<?php

// EQdkp required files/vars
define('EQDKP_INC', true);
define('IN_ADMIN', true);
define('PLUGIN', 'titandkp');

// set the paths
$eqdkp->config['server_path'] = $eqdkp->config['server_path'] . '../../';
$eqdkp_root_path = $eqdkp->config['server_path'];

include_once($eqdkp_root_path . 'common.php');

$titandkp = $pm->get_plugin('titandkp');

if (!$pm->check(PLUGIN_INSTALLED, 'titandkp')) {
    message_die('The TitanDKP plugin is not installed.');
}

if (!function_exists('htmlspecialchars_decode')) {
   function htmlspecialchars_decode($text){
       return strtr($text, array_flip(get_html_translation_table(HTML_SPECIALCHARS)));
   }
}

class TITANDKP_Import extends EQdkp_Admin {
	// called when import is processed
    function titandkp_Import() {
        global $db, $eqdkp, $user, $tpl, $pm;
        global $SID;
        
        parent::eqdkp_admin();
        
        // show correct form
        $this->assoc_buttons(array(
            'start' => array(
                'name'    => 'start',
                'process' => 'displayForm2',
                'check'   => 'a_raid_add'
             ),
            'form' => array(
                'name'    => '',
                'process' => 'displayForm1',
                'check'   => 'a_raid_add'
            ),
            'chooseraid' => array(
                'name'    => 'chooseraid',
                'process' => 'displayForm3',
                'check'   => 'a_raid_add'
            ),
            'finish' => array(
                'name'    => 'finish',
                'process' => 'displayForm4',
                'check'   => 'a_raid_add'
            )
        ));
    }
	
	// displays first page, select and upload lua
	function displayForm1() {
        global $tpl, $SID, $user, $eqdkp, $pm;
        
        // set template variables
        $tpl->assign_vars(array(
            'F_FORM_ACTION'	=> 'index.php' . $SID,
            'S_STEP1'			=> true,
            'S_STEP2'			=> false,
            'S_STEP3'			=> false,
            'S_STEP4'			=> false,
            'L_FORM_HEADING'	=> $user->lang['titandkp_step1_th'],
            'L_FORM_SUBMIT'		=> $user->lang['titandkp_step1_button'],
        ));
        
        $eqdkp->set_vars(array(
            'page_title'		=> sprintf($user->lang['admin_title_prefix'], 
				$eqdkp->config['guildtag'], $eqdkp->config['dkp_name']).': '
				.$user->lang['titandkp_step1_pagetitle'],
            'template_path'		=> $pm->get_data('titandkp', 'template_path'),
            'template_file'     => 'titandkp.html',
            'display'           => true,
		));
	}
	
	// displays second page, select raid
	function displayForm2() {
        global $tpl, $SID, $user, $eqdkp, $pm;
       
		// parse the file
        $data = $this->parseLua();
     
        // set template variables   
        $tpl->assign_vars(array(
            'F_FORM_ACTION'	=> 'index.php' . $SID,
            'S_STEP1'			=> false,
            'S_STEP2'			=> true,
            'S_STEP3'			=> false,
            'S_STEP4'			=> false,
            'L_FORM_HEADING'	=> $user->lang['titandkp_step2_th'],
            'L_FORM_SUBMIT'		=> $user->lang['titandkp_step2_button'],
            'DATA'				=> "\$data = " . $this->array2string($data, 1) . ";",
        ));
		
        foreach ($data as $tinstance => $vars1) {
			$etinstance = preg_replace("/\W+/", "_", $tinstance);
        	$tpl->assign_block_vars('instance_row', array(
				'EINSTANCE' => $etinstance,
				'INSTANCE' => $tinstance,
			));
        	
			foreach ($vars1 as $tdate => $vars2) {
				$tpl->assign_block_vars('date_row', array(
					'EINSTANCE' => $etinstance, 
					'DATE' => $tdate,
				));
			}
        }
        
        $eqdkp->set_vars(array(
            'page_title'        => sprintf($user->lang['admin_title_prefix'], 
            	$eqdkp->config['guildtag'], $eqdkp->config['dkp_name']).': '
            	.$user->lang['titandkp_step2_pagetitle'],
            'template_path'		=> $pm->get_data('titandkp', 'template_path'),
            'template_file'     => 'titandkp.html',
            'display'           => true,
		));
	}
	
	// displays third page, confirm changes
	function displayForm3() {
		global $tpl, $SID, $user, $eqdkp, $pm;
        
        // import data
        $instance = $_POST['instancelist'];
        $date = $_POST['datelist'];
		$date = preg_replace("/\W+/", "_", $date);
		eval(htmlspecialchars_decode(stripslashes($_POST['data'])));
        
        if ($date == null or $instance == null) {
			message_die($user->lang['titandkp_step3_badchoice'], $user->lang['titandkp_step3_title']);
        }
        
        if ($data == null or $data[$instance][$date]['players'] == null) {
			message_die($user->lang['titandkp_step3_badglobal'], $user->lang['titandkp_step3_title']);
        }
        
        // set template variables
		$tpl->assign_vars(array(
            'F_FORM_ACTION'	=> 'index.php' . $SID,
            'S_STEP1'			=> false,
            'S_STEP2'			=> false,
            'S_STEP3'			=> true,
            'S_STEP4'			=> false,
            'L_NAME_HEADING'	=> $user->lang['titandkp_step3_name'],
            'L_ITEM_HEADING'	=> $user->lang['titandkp_step3_item'],
            'L_POINT_HEADING'	=> $user->lang['titandkp_step3_point'],
            'L_FORM_HEADING'	=> $user->lang['titandkp_step3_th'],
            'L_FORM_SUBMIT'		=> $user->lang['titandkp_step3_button'],
            'DATA'				=> "\$data = " . $this->array2string($data, 1) . ";",
            'DATE'				=> $date,
            'INSTANCE'			=> $instance,
        ));
        
        foreach ($data[$instance][$date]['players'] as $player => $vars) {
        	$tpl->assign_block_vars('character_row', array(
        		'CHARACTER' => $player,
        		'DKP' 		=> preg_replace("/_/", "-", $vars['dkp']),
        		'EXISTS'	=> $this->CheckMember($player),
        	));
        	
			foreach ($data[$instance][$date]['items'] as $item => $vars2) {
				foreach ($vars2 as $iplayer => $vars3) {
					if ($iplayer == $player and $vars3['count'] > 1) {
						$tpl->assign_block_vars('character_row.item_row', array(
							'ITEM' 		=> $item,
							'DKP' 		=> preg_replace("/_/", "-", $vars3['dkp']),
							'COUNT' 	=> "(" . $vars3['count'] . ")",
						));
					}
					else if ($iplayer == $player) {
						$tpl->assign_block_vars('character_row.item_row', array(
							'ITEM' 		=> $item,
							'DKP' 		=> preg_replace("/_/", "-", $vars3['dkp']),
							'COUNT' 	=> "",
						));
					}
				}
			}
        }
        
        $eqdkp->set_vars(array(
            'page_title'        => sprintf($user->lang['admin_title_prefix'], 
            	$eqdkp->config['guildtag'], $eqdkp->config['dkp_name']).': '
            	.$user->lang['titandkp_step3_pagetitle'],
            'template_path'		=> $pm->get_data('titandkp', 'template_path'),
            'template_file'     => 'titandkp.html',
            'display'           => true,
		));
	}
	
	// displays fourth page, show upload success/failure
	function displayForm4() {
        global $tpl, $SID, $user, $eqdkp, $pm;
        
        // import data
        $date = $_POST['date'];
        $instance = $_POST['instance'];
        eval(stripslashes(htmlspecialchars_decode($_POST['data'])));

        if ($date == null or $instance == null) {
			message_die($user->lang['titandkp_step3_badchoice'], $user->lang['titandkp_step4_pagetitle']);
        }
        
        if ($data == null or $data[$instance][$date]['players'] == null) {
			message_die($user->lang['titandkp_step3_badglobal'], $user->lang['titandkp_step4_pagetitle']);
        }
                
        // remove unwanted items
		foreach ($data[$instance][$date]['items'] as $item => $vars) {
			foreach ($vars as $player => $vars2) {
				if ($_POST[$item."_".$player] !== "true") {
					$data[$instance][$date]['players'][$player]['dkp'] = 
						preg_replace("/_/", "-", $data[$instance][$date]['players'][$player]['dkp']) 
						- preg_replace("/_/", "-", $vars2['dkp']);
					$data[$instance][$date]['items'][$item][$player] = null;
				}
				$data[$instance][$date]['players'][$player]['dkp'] = 
					preg_replace("/_/", "-", $data[$instance][$date]['players'][$player]['dkp']);
			}
		}
        
        // remove unwanted characters
        foreach ($data[$instance][$date]['players'] as $player => $vars) {
        	if ($_POST[$player] !== "true") {
        		$data[$instance][$date]['players'][$player] = null;
        	}
        }

        // upload data
        $text = $this->uploadData($data, $instance, $date);
        
        // set template variables
        $tpl->assign_vars(array(
            'F_FORM_ACTION'	=> 'index.php' . $SID,
            'S_STEP1'			=> false,
            'S_STEP2'			=> false,
            'S_STEP3'			=> false,
            'S_STEP4'			=> true,
            'L_FORM_HEADING'	=> $text,
        ));
        
        $eqdkp->set_vars(array(
            'page_title'        => sprintf($user->lang['admin_title_prefix'], 
            	$eqdkp->config['guildtag'], $eqdkp->config['dkp_name']).': '
            	.$user->lang['titandkp_step4_pagetitle'],
            'template_path'		=> $pm->get_data('titandkp', 'template_path'),
            'template_file'     => 'titandkp.html',
            'display'           => true,
		));
	}
    
	// parse lua file
	function parseLua() {
		// global variables
		global $user;
	
		// read the file
		if (!empty($_FILES['titandkp']) && is_uploaded_file($_FILES['titandkp']['tmp_name'])) {
			if (filesize($_FILES['titandkp']['tmp_name']) > 2000000) {
				message_die($user->lang['titandkp_step1_filesize_msg'], $user->lang['titandkp_step1_file_title']);
			}
			else if (!empty($_FILES['titandkp']['error'])) {
				message_die($_FILES['titandkp']['error'], $user->lang['titandkp_step1_file_title']);
			}
		}
		
		// parse the file
		$data = trim(file_get_contents($_FILES['titandkp']['tmp_name']));
		
        $record = false;
        $newdata = "";
        $tok = strtok($data, "\r\n");
        while ($tok !== false) {
            if ($tok == "TITANDKPRaid = {") {
                $record = true;
            }
            else if (strpos($tok, 'EOF') !== false) {
                $record = false;
            }
            
            if ($record == true) {
                $newdata .= $tok;
                $newdata .= "\r\n";
            }
            $tok = strtok("\r\n");
        }
        
        $data = $newdata;
        $data = preg_replace('@[)(><]+@', '', $data);
    
        // format data as a variable
        $data = preg_replace('@\s\[(.*?)\]\s@', ' \1 ', $data);
        $data = str_replace('=', '=>', $data);
        $data = preg_replace('@\{@', 'array(', $data);
        $data = preg_replace('@\}@', ')', $data);
        $data = preg_replace('@=>@', '=', $data, 1);
        $data = '$'.$data.';';
        
        if (empty($data)) {
			message_die($user->lang['titandkp_step1_error_msg'], $user->lang['titandkp_step1_file_title']);
		}
		
        eval($data);
        
        if (empty($TITANDKPRaid)) {
			message_die($user->lang['titandkp_step1_error_msg'], $user->lang['titandkp_step1_file_title']);
        }
        
        return $TITANDKPRaid;
	}
	
	// upload data
	function uploadData($data, $instance, $date) {
		// global variables
        global $db, $user;
        $eventpoints = 0;

		//get new event id
		$neweventid = $db->query("SELECT MAX(`event_id`) as id FROM ".EVENTS_TABLE.";");
		$neweventid = $db->fetch_record($neweventid);
		$neweventid = $neweventid['id'] + 1;

		//get new raid id
		$newraidid = $db->query("SELECT MAX(`raid_id`) as id FROM ".RAIDS_TABLE.";");
		$newraidid = $db->fetch_record($newraidid);
		$newraidid = $newraidid['id'] + 1;
		
		// check if event exists
		$eventexistscheck = $db->query("SELECT `event_name` `event_value` FROM ".EVENTS_TABLE.
			" WHERE event_name = '".mysql_escape_string(preg_replace("/_/", " ", $instance))
			."' LIMIT 1");
		
		// add event
		if ($db->num_rows($eventexistscheck) !== 1) {
			$db->query("INSERT INTO ".EVENTS_TABLE." (`event_id`, `event_name`, `event_value`, `event_added_by`, `event_updated_by`) VALUES ('"
				.mysql_escape_string($neweventid)."', '".mysql_escape_string(preg_replace("/_/", " ", $instance))
				."', '0', 'DKPUpload (by ".mysql_escape_string($user->data['username'])
				.")', 'DKPUpload (by ".mysql_escape_string($user->data['username']).")');");
		}
		else {
			$eventvalues = $db->fetch_record($eventexistscheck);
			$eventpoints = $eventvalues['event_value'];
		}
			
		if (!empty($data[$instance][$date])) {
			// create raid
			$db->query("INSERT INTO ".RAIDS_TABLE." (`raid_id`, `raid_name`, `raid_date`, `raid_added_by`) VALUES ('"
				.mysql_escape_string($newraidid)."', '".mysql_escape_string(preg_replace("/_/", " ", $instance))."', '"
				.mysql_escape_string($this->ConvertTimestringToTimestamp($date))."', 'DKPUpload (by ".mysql_escape_string($user->data['username'])
				.")');");
			$text .= sprintf($user->lang['titandkp_step4_newraid'], preg_replace("/_/", " ", $instance), preg_replace("/_/", "/", $date))."<br>\n";
			
			// insert players
			foreach ($data[$instance][$date]["players"] as $player => $playervars) {
				if ($playervars !== null) {
					$memberexistscheck = $db->query("SELECT `member_lastraid` FROM ".MEMBERS_TABLE
						." WHERE `member_name` = '".mysql_escape_string($player)."' LIMIT 1;");
					if($db->num_rows($memberexistscheck) == 0) {
						// create player if not present
						$db->query("INSERT INTO ".MEMBERS_TABLE." (`member_name`, `member_status`, `member_firstraid`, `member_class_id`) VALUES ('"
							.mysql_escape_string($player)."', '1', '".mysql_escape_string($this->ConvertTimestringToTimestamp($date))
							."', '".mysql_escape_string($this->GetClassID($playervars['class']))."');");
						$memberexistscheck = $db->query("SELECT `member_lastraid` FROM ".MEMBERS_TABLE
							." WHERE `member_name` = '".mysql_escape_string($player)."' LIMIT 1;");
						$text .= sprintf($user->lang['titandkp_step4_newplayer'], $player)."<br>\n";
					}
					// update player
					$db->query("INSERT INTO ".RAID_ATTENDEES_TABLE." (`raid_id`, `member_name`) VALUES ('"
						.mysql_escape_string($newraidid)."', '".mysql_escape_string($player)."');");
					
					// check last raid date, and don't update last raid if not more recent
					$lastraidrow = $db->fetch_record($memberexistscheck);
					if ($lastraidrow['member_lastraid'] < $this->ConvertTimestringToTimestamp($date)) {
						$db->query("UPDATE ".MEMBERS_TABLE." SET member_earned = member_earned + "
							.mysql_escape_string($playervars['dkp'] - $eventpoints)
							.", member_status = '1', member_lastraid = '"
							.mysql_escape_string($this->ConvertTimestringToTimestamp($date))
							."', member_raidcount = member_raidcount + 1 WHERE member_name = '"
							.mysql_escape_string($player)."';");
					}
					else {
						$db->query("UPDATE ".MEMBERS_TABLE." SET member_earned = member_earned + "
							.mysql_escape_string($playervars['dkp'] - $eventpoints)
							.", member_status = '1', member_raidcount = member_raidcount + 1 WHERE member_name = '"
							.mysql_escape_string($player)."';");
					}
					$text .= sprintf($user->lang['titandkp_step4_updateplayer'], $playervars['dkp'], $player)."<br>\n";
						
					// insert alts
					foreach ($playervars["alts"] as $alt => $altvars) {
						$db->query("INSERT INTO ".MEMBERS_ALTS_TABLE." (`member_name`, `alt_name`) VALUES ('"
						.mysql_escape_string($player)."', '".mysql_escape_string($alt)."');");
					}
					
					$db->free_result($memberexistscheck);
				}
			}
			
			// insert items
			foreach ($data[$instance][$date]["items"] as $item => $itemvars) {
				foreach ($itemvars as $player => $playervars) {
					while ($playervars !== null && $playervars['count'] > 0) {
						$db->query("INSERT INTO ".ITEMS_TABLE
							." (`item_name`, `item_buyer`, `raid_id`, `item_value`, `item_date`, `item_added_by`, `item_group_key`) VALUES ('"
							.mysql_escape_string(preg_replace("/_/", " ", $item))."', '".mysql_escape_string($player)
							."', '".mysql_escape_string($newraidid)."', '".mysql_escape_string(preg_replace("/_/", "-", $playervars['dkp']))."', '"
							.mysql_escape_string($this->ConvertTimestringToTimestamp($date))."', 'DKPUpload (by ".mysql_escape_string($user->data['username'])
							.")', '".mysql_escape_string($this->gen_group_key(preg_replace("/_/", " ", $item), $this->ConvertTimestringToTimestamp($date), $newraidid))."');");
						$playervars['count']--;
						$text .= sprintf($user->lang['titandkp_step4_additem'], preg_replace("/_/", " ", $item), $player, preg_replace("/_/", "-", $playervars['dkp']))."<br>\n";
					}
				}
			}
		}
		// free results
		$db->free_result($neweventid);
		$db->free_result($newraidid);
		$db->free_result($eventexistscheck);
		
		$text .= $user->lang['titandkp_step4_complete']."<br>\n";
		// output message
		return $text;
	}
	
	// Converts an array to a string
	function array2string($array, $depth) {
		$string = "array(\r\n";
		foreach ($array as $key => $val) {
			$key = preg_replace("/\W+/", "_", $key);
			
			for ($i = 0; $i < $depth; $i++) {
				$string .= "\t";
			}
			
			if (is_array($val)) {
				$string .= "'" .  $key . "' =>  " . $this->array2string($val, $depth+1) . ", \r\n";
			}
			else {
				$val = preg_replace("/\W+/", "_", $val);
				$string .= "'" . $key . "' => '" . $val . "',\r\n";
			}
		}
		
		for ($i = 0; $i < $depth - 1; $i++) {
			$string .= "\t";
		}
		
		return $string . ")";
	}
	
	// convert a timestring to a timestamp
	function ConvertTimestringToTimestamp($timestring) {
		$timestring = preg_replace("/_/", "/", $timestring);
		$parts = preg_split('/[\/ :]/', $timestring);
		return mktime($parts[3], $parts[4], $parts[5], $parts[0], $parts[1], $parts[2]);
	}
	
	// get the id for the class name
	function GetClassID($name) {
		global $db;
	
		$idrow =  $db->query("SELECT `class_id` FROM ".CLASS_TABLE
			." WHERE `class_name` = '".mysql_escape_string($name)."' LIMIT 1;");
	
		if ($db->num_rows($idrow) !== 0) {
			$value = $db->fetch_record($idrow);
			$db->free_result($idrow);
			return $value['class_id'];
		}
		$db->free_result($idrow);
		
		return 0;
	}
	
	// check to see if member exists
	function CheckMember($name) {		
		global $db;
	
		$memberexistscheck = $db->query("SELECT `member_id` FROM ".MEMBERS_TABLE
			." WHERE `member_name` = '".mysql_escape_string($name)."' LIMIT 1;");
		if ($db->num_rows($memberexistscheck) == 0) {
			$db->free_result($memberexistscheck);
			return "(New Player)";
		}
		$db->free_result($memberexistscheck);
		
		return "";
		
	}
}

// call the functions
$import = new TITANDKP_Import;
$import->process();

?>