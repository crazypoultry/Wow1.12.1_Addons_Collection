<?php
define('EQDKP_INC', true);
define('PLUGIN', 'titandkp');

$eqdkp->config['server_path'] = $eqdkp->config['server_path'] . '../../';
$eqdkp_root_path = $eqdkp->config['server_path'];

include_once($eqdkp_root_path . 'common.php');

$titandkp = $pm->get_plugin('titandkp');

if (!$pm->check(PLUGIN_INSTALLED, 'titandkp')) {
    message_die('The TitanDKP plugin is not installed.');
}

if (!$user->check_auth('u_member_list')) {
    message_die($user->lang['noauth_u_member_list']);
}

$sql = 'SELECT ra.member_name, c.class_name as member_class, (m.member_earned + m.member_adjustment - m.member_spent) as current_dkp FROM '
.RAIDS_TABLE.' r, '.RAID_ATTENDEES_TABLE.' ra, '.MEMBERS_TABLE.' m, ' .CLASS_TABLE
.' c WHERE (ra.raid_id = r.raid_id) AND (m.member_name = ra.member_name) AND (m.member_class_id = c.class_id) GROUP BY ra.member_name;';
if ( !($result = $db->query($sql)) ) {
	message_die('Could not connect: ' . mysql_error());
}

define(TAB, "\t");
define(CRLF, "\r\n");

$output = 'dkp_info = {'.CRLF;
$output .=  TAB.'["members"] = {'.CRLF;

$format = TAB.TAB.'["%s"] = {'.CRLF.
	TAB.TAB.TAB.'["class"] = "%s",'.CRLF.
	TAB.TAB.TAB.'["dkp"] = "%s",'.CRLF.
	TAB.TAB.TAB.'["alts"] = {'.CRLF;
	
$format2 = TAB.TAB.TAB.TAB.'["%s"] = 1,'.CRLF;
	
while ($row = $db->fetch_record($result)) {
	$output .= sprintf($format, $row['member_name'], $row['member_class'], $row['current_dkp']);
	
	$sql2 = 'SELECT a.member_name as member_name, a.alt_name as alt_name FROM '.MEMBERS_ALTS_TABLE.' a WHERE a.member_name = \''.$row['member_name'].'\';';
	if (($result2 = $db->query($sql2))) {
		while ($row2 = $db->fetch_record($result2)) {
			$output .= sprintf($format2, $row2['alt_name']);
		}
	}
	$db->free_result($result2);
	
	$output .= TAB.TAB.TAB.'},'.CRLF.
		TAB.TAB.'},'.CRLF;
}

$db->free_result($result);

$myfilename="dkp_dump.lua";
  
$output = substr($output, 0, strlen($output)-3).CRLF.TAB.'}'.CRLF.'}'.CRLF;

header("Content-Disposition: attachment; filename=$myfilename");
header("Content-Type: application/force-download");
header("Content-Length: ".strlen($output));
header("Cache-control: private");
header("Content-Transfer-Encoding: text");
header('Pragma:');
echo $output;

header("<html><body><a href='standings.php?s=".$SID."'>Back</a></body></html>");

?>
