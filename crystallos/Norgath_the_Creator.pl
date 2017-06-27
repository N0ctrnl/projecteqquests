# Norgath - 1000200
# a_young_crystallosian - 1000201
# trap NE - 1000202
# trap SE - 1000203
# trap SW - 1000204
# trap NW - 1000205

sub EVENT_SAY {

 my $info = quest::saylink("information");
 my $new = quest::saylink("new");
 my $past = quest::saylink("past");
 my $help = quest::saylink("help");

	if ($text =~/Hail/i)
	{
	quest::shout("Someday Kris will finish my coding so i can whack some players and rejoice."); 
	quest::setnexthpevent(96);
	plugin::Debug("HIT HIM!");
	}


}

sub EVENT_HP {
	$Random_Trap=quest::ChooseRandom(1000202 , 1000203, 1000204 , 1000205);
	if ($hpevent == 96)
	{
	quest::signalwith($Random_Trap,1,0);
	quest::setnexthpevent(91);
	}
	if ($hpevent == 91)
	{
	quest::signalwith($Random_Trap,1,0);
	quest::setnexthpevent(86);
	}
	if ($hpevent == 86)
	{
	quest::signalwith($Random_Trap,1,0);
	quest::setnexthpevent(81);
	}
	if ($hpevent == 81)
	{
	quest::signalwith($Random_Trap,1,0);
	quest::setnexthpevent(76);
	}
	if ($hpevent == 76)
	{
	quest::signalwith($Random_Trap,1,0);
	quest::setnexthpevent(71);
	}
	if ($hpevent == 71)
	{
	quest::signalwith($Random_Trap,1,0);
	quest::setnexthpevent(66);
	}
	if ($hpevent == 66)
	{
	quest::signalwith($Random_Trap,1,0);
	quest::setnexthpevent(61);
	}
	if ($hpevent == 61)
	{
	quest::signalwith($Random_Trap,1,0);
	quest::setnexthpevent(56);
	}
	if ($hpevent == 56)
	{
	quest::signalwith($Random_Trap,1,0);
	quest::setnexthpevent(51);
	}
	if ($hpevent == 51)
	{
	quest::signalwith($Random_Trap,1,0);
	quest::setnexthpevent(46);
	}
	
}

sub EVENT_SIGNAL {

	if ($signal == 1)
	{
	$npc->WipeHateList();
	quest::emote("is caught in the trap, unable to move.");
	$npc->SetBodyType(11);
	#$npc->NPCSpecialAttacks("ABH",0);
	quest::modifynpcstat("runspeed",0);
	$npc->WipeHateList();
	$npc->SetOOCRegen(0);
	#quest::stop();
	quest::settimer("adds1",1);
	plugin::SetAnim("dead");
	plugin::Debug("Signal [$signal] recieved");
	}
	
	if ($signal == 2)
	{
	$Death_Count++;
	plugin::Debug("Signal $signal Recieved and deathcount is $Death_Count");
		if ($Death_Count == 6)
		{
		quest::modifynpcstat("runspeed",1.25);
		$npc->SetBodyType(26);
		#$npc->NPCSpecialAttacks("ABH",1);
		quest::signalwith(1000202,2,0);
		quest::signalwith(1000203,2,0);
		quest::signalwith(1000204,2,0);
		quest::signalwith(1000205,2,0);
			my $Random_Client = $entity_list->GetRandomClient($x, $y, $z, 3000);
			if ($Random_Client)
			{
			$npc->AddToHateList($Random_Client,0);
			undef $Death_Count;
			}
		}
	}
}

sub EVENT_TIMER {
	$Random_Spawn=quest::ChooseRandom(1,2,3,4,5,6,7,8,9,10,11,12);
	if ($timer eq "adds1")
	{
	quest::stoptimer("adds1");
	$entity_list->MessageClose($npc, 1, 20000, 314, "you hear the sound of eggs cracking.");
		if ($Random_Spawn==1)
		{
		quest::spawn2(1000201,0,0,-1237.1,-461.6,-458.4,62.5);
		quest::spawn2(1000201,0,0,-1237.1+5,-461.6,-458.4,62.5);
		quest::spawn2(1000201,0,0,-1237.1-5,-461.6,-458.4,62.5);
		quest::spawn2(1000201,0,0,-1237.1,-461.6+5,-458.4,62.5);
		quest::spawn2(1000201,0,0,-1237.1,-461.6-5,-458.4,62.5);
		quest::spawn2(1000201,0,0,-1237.1+5,-461.6-5,-458.4,62.5);
		}
		if ($Random_Spawn==2)
		{
		quest::spawn2(1000201,0,0,-1233.5,-352.5,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1233.5+5,-352.5,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1233.5-5,-352.5,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1233.5,-352.5+5,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1233.5,-352.5-5,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1233.5,+5-352.5-5,-458.4,64.4);
		}
		if ($Random_Spawn==3)
		{
		quest::spawn2(1000201,0,0,-1232.5,-241.5,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1232.5+5,-241.5,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1232.5-5,-241.5,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1232.5,-241.5+5,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1232.5,-241.5-5,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1232.5,+5-241.5-5,-458.4,64.4);
		}
		if ($Random_Spawn==4)
		{
		quest::spawn2(1000201,0,0,-1114.5,-244.5,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1114.5+5,-244.5,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1114.5-5,-244.5,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1114.5,-244.5+5,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1114.5,-244.5-5,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1114.5,+5-244.5-5,-458.4,64.4);
		}
		if ($Random_Spawn==5)
		{
		quest::spawn2(1000201,0,0,-1111.5,-351.5,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1111.5+5,-351.5,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1111.5-5,-351.5,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1111.5,-351.5+5,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1111.5,-351.5-5,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1111.5,+5-351.5-5,-458.4,64.4);
		}
		if ($Random_Spawn==6)
		{
		quest::spawn2(1000201,0,0,-1114.7,-462.8,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1114.7_5,-462.8,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1114.7-5,-462.8,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1114.7,-462.8+5,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1114.7,-462.8-5,-458.4,64.4);
		quest::spawn2(1000201,0,0,-1114.7+5,-462.8-5,-458.4,64.4);
		}
		if ($Random_Spawn==7)
		{
		quest::spawn2(1000201,0,0,-880.0,-464.9,-458.4,64.4);
		quest::spawn2(1000201,0,0,-880.0,-464.9,-458.4,64.4);
		quest::spawn2(1000201,0,0,-880.0,-464.9,-458.4,64.4);
		quest::spawn2(1000201,0,0,-880.0,-464.9,-458.4,64.4);
		quest::spawn2(1000201,0,0,-880.0,-464.9,-458.4,64.4);
		quest::spawn2(1000201,0,0,-880.0,-464.9,-458.4,64.4);
		}
		if ($Random_Spawn==8)
		{
		quest::spawn2(1000201,0,0,-882.4,-352.8,-458.4,64.4);
		quest::spawn2(1000201,0,0,-882.4,-352.8,-458.4,64.4);
		quest::spawn2(1000201,0,0,-882.4,-352.8,-458.4,64.4);
		quest::spawn2(1000201,0,0,-882.4,-352.8,-458.4,64.4);
		quest::spawn2(1000201,0,0,-882.4,-352.8,-458.4,64.4);
		quest::spawn2(1000201,0,0,-882.4,-352.8,-458.4,64.4);
		}
		if ($Random_Spawn==9)
		{
		quest::spawn2(1000201,0,0,-881.9,-244.8,-458.4,64.4);
		quest::spawn2(1000201,0,0,-881.9,-244.8,-458.4,64.4);
		quest::spawn2(1000201,0,0,-881.9,-244.8,-458.4,64.4);
		quest::spawn2(1000201,0,0,-881.9,-244.8,-458.4,64.4);
		quest::spawn2(1000201,0,0,-881.9,-244.8,-458.4,64.4);
		quest::spawn2(1000201,0,0,-881.9,-244.8,-458.4,64.4);
		}
		if ($Random_Spawn==10)
		{
		quest::spawn2(1000201,0,0,-754.3,-240.8,-458.4,64.4);
		quest::spawn2(1000201,0,0,-754.3,-240.8,-458.4,64.4);
		quest::spawn2(1000201,0,0,-754.3,-240.8,-458.4,64.4);
		quest::spawn2(1000201,0,0,-754.3,-240.8,-458.4,64.4);
		quest::spawn2(1000201,0,0,-754.3,-240.8,-458.4,64.4);
		quest::spawn2(1000201,0,0,-754.3,-240.8,-458.4,64.4);
		}
		if ($Random_Spawn==11)
		{
		quest::spawn2(1000201,0,0,-753.9,-352.8,-458.4,64.4);
		quest::spawn2(1000201,0,0,-753.9,-352.8,-458.4,64.4);
		quest::spawn2(1000201,0,0,-753.9,-352.8,-458.4,64.4);
		quest::spawn2(1000201,0,0,-753.9,-352.8,-458.4,64.4);
		quest::spawn2(1000201,0,0,-753.9,-352.8,-458.4,64.4);
		quest::spawn2(1000201,0,0,-753.9,-352.8,-458.4,64.4);
		}
		if ($Random_Spawn==12)
		{
		quest::spawn2(1000201,0,0,-758.9,-462.4,-458.4,64.4);
		quest::spawn2(1000201,0,0,-758.9,-462.4,-458.4,64.4);
		quest::spawn2(1000201,0,0,-758.9,-462.4,-458.4,64.4);
		quest::spawn2(1000201,0,0,-758.9,-462.4,-458.4,64.4);
		quest::spawn2(1000201,0,0,-758.9,-462.4,-458.4,64.4);
		quest::spawn2(1000201,0,0,-758.9,-462.4,-458.4,64.4);
		}
	}
}
