sub EVENT_SPAWN {
$Gribbix = $entity_list->GetNPCByNPCTypeID(999240);
$GribbixX = $Gribbix->GetX();
$GribbixY = $Gribbix->GetY();
$GribbixZ = $Gribbix->GetZ();
$Gribbix_Dist = $npc->CalculateDistance($GribbixX, $GribbixY, $GribbixZ);

plugin::ModSpecialAttack("MCNIDfH");
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
		    plugin::Debug("Prox achieved");
			quest::signalwith(1000006,2,1);
			quest::depop();
			plugin::Debug("Signal $signal sent");
		    }
				else 
				{ 
				quest:settimerMS("proxi",1); 
				}
		}
}