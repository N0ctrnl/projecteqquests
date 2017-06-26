sub EVENT_SPAWN {

	#$npc->NPCSpecialAttacks("SERrFQMCNIDfABH", 1);
	$npc->SetFlyMode(2);
}

sub EVENT_HP {

	if ($hpevent == 11)
	{
	plugin::DoAnim("cast");
	quest::settimer("mainfight",1);
	quest::emote("backs away and falls to the ground.");
	}
}

sub EVENT_TIMER {

		if ($timer eq "HP_Balance")
	{
	quest::stoptimer("HP_Balance");
	
		my $OpponentID = $entity_list->GetNPCByNPCTypeID(1000002);
		
		if ($OpponentID)
		{
		my $Opponent_HP = int($OpponentID->GetHPRatio());
		my $npc_HP = int($npc->GetHPRatio());
		my $HP_DIFF = $npc_HP - $Opponent_HP;
		plugin::Debug("[$mname] $HP_DIFF");
		
			if ($HP_DIFF >= 5)
			{
			$npc->ModifyNPCStat("min_hit", $npc->GetMinDMG() + ($HP_DIFF * 500) );
			$npc->ModifyNPCStat("max_hit", $npc->GetMaxDMG() + ($HP_DIFF * 1000) );
			#Delay Attempt to check for 30 sec (thus must burn DPS on higher one)
			#$npc->SetEntityVariable(100, $npc->GetMaxDMG()); #Max
			#$npc->SetEntityVariable(101, $npc->GetMinDMG()); #Min
			quest::settimer("HP_Balance",30);
			#Add Emote!
			
			#Debug Data
			my $Mn = $npc->GetMinDMG();
			my $Mx = $npc->GetMaxDMG();
			plugin::Debug("$mname Boost [$HP_DIFF] Max: $Mx Min: $Mn");
			#$npc->CastSpell(19822,$mobid,0,0,0);
			$entity_list->MessageClose($npc, 1, 400, 15, "As the balance of power shifts, Kyzgert Imbues Kudu with more power."); 
			}
			
			else
			{
			quest::settimer("HP_Balance",6);
			}
		}
	
	}

	if ($timer eq "mainfight")
	{
	quest::signalwith(1000000,2,0);
	#$npc->NPCSpecialAttacks("ABHf",0);
	quest::modifynpcstat("runspeed",0.0);
	quest::stoptimer("mainfight");
	$npc->WipeHateList();
	#$npc->GMMove(1817.9,2890.3,471.6,112.4);
	$npc->GMMove(2126.9,2903.2,466.8,147.1);
	quest::settimer("die",1);
	plugin::Debug("Death Signal Sent");
	}
	
	if ($timer eq "die")
	{
	RemoveAggro();
	quest::stoptimer("die");
	plugin::SetAnim("dead");
	}
}

sub EVENT_SIGNAL {


	if ($signal == 1)
	{
	quest::shout("My lord, if I may. My brother and I haven't feasted on morsels this succulent in aoens.");
	$entity_list->MessageClose($npc, 1, 20000, 314, "Sky Protector Kudu Beams a smile at his brother.");
	quest::signalwith(1000000,1,3000);
	}


	if ($signal == 2)
	{
	my $Random_Client = $entity_list->GetRandomClient($x, $y, $z, 2000);
		if ($Random_Client)
		{
		#$npc->NPCSpecialAttacks("ABH",1);
		$npc->AddToHateList($Random_Client,0);
		quest::settimer("HP_Balance",1);
		quest::setnexthpevent(11);
		plugin::Debug("ATTACK KODO!");
		}
			
			else {plugin::Debug("NO CLIENT");}
	
	}
	
	if ($signal == 3)
	{
	my $Random_Client = $entity_list->GetRandomClient($x, $y, $z, 1000);
	#$npc->NPCSpecialAttacks("ABHS",1);
	quest::modifynpcstat("runspeed",2.0);
		if ($Random_Client)
		{
		$npc->AddToHateList($Random_Client,0);
		}
		else {plugin::Debug("NO CLIENT");}
	}
	
}

sub RemoveAggro
{
	#$npc->NPCSpecialAttacks("ABHf", 0);
	$npc->WipeHateList();
	#$npc->ModifyNPCStat("runspeed", 0);
	quest::stopalltimers();
	
	#Wipe Pet Hatelists
	my @npclist = $entity_list->GetNPCList();
      		
		foreach $cur (@npclist)
		{
			if ($cur)
			{
				if ($cur->GetOwnerID() >= 1)
				{
				$cur->WipeHateList();
				}
			}
		}
	
	plugin::Debug("Remove Aggro: Status END");
	return 1;
}