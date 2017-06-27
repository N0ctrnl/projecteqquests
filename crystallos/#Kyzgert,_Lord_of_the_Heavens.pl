#Event Mobs:
#1000000 - Kyzgert, Lord of the Heavens
#1000001 - Sky Champion Kodo
#1000002 - Sky Protector Kudu



sub EVENT_SPAWN {
	undef $Death_Count;
	plugin::Debug("Spawn $mobid");
	quest::set_proximity($x-175,$x+175,$y-175,$y+175,$z-10,$z+10);
	#plugin::ModSpecialAttack
	#$npc->NPCSpecialAttacks("SERrFQMCNIDfABH", 1);
	quest::settimer("spawn_constants",5);
	
}

sub RemoveAggro
{
	$npc->NPCSpecialAttacks("ABHf", 0);
	$npc->WipeHateList();
	$npc->ModifyNPCStat("runspeed", 0);
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


sub EVENT_ENTER {

	quest::shout("So you are the mortals that have forsaken your own realm to defile ours? My scouts have warned me of your lust for power....");
	plugin::DoAnim("cast");
	quest::clear_proximity();
	quest::settimer("start",3);
	plugin::Debug("Prox cleared");
}

sub EVENT_HP {

	if ($hpevent == 6)
	{
	quest::signalwith(1000001,3,1);
	quest::signalwith(1000002,3,1);
	quest::shout("Rest Time is over demons!  KUDU!! KODO!! COME TO MY AID!");
	}
}

sub EVENT_TIMER {

	if ($timer eq "spawn_constants")
	{
	quest::stoptimer("spawn_constants");
	quest::spawn2(1000001,0,0,2126.9,2903.2,466.8,147.1);
	quest::spawn2(1000002,0,0,1817.9,2890.3,471.6,112.4);
	}

	if ($timer eq "start")
	{
	quest::stoptimer("start");
	quest::shout("You don't look very menacing. Granted anyone who could have bested my chief elementalist, and dear friend Trilon is no one to be taken lightly. Your journey ends here, however.");
	quest::signalwith(1000001,1,3000);
	}
	
	if ($timer eq "startsecond")
	{
	
	quest::stoptimer("startsecond");
	quest::shout("'Indeed, I am impressed. First Trilon, and now The Ancient brothers . I shall put an end to you myself.");
	quest::settimer("hate",4);
	}
	
	if ($timer eq "hate")
	{
	my $Random_Client = $entity_list->GetRandomClient($x, $y, $z, 1000);
	quest::ze(388,"Kyzgert Roars as he enters battle.");
	$npc->ModifyNPCStat("runspeed", 2.0);
	plugin::Debug("RUNSPEED SET");
	quest::stoptimer("hate");
	$npc->AddToHateList($Random_Client,0);
	plugin::Debug("HERE WE GO");
	}
}

sub EVENT_SIGNAL {


	if ($signal == 1)
	{
	plugin::Debug("Signal $signal Recieved");
	quest::shout("Very well then Kodo. You and your brother may do as you wish with them.");
	quest::signalwith(1000001,2,1);
	quest::signalwith(1000002,2,1);
	plugin::Debug("attack signal sent");
	}
	
	if ($signal == 2)
	{
	$Death_Count++;
	plugin::Debug("Signal $signal Recieved and deathcount is $Death_Count");
		if ($Death_Count == 2)
		{
		#$npc->NPCSpecialAttacks("ABH",1);
		quest::settimer("startsecond",3);
		quest::setnexthpevent(6);
		}
	}
}