sub EVENT_SPAWN {

	my $Random_Client = $entity_list->GetRandomClient($x, $y, $z, 1000);
	
	$npc->AddToHateList($Random_Client,0);
	
}