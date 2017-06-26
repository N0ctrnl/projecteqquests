sub EVENT_SPAWN {

my $Aggro_Target = $entity_list->GetRandomClient($x, $y, $z, 50);
	
	if ($Aggro_Target)
	{
	$npc->AddToHateList($Aggro_Target,0);
	}
}