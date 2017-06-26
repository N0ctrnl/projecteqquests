sub EVENT_SPAWN {

my $Aggro_Target = $entity_list->GetRandomClient($x, $y, $z, 30);
	
	if ($Aggro_Target)
	{
	$npc->AddToHateList($Aggro_Target,0);
	}
}
sub EVENT_DEATH {

        # Get a random entry on mob hate list
my $HateTarget = $npc->GetHateRandom();
		# Get the ID of that hate entry for use with CastSpell
my $HateTargetID = $HateTarget->GetID();
		
	if ($HateTarget)
	{
	$npc->SpellFinished(40051, $HateTarget);
	quest::emote("ae casted on $name");
	}
}
		




