sub EVENT_SPAWN {
$MAX_DMG_Boost = $npc->GetMaxDMG(); 

#plugin::Debug("Max Damamge [$MAX_DMG_Boost] ");
quest::stop();
#plugin::ModSpecialAttack("SERrFQMCNIDfABH");
plugin::Debug("Spawn $mobid");
quest::modifynpcstat("runspeed",0);
quest::settimer("fight",2);

}

sub EVENT_TIMER {

	if ($timer eq "fight")
	{
	plugin::DoAnim("bash");
	}
	
	if ($timer eq "dust")
	{
	quest::stoptimer("dust");
	quest::spawn2(1000198,0,0,$x+5,$y,$z,$h);
	quest::spawn2(1000198,0,0,$x,$y+5,$z,$h);
	quest::spawn2(1000198,0,0,$x-5,$y,$z,$h);
	quest::spawn2(1000198,0,0,$x,$y-5,$z,$h);
	plugin::Debug("Timer $timer done");
	}
}

sub EVENT_SIGNAL {

	if ($signal == 1)
	{
	quest::modifynpcstat("runspeed",4.0);
	quest::stopalltimers();
	quest::moveto(224.5,2768.9,-525.1,190.4,1);
	#plugin::ModSpecialAttack("ABH",1);
	#quest::start(546790);
	plugin::Debug("signal recieved");
	}
	
	if ($signal == 2)
	{
	$HP_RATIO_CHK = int($npc->GetHPRatio());
	$Heal = ($HP_RATIO_CHK/100) + 0.05;
	$npc->SetHP($npc->GetMaxHP() * $Heal);	
	quest::settimer("dust",10);
	$entity_list->MessageClose($npc, 1, 20000, 15, "The Moisture Present in the muddites is absorbed by Lonerer, healing him and increasing his prowess");
	$MAX_DMG = $npc->GetMaxDMG(); 
	$New_MAX_DMG = int($MAX_DMG * 0.01);
	$Final_MAX_DMG = $New_MAX_DMG + $MAX_DMG;
	quest::modifynpcstat("max_hit", $Final_MAX_DMG);
	plugin::Debug("New Max Damage [$Final_MAX_DMG]");
	plugin::Debug("Signal $signal recieved");
	}
}

sub EVENT_DEATH {

	quest::spawn2(1000009,0,0,$x,$y,$z,$h);
	quest::spawn2(1000008,0,0,$x+5,$y,$z,$h);
	quest::spawn2(1000008,0,0,$x,$y+5,$z,$h);
	quest::spawn2(1000008,0,0,$x-5,$y,$z,$h);
	quest::spawn2(1000008,0,0,$x,$y-5,$z,$h);
	quest::spawn2(1000008,0,0,$x+5,$y+5,$z,$h);
	quest::spawn2(1000008,0,0,$x-5,$y-5,$z,$h);
	quest::spawn2(1000008,0,0,$x+5,$y-5,$z,$h);
	quest::spawn2(1000008,0,0,$x-5,$y+5,$z,$h);
	quest::me("Lonerer crumbles into bits");
	quest::signalwith(1000005,5,1);
	
}