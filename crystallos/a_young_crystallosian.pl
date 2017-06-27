sub EVENT_SPAWN {

	my $Random_Client = $entity_list->GetRandomClient($x, $y, $z, 3000);
		if ($Random_Client)
		{
		$npc->AddToHateList($Random_Client,0);
		}
}

sub EVENT_DEATH {

	quest::signalwith(1000200,2,0);
	plugin::Debug("death signal sent");
	
}