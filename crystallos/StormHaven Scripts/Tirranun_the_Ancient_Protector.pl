## Tirranum_the_Ancient_Protector (850058) - Stage 1 
## Spell Tirranun's Incinerating Aura 6536 = Tirr_AE1 every 60 sec	
#1: 	Decrease HP when cast by 2250
#2: 	Decrease Hitpoints by 750 per tick
#3: 	Increase Poison Counter by 99
## Spell Ancient Pyrlien Skin 6145 = Tirr_DS  500 DS every 24 sec
##850058 Is Mob For Tirranum's ashen form Stage 2

sub EVENT_SPAWN 
{
quest::depop(870057);  
}

sub EVENT_COMBAT {

	if ($combat_state == 0) 
	{
	quest::stoptimer("Tirr_DS");
	quest::stoptimer("Tirr_AE");
	quest::signalwith(2700631,2,300000);
	$npc->CastSpell(13,$mobid); 
	}
  
	if ($combat_state == 1) {
	quest::setnexthpevent(76);
	quest::emote("unleashes a deafening roar");
	quest::stoptimer("Tirr_AE");
	quest::settimer("Tirr_AE",60);
	quest::signalwith(2700631,1,0);
	plugin::CastOnTarget(6536); 
	}

}

sub EVENT_HP {

	if ($hpevent == 76) 
	{
	quest::setnexthpevent(41);
	quest::stoptimer("Tirr_DS");
	quest::settimer("Tirr_DS",30);
	quest::emote("skin ignites in flames");
	$npc->CastSpell(6145,$mobid); 
	}

	if ($hpevent == 41) {
    quest::setnexthpevent(6);
    quest::emote("rears back and unleashes a storm of deadly fire");
	plugin::CastOnTarget(3768); 
	}
    
	#Dragon despawns And stops all timers. Stage 2 Tirranum spawns

	if ($hpevent == 6) 
	{
    quest::emote("collapses to the ground");
    quest::stoptimer("Tirr_DS");
    quest::stoptimer("Tirr_AE");
    quest::spawn2(870058,0,0,$x,$y,$z,$h);
	plugin::CastOnTarget(3768);
    quest::depop(870055);
	return;
	}

}

##Timer will keep cycling till dragon depops

sub EVENT_TIMER {

	#if ($timer eq "Tirr_DS") 
	#{
    #quest::stoptimer("Tirr_DS");
    #quest::emote("skin ignites in flames");
    #quest::settimer("Tirr_DS",30);
	#$npc->CastSpell(6145,$mobid); 
	#}

	if ($timer eq "Tirr_AE") 
	{
    quest::stoptimer("Tirr_AE");
    quest::emote("unleashes a deadly wave of flames");
    quest::settimer("Tirr_AE",60);
	plugin::CastOnTarget(6536); 
	}
	
}

sub EVENT_DEATH
{
    quest::emote("collapses to the ground");
    quest::stoptimer("Tirr_DS");
    quest::stoptimer("Tirr_AE");
    quest::spawn2(870058,0,0,$x,$y,$z,$h);
	#plugin::CastOnTarget(3768);
    quest::depop(870055);
	return;

}


