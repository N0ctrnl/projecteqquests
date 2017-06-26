sub EVENT_SAY {

	quest::settimer("Divine_Damage", 6);

}


sub EVENT_SPAWN {

	quest::settimer("Spawn_Constants", 3);
	quest::emote("prays.");
	quest::delglobal("Rev_Door_Close");

}


sub EVENT_COMBAT { 

	if ($combat_state == 1)
	{
		quest::shout("You dare enter the Chapel of the Third Order! You will no salvation here!");
		quest::say("Cleanse them of their sin...");
		quest::settimer("Check_HP", 6);
		quest::settimer("Black_Pox", 10);
		quest::settimer("Duck", 25);
		quest::setglobal("Rev_Door_Close", 1, 7, "F");
		quest::settimer("Decrease_Resist", 30);
		quest::doanim(44);
		$entity_list->MessageClose($npc, 1, 300, 264, "Reverend Daignal begins to cast a spell. (Pious Barrier)");
		$entity_list->MessageClose($npc, 1, 300, 264, "Reverend Daignal is surrounded by a invulnerable aura.");
		quest::stoptimer("Reset");

		my @moblist = $entity_list->GetMobList();

		foreach $cur (@moblist)
		{
			$CheckID = $cur->GetNPCTypeID();			
			if ($CheckID == 859041)
			{
				$cur->NPCSpecialAttacks("SEFRQMCIDNf", 0);
			}
			if ($CheckID == 859042)
			{
				$cur->NPCSpecialAttacks("SEFRQMCIDNf", 0);
			}
		}
	}

	if ($combat_state == 0)
	{
		quest::settimer("Reset", 15);
	}

}


sub EVENT_TIMER {

	# Currently this does nothing
	if ($timer eq "LoS")
	{
		my $Target_Cl = $npc->GetTarget();
		if ($Target_Cl)
		{
			my $Target_ID = $Target_Cl->GetID();
			my $LoS_Check = $npc->CheckLoS($Target_Cl);
			#$Target_Cl->CastSpell(5244, $Target_ID);
		}
	}

	if ($timer eq "Spawn_Constants")
	{
		quest::stoptimer("Spawn_Constants");
		quest::spawn2(859042,0,0, -894.7, 2261.6, -151, 185.8);
		quest::spawn2(859041,0,0, -887.5, 2191.5, -151.0, 185.9);
		$npc->NPCSpecialAttacks("ABf", 0);
	}

	if ($timer eq "Reset") {
		undef $Death_Count;
		quest::stoptimer("Reset");
		$npc->NPCSpecialAttacks("ABH", 0);
		quest::settimer("Spawn_Constants", 5);
		quest::stoptimer("Black_Pox");
		quest::stoptimer("Check_HP");
		quest::stoptimer("Duck");
		quest::stoptimer("Cleanse");
		quest::stoptimer("Divine_Damage");
		quest::stoptimer("Stop_Divine_Damage");
		quest::stoptimer("Divine_Aura");
		quest::stoptimer("LoS");
		$npc->WipeHateList();
		undef $CS_PERM_OFF;
		quest::depopall(859042);
		quest::depopall(859041);
		quest::emote("calms down.");
		$npc->GMMove(-866, 2228.8, -147.5, 187.2);
		quest::modifynpcstat("runspeed", 0.00001);
		quest::delglobal("Rev_Door_Close"); 
	}

	# Test Timer for aggro check
	if ($timer eq "Check_Aggro")
	{
		quest::stoptimer("Check_Aggro");

		my @hatelist = $npc->GetHateList(); 

		foreach $ent (@hatelist)
		{
			my $h_ent = $ent->GetEnt();
			#my $h_dmg = $ent->GetDamage();
			#my $h_hate = $ent->GetHate();
			$Check_Hate = 1;

			if ($h_ent)
			{
				$h_ent->Message(263, "TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST ");
			}
		}

		if ($Check_Hate == 1)
		{
		
		}
		if ($Check_Hate != 1)
		{
		
		}
	}

	if ($timer eq "DoAnim")
	{
		quest::stoptimer("DoAnim");
		if ($Random_Anim == 44)
		{
			quest::emote("continues his prayer.");
			quest::doanim($Random_Anim);
		}
	}

	if ($timer eq "Cleanse")
	{
		quest::stoptimer("Cleanse");
		quest::settimer("Cleanse", 80);
		$npc->CastSpell(3791, $mobid);
		quest::emote("feels a divine cleansing.");
	}

	if ($timer eq "Black_Pox")
	{
		quest::stoptimer("Black_Pox");
		#$TimerA = quest::ChooseRandom(45);
		quest::settimer("Black_Pox", 45);
		quest::emote("whispers a dark prayer.");
		$npc->CastSpell(5074, $mobid);
	}

	if ($timer eq "Decrease_Resist")
	{
		quest::stoptimer("Decrease_Resist");
		quest::settimer("Decrease_Resist", 30);
		plugin::CastOnTarget(8844);
	}

	if ($timer eq "Duck") {
		quest::stoptimer("Duck");
		$Next_Duck = int(rand(25))+45;
		undef $STOP_Nuke;

		my @hatelist = $npc->GetHateList(); 

		foreach $ent (@hatelist)  {

			my $h_ent = $ent->GetEnt();
			#my $h_dmg = $ent->GetDamage();
			#my $h_hate = $ent->GetHate();

			if (($h_ent) && ($STOP_Nuke != 1))
			{
				#my $ent_X = $h_ent->GetX();
				#my $ent_Y = $h_ent->GetY();
				#my $ent_Z = $h_ent->GetZ();
				my $NPC_X = $npc->GetX();
				my $NPC_Y = $npc->GetY();
				my $NPC_Z = $npc->GetZ();	
				$distanceCHK = $h_ent->CalculateDistance($NPC_X, $NPC_Y, $NPC_Z );
				my $Get_Nuked = quest::ChooseRandom(1,2,3,4,5,6,7,8,9,10,11,12);
				#quest::shout("$Get_Nuked");

				if (($distanceCHK <= 300) && ($Get_Nuked == 1))
				{
					#my $Target_Spell_ID = $h_ent->GetID;
					my $Target_Name = $h_ent->GetCleanName();
					$entity_list->MessageClose($npc, 1, 600, 335, "Reverend Daignal shouts, 'To your knee's $Target_Name and pray before me!'.");
					$h_ent->Message(335, "You body is struck by an overwhelming presence causing you to bend to Daignal's will." );
					#my $Client_Duck = $entity_list->GetClientByID($Target_Spell_ID);
					#$Client_Duck->Stun(1000);
					#$Client_Duck->Duck();
					$h_ent->Stun(1000);
					$h_ent->Duck();
					$STOP_Nuke = 1;
				}
			}

		}

		if ($STOP_Nuke != 1)
		{
			quest::settimer("Duck", 1);
			#$STOP_Nuke = 1;
		}
	}

	if ($timer eq "Check_HP")
	{
		quest::stoptimer("Check_HP");
		quest::settimer("Check_HP", 6);


		#my @moblist = $entity_list->GetMobList();
		my @npclist = $entity_list->GetNPCList();
		
		my $CheckHP_Y = 0;
		my $CheckHP_J = 0;
		
		foreach $cur (@npclist)
		{
			$CheckID = $cur->GetNPCTypeID();
								
			if ($CheckID == 859041)
			{
				$CheckHP_Y = $cur->GetHPRatio();
				$CheckHP_Yf = $cur->GetHP();
				#$Crusader_Y = $cur;
				#$Crusader_Yid = $cur->GetID();
				$Crusader_Yid = $CheckID;
			}

			if ($CheckID == 859042)
			{
				$CheckHP_J = $cur->GetHPRatio();
				$CheckHP_Jf = $cur->GetHP();
				#$Crusader_J = $cur;
				#$Crusader_Jid = $cur->GetID();
				$Crusader_Jid = $CheckID;
			}
		}

		if ($CheckHP_J && $CheckHP_Y > $CheckHP_J)
		{
			$Difference_Check = $CheckHP_Y - $CheckHP_J; 
			$Difference_Full_HP = $CheckHP_Yf - $CheckHP_Jf;
			$Difference_Full_HP_Split = $Difference_Full_HP * 0.5;

			if ($Difference_Check > 3)
			{
				$Npc_Name = $npc->GetCleanName();
				$Crusader_Y = $entity_list->GetMobByNpcTypeID($Crusader_Yid);
				$Crusader_J = $entity_list->GetMobByNpcTypeID($Crusader_Jid);
				$entity_list->MessageClose($npc, 1, 700, 263, "$Npc_Name begins to cast a spell. (Balance of Dranik)");
				quest::doanim(44);
				if ($Crusader_Y)
				{
					$Crusader_Y_HP_Now = $Crusader_Y->GetHP();
					$Crusader_Y_HP_Now_Final = $Crusader_Y_HP_Now - $Difference_Full_HP_Split ;
					$Crusader_Y->SetHP($Crusader_Y_HP_Now_Final);
					$Crusader_Y->DoAnim(7,44);
				}

				if ($Crusader_J)
				{
					$Crusader_J_HP_Now = $Crusader_J->GetHP();
					$Crusader_J_HP_Now_Final = $Crusader_J_HP_Now + $Difference_Full_HP_Split ;
					$Crusader_J->SetHP($Crusader_J_HP_Now_Final);
					$Crusader_J->DoAnim(7,44);
				}
				
				$Difference_Check_Int = int($Difference_Check);
				quest::signalwith(859041, $Difference_Check_Int, 0);
				quest::signalwith(859042, $Difference_Check_Int, 0);
			}
		}

		if ($CheckHP_Y && $CheckHP_J > $CheckHP_Y)
		{
			$Difference_Check = $CheckHP_J - $CheckHP_Y; 
			$Difference_Full_HP = $CheckHP_Jf - $CheckHP_Yf;
			$Difference_Full_HP_Split = $Difference_Full_HP * 0.5;

			if ($Difference_Check > 3)
			{
				$Crusader_Y = $entity_list->GetMobByNpcTypeID($Crusader_Yid);
				$Crusader_J = $entity_list->GetMobByNpcTypeID($Crusader_Jid);
				#quest::shout("$Difference_Check = $CheckHP_J - $CheckHP_Y;  for J > Y");
				if ($Crusader_Y)
				{
					$Crusader_Y_HP_Now = $Crusader_Y->GetHP();
					$Crusader_Y_HP_Now_Final = $Crusader_Y_HP_Now + $Difference_Full_HP_Split ;
					$Crusader_Y->SetHP($Crusader_Y_HP_Now_Final);
					$Crusader_Y->DoAnim(7,44);
				}

				if ($Crusader_J)
				{
					$Crusader_J_HP_Now = $Crusader_J->GetHP();
					$Crusader_J_HP_Now_Final = $Crusader_J_HP_Now - $Difference_Full_HP_Split ;
					$Crusader_J->SetHP($Crusader_J_HP_Now_Final);
					$Crusader_J->DoAnim(7,44);
				}

				$Difference_Check_Int = int($Difference_Check);
				quest::signalwith(859041, $Difference_Check_Int, 0);
				quest::signalwith(859042, $Difference_Check_Int, 0);
				##quest::shout("$Difference_Full_HP");
			}
		}

	}

	if ($timer eq "Divine_Aura")
	{
		quest::stoptimer("Divine_Aura");
		quest::settimer("Divine_Damage", 6);
		quest::settimer("Stop_Divine_Damage", 30);
		#$NPC_NAME = $npc->GetCleanName();
		$entity_list->MessageClose($npc, 1, 300, 15, "Reverend Daignal raises both arms in the air and calls out a ancient prayer.");
		quest::emote("body begins to glow with a pale light.");
		quest::doanim(44);

		my @hatelist = $npc->GetHateList(); 

		foreach $ent (@hatelist)
		{
			my $h_ent = $ent->GetEnt();
			#my $h_dmg = $ent->GetDamage();
			#my $h_hate = $ent->GetHate();

			if ($h_ent)
			{
		
				#my $ent_X = $h_ent->GetX();
				#my $ent_Y = $h_ent->GetY();
				#my $ent_Z = $h_ent->GetZ();
				my $NPC_X = $npc->GetX();
				my $NPC_Y = $npc->GetY();
				my $NPC_Z = $npc->GetZ();	
				$distanceCHK = $h_ent->CalculateDistance($NPC_X, $NPC_Y, $NPC_Z );
		
				if ($distanceCHK <= 350)
				{
					$Client_ID = $h_ent->GetID();
					$h_ent->InterruptSpell(13);
					$h_ent->CastSpell(2741, $Client_ID);
					$h_ent->SetHP($h_ent->GetMaxHP());
					#$h_ent->Message(15, "You feel divine barrier over come you. ");
				}
			}
		}
	}

	if ($timer eq "Divine_Damage")
	{
		$NPC_NAME = $npc->GetCleanName();
		$entity_list->MessageClose($npc, 1, 200, 264, "$NPC_NAME begins to cast a spell. (Celestrial Supernova)");
		$entity_list->MessageClose($npc, 1, 200, 264, "$NPC_NAME releases a wave of pure white light.");
		quest::doanim(44);

		my @hatelist = $npc->GetHateList(); 

		foreach $ent (@hatelist)
		{
			my $h_ent = $ent->GetEnt();
			#my $h_dmg = $ent->GetDamage();
			#my $h_hate = $ent->GetHate();

			if ($h_ent)
			{
				#my $ent_X = $h_ent->GetX();
				#my $ent_Y = $h_ent->GetY();
				#my $ent_Z = $h_ent->GetZ();
				my $NPC_X = $npc->GetX();
				my $NPC_Y = $npc->GetY();
				my $NPC_Z = $npc->GetZ();	
				$distanceCHK = $h_ent->CalculateDistance($NPC_X, $NPC_Y, $NPC_Z );
			
				if ($distanceCHK <= 350)
				{
					$Class_ID = $h_ent->GetClass();
					$Check_Buff = $h_ent->FindBuff(2741);

					if ($Check_Buff == 1)
					{
						if (($Class_ID == 2) || ($Class_ID == 6) || ($Class_ID == 10) || ($Class_ID == 11) || ($Class_ID == 12) || ($Class_ID == 13) || ($Class_ID == 14))
						{
							$h_ent->Damage($npc,  7500 , 5737, 1, 1, -1, 0);
							#$Player_Name = $h_ent->GetCleanName();
							$h_ent->Message(15, "The sacred barrier amplifies the holy light");
							$h_ent->Message(263, "You are outlined in pure white flames.");
						}
						else
						{
							$h_ent->Damage($npc,  11000 , 5737, 1, 1, -1, 0);
							#$Player_Name = $h_ent->GetCleanName();
							$h_ent->Message(26, "The sacred barrier amplifies the holy light.");
							$h_ent->Message(263, "You are outlined in pure white flames.");
						}
					}
				}
			}
		}
	}

	if ($timer eq "Stop_Divine_Damage")
	{
		quest::stoptimer("Stop_Divine_Damage");
		quest::stoptimer("Divine_Damage");
		quest::emote("glow fades.");
		quest::settimer("Divine_Aura", 60);
	}

}

    
sub EVENT_SIGNAL {

	if ($signal == 1)
	{
		$Death_Count++;
		if ($Death_Count == 2)
		{ 
			#quest::shout("You will now face the judgment of the gods! You dare desicrate my temple!");
			quest::modifynpcstat("runspeed", 1.25);
			quest::stoptimer("DBarrier");
			$npc->BuffFadeAll();
			quest::stoptimer("Check_HP");
			quest::settimer("Decrease_Resist", 5);
			quest::settimer("Cleanse", 1);
			quest::settimer("Divine_Aura", 35);
			#quest::settimer("LoS", 6);
			$npc->WipeHateList();
			$npc->NPCSpecialAttacks("SFQMCIDf", 0);
			$npc->MoveTo(-994.7, 2221.1, -159.2);
		}
	}

}


sub EVENT_DEATH {

	quest::say("I may have failed but others will not...");
	quest::emote("falls silent.");
	quest::delglobal("Rev_Door_Close");
	$timestamp = localtime(time);
	quest::write("text_files/Dranik_Kill.txt","[$timestamp]:$mname was killed by $name the $class.");

}
