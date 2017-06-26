sub EVENT_SPAWN {

$Gribbix = $entity_list->GetNPCByNPCTypeID(1000005);
$GribbixX = $Gribbix->GetX();
$GribbixY = $Gribbix->GetY();
$GribbixZ = $Gribbix->GetZ();
$Gribbix_Dist = $npc->CalculateDistance($GribbixX, $GribbixY, $GribbixZ);

	plugin::ModSpecialAttack("MCNIDfH");
	quest::moveto($GribbixX,$GribbixY,$GribbixZ,$h,1);
	
}