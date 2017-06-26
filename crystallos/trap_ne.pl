
sub EVENT_SPAWN {

	quest::settimer("broken",1);
	$npc->NPCSpecialAttacks("ABH",1);
	#plugin::ModSpecialAttack("ABH",0);
	plugin::Debug("NE ABH+");
	
}

sub EVENT_TIMER {

	if ($timer eq "broken")
	{
	quest::stoptimer("broken");
	$npc->SetBodyType(11);
	plugin::SetAnim("dead");
	}
}

sub EVENT_SAY {
	$Boss = $entity_list->GetNPCByNPCTypeID(1000200);
	my $Nx=$Boss->GetX();
	my $Ny=$Boss->GetY();
	my $Nz=$Boss->GetZ();
	my $Norgath_Dist=$npc->CalculateDistance($Nx,$Ny,$Nz);


	if ($text =~/Hail/i)
	{
	
		if (($Norgath_Dist <= 10) && ($Boss))
		{
		quest::signalwith(1000200,1,0);
		plugin::Debug("SHE IS CLOSE");
		}
			elsif (($Norgath_Dist > 11) && ($Boss))
			{
			plugin::Debug("NOT CLOSE");
			}
				else
				{
				plugin::Debug("NOTHING HAPPENED");
				}
	
	}
}

sub EVENT_SIGNAL {

	if ($signal == 1)
	{
	$npc->SetBodyType(1);
	$entity_list->MessageClose($npc, 1, 20000, 314, "You hear a mechanical click to the north east.");
	plugin::SetAnim("stand");
	#$signal=0;
	}
	if ($signal == 2)
	{
	quest::settimer("broken",1);
	}
}