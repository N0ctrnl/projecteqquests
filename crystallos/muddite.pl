sub EVENT_SPAWN {
$Boss = $entity_list->GetNPCByNPCTypeID(1000006);
$BossX = $Boss->GetX();
$BossY = $Boss->GetY();
$BossZ = $Boss->GetZ();
$Lonerer_Dist = $npc->CalculateDistance($BossX, $BossY, $BossZ);

#plugin::ModSpecialAttack("MCNIDfH");
quest::moveto($BossX,$BossY,$BossZ,$h,1);
quest::settimer("prox",1);
plugin::Debug("Timer Prox Set");

}

sub EVENT_TIMER {

$Boss = $entity_list->GetNPCByNPCTypeID(1000006);
$BossX = $Boss->GetX();
$BossY = $Boss->GetY();
$BossZ = $Boss->GetZ();
$Lonerer_Dist = $npc->CalculateDistance($BossX, $BossY, $BossZ);

		if ($timer eq "prox")
		{
		if (($Lonerer_Dist > 10) && ($Boss))
		{
		
		}
			elsif (($Lonerer_Dist <= 10) && ($Boss))
		    {
		    quest::stoptimer("prox");
		    plugin::Debug("Prox achieved");
			quest::signalwith(1000006,2,1);
			quest::depop();
			plugin::Debug("Signal $signal sent");
		    }
				else 
				{ 
				quest:settimerMS("prox",1); 
				}
		}
}