sub EVENT_SPAWN {

	
$Gribbix = $entity_list->GetNPCByNPCTypeID(1000005);
$GribbixX = $Gribbix->GetX();
$GribbixY = $Gribbix->GetY();
$GribbixZ = $Gribbix->GetZ();
$Gribbix_Dist = $npc->CalculateDistance($GribbixX, $GribbixY, $GribbixZ);


#plugin::ModSpecialAttack("MCNIDfHAB");
quest::moveto($GribbixX,$GribbixY,$GribbixZ,$h,1);
quest::settimer("proxi",1);
plugin::Debug("Timer Proxi Set");
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
	    quest::depop();
		}
			else 
			{ 
			quest:settimerMS("proxi",1); 
			}
	}
}