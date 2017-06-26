sub EVENT_SPELL_EFFECT_NPC
{  
	my $client = $entity_list->GetClientByID($caster_id);
	if($client->GetTarget()->IsNPC()) 
	{	 
#		$client->GetTarget()->SetHP(int($client->GetTarget()->GetHP() - 841));
		$$npc->DoSpecialAttackDamage($client->GetTarget(), 1, 1);
		$client->Emote("hit " . $client->GetTarget()->GetCleanName() . " for 841 points of non-melee damage.");
	}
}
