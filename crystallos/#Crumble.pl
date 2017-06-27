#NPC used in event
#999371 - Untargetable Ice Golem Circle
#999996 - a_chunk_of_ice
#999995 - a_chunkof_black_ice
#999366 - water droplets spawned from black ice
#999999- #Crumble
#999994 - healing waters
#999997 - #Shard of Ice

sub EVENT_SAY{

my $ready = quest::saylink("ready", 1);
my $Ulissa = quest::saylink("Ulissa", 1); 


	if ($text =~/Hail/i)
	{
	quest::emote ("glances around the room as he begins to respond.");
	quest::settimer("hail",5);
	}

	if ($text =~/Ulissa/i)
	{
	quest::say ("She is, or rather was, the guardian of this area. She will be avenged!! Are you [$ready] for your destruction?");
	}

	if ($text =~/ready/i)
	{
	quest::say("Very well!");
	quest::settimer("golems",5);
	quest::settimer("despawn",8);
	quest::settimer("attack",8);
	}
}

sub EVENT_TIMER {
my $Ulissa = quest::saylink("Ulissa", 1); 

	if ($timer eq "hail")
	{
	quest::say ("Impossible!  How did you make it past [$Ulissa]?");
	quest::stoptimer("hail");
	}

	if ($timer eq "golems")
	{
	quest::signalwith(999998,walk,0); #Signal the golem ring to walk to Crumble 2?
	quest::gmsay("signal sent",13,0);
	quest::stoptimer("golems");
	}

	if ($timer eq "despawn")
	{
	quest::depopall(999998); #despawn golem ring
	quest::npcsize(50); #Crumble grows after "absorbing" the golem ring
	quest::ze(15, "Crumble grows as he absorbs the golems at his feet");
	$npc->NPCSpecialAttacks(SERFQMCNID, 1);
	#quest::modifynpcstat("special_attacks", SERFQMCNID); #Use above instead its better
	quest::shout("I shall rid these halls of ALL intruders!");
	quest::stoptimer("despawn");
	}

	if ($timer eq "attack")
	{
	
	my $aggroer = $entity_list->GetRandomClient($x, $y, $z, 20);
	
		if ($aggroer)
		{
		$npc->AddToHateList($aggroer,0);
		quest::signalwith(999300,0,0);
		quest::gmsay("Hate list set (pc within 20 units)",13,0);
		quest::stoptimer("attack");
		}
		
		else
		{
		quest::settimer("attack",1); #If the client does not exist, try agian in 1 second (other ways to do this but this is stable)
		}
	}
}
	
sub EVENT_SPAWN 
{
#Spawn the golem ring MOB: no name, untargetable (may add animation later)
quest::spawn2(999998, 1, 0, 478.7, 678.9, -46.9, 179);
quest::spawn2(999998,1,0,480.5,667.2,-46.9,194);
quest::spawn2(999998,1,0,479.7,654.9,-46.9,206.9);
quest::spawn2(999998,1,0,472.6,644.7,-46.9,222.8);
quest::spawn2(999998,1,0,463.5,636.8,-46.9,236.0);
quest::spawn2(999998,1,0,451.7,632.3,-46.9,249.3);
quest::spawn2(999998,1,0,439.5,632.5,-46.9,7.4);
quest::spawn2(999998,1,0,427.4,636.7,-46.9,25.3);
quest::spawn2(999998,1,0,418.2,644.8,-46.9,37.3);
quest::spawn2(999998,1,0,412.5,655.4,-46.9,51.8);
quest::spawn2(999998,1,0,409.3,667.7,-46.9,66.1);
quest::spawn2(999998,1,0,413.1,679.4,-46.9,79.3);
quest::spawn2(999998,1,0,418.6,690.6,-46.9,92.9);
quest::spawn2(999998,1,0,428.6,697.5,-46.9,107.5);
quest::spawn2(999998,1,0,439.8,702.2,-46.9,121.3);
quest::spawn2(999998,1,0,451.5,702.6,-46.9,134.3);
quest::spawn2(999998,1,0,464.1,698.6,-46.9,149.0);
quest::spawn2(999998,1,0,473.1,690.4,-46.9,163.9);
#quest::gmsay("golem ring spawned",13,0);
}


sub EVENT_COMBAT {



	if ($combat_state == 0) 
	{
	
	}
	
	if ($combat_state == 1) 
	{
	quest::setnexthpevent(95);
		
	}

}

sub EVENT_HP {

		if ($hpevent == 95) 
		{
		quest::setnexthpevent(90);
		quest::emote("begins to crumble");
		quest::spawn2(999995,0,0,446.6,699.7,-46.9,64.1); #spawn black ice
		quest::spawn2(999996,0,0,445.5,632.5,-46.9,34.8); #spawn ice chunk
		quest::npcsize(48); #decrease size due to breakage
		# Cast a spell on the random hate target (Wanton Destruction(modified))
		
		my $HateTarget = $npc->GetHateRandom();
				
			if ($HateTarget)
			{
			$npc->CastSpell(40050, $HateTarget);
			quest::gmsay("AE CAST on $name",13,0);
			}
			
		#quest::gmsay("AE CAST",13,0);	
		    $MAX_DMG_Decrease = $npc->GetMaxDMG(); 
			$New_MAX_DMG_Decrease = $MAX_DMG_Decrease - 500;
			quest::modifynpcstat("max_hit", $New_MAX_DMG_Decrease);
			quest::gmsay("new dmg $New_MAX_DMG_Decrease",13,0);
		}

		if ($hpevent == 90) 
		{
		quest::setnexthpevent(85);
		quest::emote("begins to crumble");
		quest::spawn2(999995,1,0,446.6,699.7,-46.9,64.1);
		quest::spawn2(999996,1,0,445.5,632.5,-46.9,34.8);
		quest::npcsize(46);
		my $HateTarget = $npc->GetHateRandom();
		
			if ($HateTarget)
			{
			$npc->SpellFinished(40050, $HateTarget);
			}
			quest::gmsay("AE CAST",13,0);
		    $MAX_DMG_Decrease = $npc->GetMaxDMG(); 
			$New_MAX_DMG_Decrease = $MAX_DMG_Decrease - 500;
			quest::modifynpcstat("max_hit", $New_MAX_DMG_Decrease);
			quest::gmsay("new dmg $New_MAX_DMG_Decrease",13,0);
		}
    
		if ($hpevent == 85) 
		{
		quest::setnexthpevent(80);
		quest::emote("begins to crumble");
		quest::spawn2(999995,1,0,446.6,699.7,-46.9,64.1);
		quest::spawn2(999996,1,0,445.5,632.5,-46.9,34.8);
		quest::npcsize(44);
		my $HateTarget = $npc->GetHateRandom();
		
			if ($HateTarget)
			{
			$npc->SpellFinished(40050, $HateTarget);
			}
		quest::gmsay("AE CAST",13,0);	
		    $MAX_DMG_Decrease = $npc->GetMaxDMG(); 
			$New_MAX_DMG_Decrease = $MAX_DMG_Decrease - 500;
			quest::modifynpcstat("max_hit", $New_MAX_DMG_Decrease);
			quest::gmsay("new dmg $New_MAX_DMG_Decrease",13,0);
		}
	
		if ($hpevent == 80)
		{
		quest::setnexthpevent(75);
		quest::emote("begins to crumble");
		quest::spawn2(999995,1,0,446.6,699.7,-46.9,64.1);
		quest::spawn2(999996,1,0,445.5,632.5,-46.9,34.8);
		quest::npcsize(42);
		my $HateTarget = $npc->GetHateRandom();
		
			if ($HateTarget)
			{
			$npc->SpellFinished(40050, $HateTarget);
			}
		quest::gmsay("AE CAST",13,0);	
		    $MAX_DMG_Decrease = $npc->GetMaxDMG(); 
			$New_MAX_DMG_Decrease = $MAX_DMG_Decrease - 500;
			quest::modifynpcstat("max_hit", $New_MAX_DMG_Decrease);
			quest::gmsay("new dmg $New_MAX_DMG_Decrease",13,0);
		}
	
		if ($hpevent == 75) 
		{
		quest::setnexthpevent(70);
		quest::emote("begins to crumble");
		quest::spawn2(999995,1,0,446.6,699.7,-46.9,64.1);
		quest::spawn2(999996,1,0,445.5,632.5,-46.9,34.8);
		quest::npcsize(40);
		$HateTarget = $npc->GetHateRandom();
		
			if ($HateTarget)
			{
			$npc->SpellFinished(40050, $HateTarget);
			}
		quest::gmsay("AE CAST",13,0);
		    $MAX_DMG_Decrease = $npc->GetMaxDMG(); 
			$New_MAX_DMG_Decrease = $MAX_DMG_Decrease - 500;
			quest::modifynpcstat("max_hit", $New_MAX_DMG_Decrease);
			quest::gmsay("new dmg $New_MAX_DMG_Decrease",13,0);
		}

		if ($hpevent == 70) 
		{
		quest::setnexthpevent(65);
		quest::emote("begins to crumble");
		quest::spawn2(999995,1,0,446.6,699.7,-46.9,64.1);
		quest::spawn2(999996,1,0,445.5,632.5,-46.9,34.8);
		quest::npcsize(38);
		$npc->SpellFinished(40050, $HateTarget);
		quest::gmsay("AE CAST",13,0);	
		    $MAX_DMG_Decrease = $npc->GetMaxDMG(); 
			$New_MAX_DMG_Decrease = $MAX_DMG_Decrease - 500;
			quest::modifynpcstat("max_hit", $New_MAX_DMG_Decrease);
			quest::gmsay("new dmg $New_MAX_DMG_Decrease",13,0);
		}
	
		if ($hpevent == 65) {
		quest::setnexthpevent(60);
		quest::emote("begins to crumble");
		quest::spawn2(999995,1,0,446.6,699.7,-46.9,64.1);
		quest::spawn2(999996,1,0,445.5,632.5,-46.9,34.8);
		quest::npcsize(36);
		$HateTarget = $npc->GetHateRandom();
		
			if ($HateTarget)
			{
			$npc->SpellFinished(40050, $HateTarget);
			}
		quest::gmsay("AE CAST",13,0);	
		    $MAX_DMG_Decrease = $npc->GetMaxDMG(); 
			$New_MAX_DMG_Decrease = $MAX_DMG_Decrease - 500;
			quest::modifynpcstat("max_hit", $New_MAX_DMG_Decrease);
			quest::gmsay("new dmg $New_MAX_DMG_Decrease",13,0);
		}
	
		if ($hpevent == 60) 
		{
		quest::setnexthpevent(55);
		quest::emote("begins to crumble");
		quest::spawn2(999995,1,0,446.6,699.7,-46.9,64.1);
		quest::spawn2(999996,1,0,445.5,632.5,-46.9,34.8);
		quest::npcsize(34);
		$HateTarget = $npc->GetHateRandom();
			
			if ($HateTarget)
			{
			$npc->SpellFinished(40050, $HateTarget);
			}
				
		quest::gmsay("AE CAST",13,0);	
		    $MAX_DMG_Decrease = $npc->GetMaxDMG(); 
			$New_MAX_DMG_Decrease = $MAX_DMG_Decrease - 500;
			quest::modifynpcstat("max_hit", $New_MAX_DMG_Decrease);
			quest::gmsay("new dmg $New_MAX_DMG_Decrease",13,0);

		}
	
	if ($hpevent == 55) {
    quest::setnexthpevent(50);
    quest::emote("begins to crumble");
	quest::spawn2(999995,1,0,446.6,699.7,-46.9,64.1);
	quest::spawn2(999996,1,0,445.5,632.5,-46.9,34.8);
	quest::npcsize(32);
	
	$HateTarget = $npc->GetHateRandom();
		
		if ($HateTarget)
		{
		$npc->SpellFinished(40050, $HateTarget);
		}
	quest::gmsay("AE CAST",13,0);	
	        $MAX_DMG_Decrease = $npc->GetMaxDMG(); 
			$New_MAX_DMG_Decrease = $MAX_DMG_Decrease - 500;
			quest::modifynpcstat("max_hit", $New_MAX_DMG_Decrease);
			quest::gmsay("new dmg $New_MAX_DMG_Decrease",13,0);
	}
	
	if ($hpevent == 50) {
    quest::setnexthpevent(45);
	$entity_list->MessageClose($npc, 1, 20000, 1, "Crumble begins to cast a spell. (Animate Ice Shards)");
    quest::doanim(42);
	quest::spawn2(999997,1,0,$x+130,$y-130,$z,$h);
	quest::spawn2(999997,1,0,$x-130,$y+130,$z,$h);
	quest::spawn2(999997,1,0,$x+130,$y+130,$z,$h);
	quest::spawn2(999997,1,0,$x-130,$y-130,$z,$h);
	quest::gmsay("crystals spawned",13,0);
	quest::npcsize(30);
	$HateTarget = $npc->GetHateRandom();
		
		if ($HateTarget)
		{
		$npc->SpellFinished(40050, $HateTarget);
		}
	quest::gmsay("AE CAST",13,0);	
	        $MAX_DMG_Decrease = $npc->GetMaxDMG(); 
			$New_MAX_DMG_Decrease = $MAX_DMG_Decrease - 500;
			quest::modifynpcstat("max_hit", $New_MAX_DMG_Decrease);
			quest::gmsay("new dmg $New_MAX_DMG_Decrease",13,0);
	}
	
	if ($hpevent == 45)
	{
	quest::setnexthpevent(40);
	quest::emote("begins to crumble");
	quest::spawn2(999995,1,0,446.6,699.7,-46.9,64.1);
	quest::spawn2(999996,1,0,445.5,632.5,-46.9,34.8);
	quest::npcsize(28);
	$HateTarget = $npc->GetHateRandom();
		
		if ($HateTarget)
		{
		$npc->SpellFinished(40050, $HateTarget);
		}
			
	quest::gmsay("AE CAST",13,0);	
	    $MAX_DMG_Decrease = $npc->GetMaxDMG(); 
		$New_MAX_DMG_Decrease = $MAX_DMG_Decrease - 500;
		quest::modifynpcstat("max_hit", $New_MAX_DMG_Decrease);
		quest::gmsay("new dmg $New_MAX_DMG_Decrease",13,0);
	}
	
	if ($hpevent == 40){
	quest::setnexthpevent(35);
	quest::emote("begins to crumble");
	quest::spawn2(999995,1,0,446.6,699.7,-46.9,64.1);
	quest::spawn2(999996,1,0,445.5,632.5,-46.9,34.8);
	quest::npcsize(26);
	$HateTarget = $npc->GetHateRandom();
		
		if ($HateTarget)
		{
		$npc->SpellFinished(40050, $HateTarget);
		}
		
	quest::gmsay("AE CAST",13,0);
        $MAX_DMG_Decrease = $npc->GetMaxDMG(); 
		$New_MAX_DMG_Decrease = $MAX_DMG_Decrease - 500;
		quest::modifynpcstat("max_hit", $New_MAX_DMG_Decrease);
		quest::gmsay("new dmg $New_MAX_DMG_Decrease",13,0);	
	
	}
	
	if ($hpevent == 35)
	{
	quest::setnexthpevent(30);
	quest::emote("begins to crumble");
	quest::spawn2(999995,1,0,446.6,699.7,-46.9,64.1);
	quest::spawn2(999996,1,0,445.5,632.5,-46.9,34.8);
	quest::npcsize(24);
	$HateTarget = $npc->GetHateRandom();
		
		if ($HateTarget)
		{
		$npc->SpellFinished(40050, $HateTarget);
		}
			
	quest::gmsay("AE CAST",13,0);
        $MAX_DMG_Decrease = $npc->GetMaxDMG(); 
		$New_MAX_DMG_Decrease = $MAX_DMG_Decrease - 500;
		quest::modifynpcstat("max_hit", $New_MAX_DMG_Decrease);
		quest::gmsay("new dmg $New_MAX_DMG_Decrease",13,0);	
	
	}
	
	if ($hpevent == 30){
	quest::setnexthpevent(25);
	quest::emote("begins to crumble");
	quest::spawn2(999995,1,0,446.6,699.7,-46.9,64.1);
	quest::spawn2(999996,1,0,445.5,632.5,-46.9,34.8);
	quest::npcsize(22);
	$HateTarget = $npc->GetHateRandom();
		
			if ($HateTarget)
			{
			$npc->SpellFinished(40050, $HateTarget);
			}
	quest::gmsay("AE CAST",13,0);	
	
	}
	
	if ($hpevent == 25){
	quest::setnexthpevent(20);
	quest::emote("begins to crumble");
	quest::spawn2(999995,1,0,446.6,699.7,-46.9,64.1);
	quest::spawn2(999996,1,0,445.5,632.5,-46.9,34.8);
	quest::npcsize(20);
	$HateTarget = $npc->GetHateRandom();
		
		if ($HateTarget)
		{
		$npc->SpellFinished(40050, $HateTarget);
		}
	
	quest::gmsay("AE CAST",13,0);
        $MAX_DMG_Decrease = $npc->GetMaxDMG(); 
		$New_MAX_DMG_Decrease = $MAX_DMG_Decrease - 500;
		quest::modifynpcstat("max_hit", $New_MAX_DMG_Decrease);
		quest::gmsay("new dmg $New_MAX_DMG_Decrease",13,0);	
	
	}
	
	if ($hpevent == 20){
	quest::setnexthpevent(15);
	quest::emote("begins to crumble");
	quest::spawn2(999995,1,0,446.6,699.7,-46.9,64.1);
	quest::spawn2(999996,1,0,445.5,632.5,-46.9,34.8);
	quest::npcsize(18);
	$HateTarget = $npc->GetHateRandom();
		
		if ($HateTarget)
		{
		$npc->SpellFinished(40050, $HateTarget);
		}
	quest::gmsay("AE CAST",13,0);
        $MAX_DMG_Decrease = $npc->GetMaxDMG(); 
		$New_MAX_DMG_Decrease = $MAX_DMG_Decrease - 500;
		quest::modifynpcstat("max_hit", $New_MAX_DMG_Decrease);
		quest::gmsay("new dmg $New_MAX_DMG_Decrease",13,0);	
	
	}
	
	if ($hpevent == 15){
	quest::setnexthpevent(10);
	quest::emote("begins to crumble");
	quest::spawn2(999995,1,0,446.6,699.7,-46.9,64.1);
	quest::spawn2(999996,1,0,445.5,632.5,-46.9,34.8);
	quest::npcsize(16);
	$HateTarget = $npc->GetHateRandom();
		
		if ($HateTarget)
		{
		$npc->SpellFinished(40050, $HateTarget);
		}
	
	quest::gmsay("AE CAST",13,0);
        $MAX_DMG_Decrease = $npc->GetMaxDMG(); 
		$New_MAX_DMG_Decrease = $MAX_DMG_Decrease - 500;
		quest::modifynpcstat("max_hit", $New_MAX_DMG_Decrease);
		quest::gmsay("new dmg $New_MAX_DMG_Decrease",13,0);	
	
	}
	
	if ($hpevent == 10){
	quest::setnexthpevent(8);
	quest::emote("begins to crumble");
	quest::spawn2(999995,1,0,446.6,699.7,-46.9,64.1);
	quest::spawn2(999996,1,0,445.5,632.5,-46.9,34.8);
	quest::npcsize(14);
	$HateTarget = $npc->GetHateRandom();
		
		if ($HateTarget)
		{
		$npc->SpellFinished(40050, $HateTarget);
		}
	quest::gmsay("AE CAST",13,0);
        $MAX_DMG_Decrease = $npc->GetMaxDMG(); 
		$New_MAX_DMG_Decrease = $MAX_DMG_Decrease - 500;
		quest::modifynpcstat("max_hit", $New_MAX_DMG_Decrease);
		quest::gmsay("new dmg $New_MAX_DMG_Decrease",13,0);	
	
	}
	
	if ($hpevent == 8){
	quest::setnexthpevent(6);
	quest::emote("begins to crumble");
	quest::spawn2(999995,1,0,446.6,699.7,-46.9,64.1);
	quest::spawn2(999996,1,0,445.5,632.5,-46.9,34.8);
	quest::npcsize(12);
	$HateTarget = $npc->GetHateRandom();
		
		if ($HateTarget)
		{
		$npc->SpellFinished(40050, $HateTarget);
		}
	
	quest::gmsay("AE CAST",13,0);
        $MAX_DMG_Decrease = $npc->GetMaxDMG(); 
		$New_MAX_DMG_Decrease = $MAX_DMG_Decrease - 500;
		quest::modifynpcstat("max_hit", $New_MAX_DMG_Decrease);
		quest::gmsay("new dmg $New_MAX_DMG_Decrease",13,0);	
	
	}
	
	if ($hpevent == 6){
	quest::setnexthpevent(4);
	quest::emote("begins to crumble");
	quest::spawn2(999995,1,0,446.6,699.7,-46.9,64.1);
	quest::spawn2(999996,1,0,445.5,632.5,-46.9,34.8);
	quest::npcsize(10);
	$HateTarget = $npc->GetHateRandom();
		
		if ($HateTarget)
		{
		$npc->SpellFinished(40050, $HateTarget);
		}
	quest::gmsay("AE CAST",13,0);	
	    $MAX_DMG_Decrease = $npc->GetMaxDMG(); 
		$New_MAX_DMG_Decrease = $MAX_DMG_Decrease - 500;
		quest::modifynpcstat("max_hit", $New_MAX_DMG_Decrease);
		quest::gmsay("new dmg $New_MAX_DMG_Decrease",13,0);
	
	}
	
	if ($hpevent == 4){
	quest::setnexthpevent(2);
	quest::emote("begins to crumble");
	quest::spawn2(999995,1,0,446.6,699.7,-46.9,64.1);
	quest::spawn2(999996,1,0,445.5,632.5,-46.9,34.8);
	quest::npcsize(8);
	$HateTarget = $npc->GetHateRandom();
		
		if ($HateTarget)
		{
		$npc->SpellFinished(40050, $HateTarget);
		}
	
	quest::gmsay("AE CAST",13,0);
        $MAX_DMG_Decrease = $npc->GetMaxDMG(); 
		$New_MAX_DMG_Decrease = $MAX_DMG_Decrease - 500;
		quest::modifynpcstat("max_hit", $New_MAX_DMG_Decrease);
		quest::gmsay("new dmg $New_MAX_DMG_Decrease",13,0);	
	
	}
	
	if ($hpevent == 2){
	quest::emote("begins to crumble");
	quest::spawn2(999995,1,0,446.6,699.7,-46.9,64.1);
	quest::spawn2(999996,1,0,445.5,632.5,-46.9,34.8);
	quest::npcsize(6);
	$HateTarget = $npc->GetHateRandom();
		
		if ($HateTarget)
		{
		$npc->SpellFinished(40050, $HateTarget);
		}
	quest::gmsay("AE CAST",13,0);	
	    $MAX_DMG_Decrease = $npc->GetMaxDMG(); 
		$New_MAX_DMG_Decrease = $MAX_DMG_Decrease - 500;
		quest::modifynpcstat("max_hit", $New_MAX_DMG_Decrease);
		quest::gmsay("new dmg $New_MAX_DMG_Decrease",13,0);
	
	}
}

sub EVENT_SIGNAL{

	if ($signal == "waterheal")
	{

	$HP_RATIO_CHK = int($npc->GetHPRatio());
	$Heal = ($HP_RATIO_CHK/100) + 0.01;
	$npc->SetHP($npc->GetMaxHP() * $Heal);	
	quest::me("The healing waters evaporate as they are absorbed by Crumble");
	quest::depopall(999994);
	}
}
	
sub EVENT_DEATH
{
    quest::emote("Crumble into dust");
    quest::shout2("I'm Melting! What a world, What a world!");
	quest::depopall(999998);
	quest::depopall(999997);
	quest::depopall(999996);
	quest::depopall(999995);
	quest::depopall(999994);
	quest::stopalltimers();
	return;

}



