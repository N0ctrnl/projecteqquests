sub EVENT_SPAWN {

	$Random_Loot = quest::ChooseRandom(1234,1567,8989,10945);
	quest::addloot($Random_Loot,0,0);
	#$npc->ModSpecialAttack("H");
	plugin::Debug("Random $Random_Loot chosen");
	
}