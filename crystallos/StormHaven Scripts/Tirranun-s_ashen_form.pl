## Tir - Stage 2
## Tirranun`s ashen form 850058
## Total timer = 10 minutes. 10,000 hps set at 100 hp regen per tick =1% every 6 seconds 
## For total of 600 seconds till 100% -> Broken into 3 stages of 180sec each. at 90% Next 
## Dragon spawns. Adds spawn 1-3 min at 60 sec, 3-6 min at 30 sec, 6-9 min at 15 sec.

sub EVENT_SPAWN 
{

## Appearance Is dragon looking dead
## Regen up from 1 hp
## Tirr_adds = the first stage of adds, this keeps looping till stopped
## Tirr_P1 = first phase 1-3 min

#$npc->SetAppearance(3);
	
	$npc->SetHP(1);
	quest::settimer("Tirr_Adds1",60);
	quest::settimer("Tirr_P1",180);
	quest::settimer("Sleep",1);
  	}

sub EVENT_TIMER {

	if ($timer eq "Sleep")
	{
		quest::stoptimer("Sleep");
		$npc->SetAppearance(3);
	}

## 850064 Is the #Steaming_Mist npc, this serves only as a 
## trigger to assign the random spawns of the Whirl_of_searing_ashes
## Timer loops pops mist, mist spawns the Whirl at the random loc, then
## mist despawns And cycle repeats as timers go off

	if ($timer eq "Tirr_Adds1") {
    quest::spawn2(870064,0,0, -798.56, 3386.64, -85.00,0); }

	if ($timer eq "Tirr_Adds2") {
    quest::spawn2(870064,0,0, -798.56, 3386.64, -85.00,0); }

	if ($timer eq "Tirr_Adds3") {
    quest::spawn2(870064,0,0, -798.56, 3386.64, -85.00,0); }

# 0-3 minutes = Rest time + 60 sec adds
	if ($timer eq "Tirr_P1") {
#   quest::shout("0-3min OVER");
    quest::stoptimer("Tirr_P1");
    quest::stoptimer("Tirr_Adds1");
    quest::settimer("Tirr_Adds2",30);
    quest::settimer("Tirr_P2",180); 
	}

# 3-6 minutes = Rest time + 30 sec adds
	if ($timer eq "Tirr_P2") 
	{
#   quest::shout("3-6min OVER");
    quest::stoptimer("Tirr_P2");
    quest::stoptimer("Tirr_Adds2");
    quest::settimer("Tirr_Adds3",15);
    quest::settimer("Tirr_P3",180); 
	}

# 6-9 minutes = Rest time + 15 sec adds at 9 min Tir repop a new
# at 90% life, new dragon spawns 850057, Tirranum the Arisen
	
	if ($timer eq "Tirr_P3") 
	{
#   quest::shout("6-9min OVER");
	quest::stoptimer("Tirr_P3");
	quest::stoptimer("Tirr_Adds3");
	quest::spawn2(870057,0,0, -715.73, 2783.64, 40.46,0);
	quest::depop(870058); 
	return;
	}
    
}


