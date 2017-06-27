sub EVENT_SAY{

 my $avenge = quest::saylink("avenge",1);
 my $artefacts = quest::saylink("artefacts",1);
 my $dish = quest::saylink("dish",1);
 
 
	if ($text =~/Hail/i)
	{
	quest::say ("Stay back, vile beast! I will cleanse this wicked house and [avenge] my brethren!");
	}

	if ($text =~/avenge/i)
	{	
	quest::say ("My apologies for the hostility. I thought thou to be one of the creatures dwelling in this residence. It's foul inhabitants have already claimed the souls of my fellow adventurers. We set out months ago after hearing stories of three ancient [artefacts] with strange, but wonderful powers. We were ill prepared for the evils that awaited us in this despicable place. I fear I am the last that remains of my party. I pray Mithaniel have mercy on their souls! I know the beasts here will not. ");
	}

	if ($text =~/artefacts/i)
	{
	quest::say ("I know little of the artefacts myself. Though the rumour did speak of one in particular. An ancient kettle. It is said that when an experienced chef mixes five raw pumpkin seeds, with the fat of two pig-men within its basin, and then heats the kettle using 3 embers of the restless dead, a delectable [dish] with no equal would be created.");
	}
	
	if ($text =~/dish/i)
	{
	quest::say ("Sadly I never so much as gazed upon the final product, let alone indulged. I'm sure it sounds silly to an outsider, why any sane person would come to such a place as this for a reward so simple as food. From where I stand now, mouldy bread sounds like a meal befitting a king. Heed my advice adventurer. Turn back now. Only death is found in this place.")
	}
}