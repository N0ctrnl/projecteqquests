## Gribbix - 1000005
## Lonerer - 1000006
## Punoc - 1000007
## a piece of lonerer - 1000008
## _a piece of lonerer - 1000009
## lonerer`s remains - 1000010
## muddite - 1000011





sub EVENT_SPAWN {
quest::stop();
plugin::Debug("Spawn $mobid");
#plugin::ModSpecialAttack("SERrFQMCNIDfABH");
quest::modifynpcstat("runspeed",0);
quest::settimer("fight",2);

}

sub EVENT_COMBAT {

	if ($combat_state ==0)
	{
	}
	
	if ($combat_state == 1)
	{
	quest::settimer("muddites",30);
	quest::settimer("mudAE",30);
	
	}
}


sub EVENT_TIMER {

	if ($timer eq "fight")
	{
	quest::stoptimer("fight");
	plugin::DoAnim("bash");
	quest::settimer("fight2",2);
	}
	
	if ($timer eq "fight2")
	{
	quest::stoptimer("fight2");
	plugin::DoAnim("mainhand");
	quest::settimer("fight",2);
	}
	
	if ($timer eq "muddites")
	{
	#quest::stoptimer("muddites");
	quest::spawn2(1000011,0,0,$x+5,$y,$z,$h);
	quest::spawn2(1000011,0,0,$x,$y+5,$z,$h);
	quest::spawn2(1000011,0,0,$x-5,$y,$z,$h);
	quest::spawn2(1000011,0,0,$x,$y-5,$z,$h);
	quest::emote("is restored");
	$npc->SetHP(100000000);
	}
	
	if ($timer eq "mudAE")
	{
	plugin::CastOnTarget(4495);
	}
	
	
}

sub EVENT_SIGNAL {

	if ($signal == 1)
	{
	quest::modifynpcstat("runspeed",5.0);
	quest::stopalltimers();
	quest::moveto(-405.3,2779.9,-528.6,56.9,1);
	#plugin::ModSpecialAttack("ABH",1);
	plugin::Debug("signal recieved");
	}
	
		
	if ($signal == 3)
	{
	quest::emote("is infused with elemental power.  Increasing his power and health considerably.");
	}

	if ($signal == 4)
	{
	$hp = $npc->GetMaxHP();
	$New_Max_HP = int($hp * 0.33);
	$Final_Max_HP = $New_Max_HP + $hp;
	$MAX_DMG = $npc->GetMaxDMG(); 
	$New_MAX_DMG = int($MAX_DMG * 1.5);
	$Final_MAX_DMG = $New_MAX_DMG + $MAX_DMG;
	quest::modifynpcstat("max_hit", $Final_MAX_DMG);
	quest::modifynpcstat("min_hit", 18500);
	plugin::Debug("New Max Damage [$Final_MAX_DMG]");
	quest::modifynpcstat("max_hp", $Final_Max_HP);
	$npc->SetHP(75000000);
	plugin::Debug("new HP is $Final_Max_HP");
	quest::stoptimer("muddites");
	
	}
	
	if ($signal == 5)
	{
	quest::stoptimer("muddites");
	}
	
}

sub EVENT_DEATH {

	quest::emote("'s moisture dries up as he crumbles to dust.");
	quest::spawn2(999438,0,0,$x,$y,$z,$h);
	
}


