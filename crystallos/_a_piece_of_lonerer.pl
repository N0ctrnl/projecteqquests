sub EVENT_SPAWN {

	
$Gribbix = $entity_list->GetNPCByNPCTypeID(1000005);
$GribbixX = $Gribbix->GetX();
$GribbixY = $Gribbix->GetY();
$GribbixZ = $Gribbix->GetZ();
$Gribbix_Dist = $npc->CalculateDistance($GribbixX, $GribbixY, $GribbixZ);

	$entity_list->MessageClose($npc, 1, 20000, 15, "In one final effort, Lonerer crumbles and rushes to Gribbix's aid.");
	#plugin::ModSpecialAttack("MCNIDfHAB");
	quest::moveto($GribbixX,$GribbixY,$GribbixZ,$h,1);
	quest::settimer("proxi",1);
	
}

sub EVENT_TIMER {


$Gribbix = $entity_list->GetNPCByNPCTypeID(1000005);
$GribbixX = $Gribbix->GetX();
$GribbixY = $Gribbix->GetY();
$GribbixZ = $Gribbix->GetZ();
$Gribbix_Dist = $npc->CalculateDistance($GribbixX, $GribbixY, $GribbixZ);	


	if ($timer eq "proxi")
	{
		if (($Gribbix_Dist > 10) && ($Gribbix))
		{
		
		}
			elsif (($Gribbix_Dist <= 10) && ($Gribbix))
			{
			quest::stoptimer("proxi");
			plugin::Debug("Timer $timer Fired");
			quest::signalwith(1000005,3,1);
			quest::signalwith(1000005,4,1);
			quest::depop();
			}
				else 
				{ 
				quest:settimerMS("proxi",1); 
				}
	}
}