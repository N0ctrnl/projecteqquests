#sub EVENT_SAY {
#quest::settimer("Check_Weapons",1);
#quest::emote("GM ACTION");
#}

sub EVENT_SPAWN {
	
	
	quest::emote("materializes.");
	quest::settimer("Spawn_Constants",1);
	quest::set_proximity( $x-330,$x+330,$y-330,$y+330,$z-1000,$z+1000);
	$MAX_DMG_Boost = $npc->GetMaxDMG(); 
	plugin::Debug("Max Damamge [$MAX_DMG_Boost] ");
	$npc->SetEntityVariable(1000, 0);
	undef $EVENT_START;
	undef $HP_RATIO_CHK;
	undef $Ture_Activiated;
	undef $Shadowbeast_Activiated;
	undef $Barrier_Active;
	undef $HP_RATIO_Check;
	$DISABLED = 0;
	
}

#Add root snare breaks

sub EVENT_ENTER {

	if ($EVENT_START != 1)
	{
		quest::settimer("SEQ1",2);
		$EVENT_START = 1; 
		plugin::Debug("[$mname] Prox Enter ");
	}

}

sub EVENT_COMBAT { 

	if ($combat_state == 1)
	{
		quest::stoptimer("Reset");
		plugin::Debug("[$mname] Reset Aborted");
	}

	if (!$combat_state)
	{
		$CheckH = $npc->HasNPCSpecialAtk("H");
		$HP_RATIO_CHK = int($npc->GetHPRatio());
		if (($CheckH != 1) && ($HP_RATIO_CHK <= 99) && ($Warp_Mode == 0))
		{
			quest::settimer("Reset", 30);
		}
	}
}

sub EVENT_HP {

	$HP_RATIO_CHK = int($npc->GetHPRatio());
	plugin::Debug("[$mname] HP Ratio $HP_RATIO_CHK <> HP Event $hpevent | Next Barrier  $Barrier_End");

	if($hpevent == 99)
	{
		$nexthp = $hpevent - 1;
		quest::setnexthpevent($nexthp);
	}

	if($hpevent == $nexthp)
	{
		$nexthp = $hpevent - 1; 
		quest::setnexthpevent($nexthp);
	}

	if ($Barrier_End && ($HP_RATIO_CHK <= $Barrier_End) && ($HP_RATIO_CHK > 25))
	{
		undef $Barrier_End;
		quest::stoptimer("Barrier");
		quest::settimer("Warp",1);
		$Warp_Count = 1;
		$Warp_Count_End = quest::ChooseRandom(5,6,7);
		$Warp_Mode = 1;
	}

	if ($hpevent == 80) { quest::settimer("5676",1); }
	if ($hpevent == 60) { quest::settimer("5675",1); }
	if ($hpevent == 40) { quest::settimer("5678",1); }
	if ($hpevent == 20) { quest::settimer("5677",1); }

	if (($HP_RATIO_CHK <= 70) && ($Warp_Mode == 0) && ($Ture_Activiated != 1))
	{
		$Ture_Activiated = 1;
		quest::doanim(42);
		quest::shout("Come forth Ture! My trusted mount, aid me in destroying these pathetic creatures!");
		$entity_list->MessageClose($npc, 1, 2000, 263, "Ivesi`Vok Muram begins to cast a spell. (Summon Mount)");
		$entity_list->MessageClose($npc, 1, 2000, 263, "Ivesi`Vok Muram calls forth a legendary beast.");
		quest::spawn2(859246,0,0, 55, 197, -247.4, 120);
	}

	if (($HP_RATIO_CHK <= 35) && ($Warp_Mode == 0) && ($Shadowbeast_Activiated != 1))
	{
		$Shadowbeast_Activiated = 1;
		$entity_list->MessageClose($npc, 1, 2000, 263, "Ivesi`Vok Muram begins to cast a spell. (Summon Shadowbeasts)");
		$entity_list->MessageClose($npc, 1, 2000, 263, "Ivesi`Vok Muram calls forth a two horrifying creatures.");
		quest::shout("Your battle prowiness is impressive! You would have made a nice addition to my army if you only were you willful! It's shame you will now
		only be snacks for my beasts.");
		quest::spawn2(859247,0,0, $x + 100, $y, $z, 126);
		quest::spawn2(859248,0,0, $x - 100, $y, $z, 126);
	}

	if ( ($HP_RATIO_CHK <= 10) && ($Warp_Mode == 0) && ($End_Start != 1) )
	{
		quest::settimer("END1",1);
		$End_Start = 1;
		quest::stoptimer("Stat_Boost");
	}

	if ( ($HP_RATIO_CHK <= 6) && ($Warp_Mode == 0) )
	{
		quest::doanim(44);
		$entity_list->MessageClose($npc, 1, 20000, 263, "Ivesi`Vok begins to cast a spell. (Discordant Light)'");
		$entity_list->MessageClose($npc, 1, 20000, 263, "Ivesi`Vok wounds close.");
		$HP_RATIO_CHK = int($npc->GetHPRatio());
		$Heal = ($HP_RATIO_CHK/100) + 0.06;
		$npc->SetHP($npc->GetMaxHP() * $Heal);
		$HP_RATIO_CHK = int($npc->GetHPRatio());
		$nexthp = $HP_RATIO_CHK - 1; 
		quest::setnexthpevent($nexthp);
	}

}

sub EVENT_TIMER {

	plugin::Debug("[$mname] Timer < $timer >");

	
	#30036 Slash
	#30037 Blunt
	#30038 Pierce
	#30039 Range [HOLD]
	#30040 Fist

	#30042	Cold Spell Vulnerability V
	#30043	Fire Spell Vulnerability V
	#30044	Infection Spell Vulnerability V
	#30045	Magic Spell Vulnerability V

	if ($timer eq "Reset") {
		quest::stoptimer("Reset");
		$CheckH = $npc->HasNPCSpecialAtk("H");
		$HP_RATIO_CHK = int($npc->GetHPRatio());
		if (($CheckH != 1) && ($HP_RATIO_CHK <= 99) && ($Warp_Mode == 0))
		{
			quest::repopzone();
		}
	}


	if ($timer eq "Spawn_Constants")
	{
		quest::stoptimer("Spawn_Constants");
		$npc->SetAppearance(1);
		undef $Barrier_End;
		undef $Warp_Count;
		undef $Shadowbeast_Activiated;
		undef $Ture_Activiated;
		undef $End_Start;
		undef $HP_RATIO_Check;
		quest::setnexthpevent(99);
		$Warp_Mode = 0;
		quest::depopall(859214); quest::depopall(859244);quest::depopall(859245);
		quest::spawn2(859214, 0 ,0, -63.903564453125, 277.782470703125, -249.702560424805 , 125.125);
		quest::spawn2(859244, 0 ,0, 297.718627929688, 145.075454711914, -207.203109741211 , 193.375);
		quest::spawn2(859244, 0 ,0, 238.787231445312, 233.938812255859, -207.203109741211 , 161.625);
		quest::spawn2(859244, 0 ,0, -240.816452026367, 55.550365447998, -207.203125 , 34.125);
		quest::spawn2(859244, 0 ,0, -298.234405517578, 144.825103759766, -207.203125 , 62.75);
		quest::spawn2(859244, 0 ,0, -238.905517578125, 234.917602539062, -207.203125 , 102);
		quest::spawn2(859244, 0 ,0, 242.050704956055, 55.0382270812988, -207.203125 , 226.125);
		quest::spawn2(859245, 0 ,0, -0.499285012483597, 162.242645263672, -249.702560424805 , 254.75);
		quest::spawn2(859245, 0 ,0, -35.1116180419922, 216.80973815918, -249.702560424805 , 78.125);
		quest::spawn2(859245, 0 ,0, 1.54786896705627, 233.013748168945, -249.702560424805 , 132.875);
		quest::spawn2(859245, 0 ,0, 31.4462833404541, 220.30549621582, -249.702560424805 , 155.5);
		quest::spawn2(859245, 0 ,0, 37.7230644226074, 197.096298217773, -249.702560424805 , 186.375);
		quest::spawn2(859245, 0 ,0, 30.6273326873779, 168.279678344727, -249.702560424805 , 219.25);
		quest::spawn2(859245, 0 ,0, -24.638334274292, 168.257873535156, -249.702560424805 , 36.25);
		quest::spawn2(859245, 0 ,0, -40.721263885498, 196.098968505859, -249.702560424805 , 61.5);
		quest::spawn2(859214, 0 ,0, 66.3286666870117, 279.008422851562, -249.702560424805 , 133.125);
		quest::stoptimer("Root_Snare_Break");
		quest::stoptimer("5675");
		quest::stoptimer("5678");
		quest::stoptimer("5677");
		quest::stoptimer("5680");
		quest::stoptimer("5676");
		quest::stoptimer("End_HP_CHECK");
		quest::stoptimer("Check_Weapons");
		quest::stoptimer("Gaze");
		quest::stoptimer("Stat_Boost");
		quest::stoptimer("Barrier");
		quest::stoptimer("Warp");
		quest::stoptimer("Kill_Shot");
		quest::stoptimer("End_HP_CHECK");
	}

	#Spells#

	#Relquish of Spirits 3
	if ($timer eq "5675")
	{
		quest::stoptimer("5675");
		my $Next_5675 = int(rand(90))+90;
		quest::settimer("5675",$Next_5675);
		$CheckH = $npc->HasNPCSpecialAtk("H");
		if ($CheckH == 1)
		{
			plugin::CastOnTarget(5675);
		}
	}

	#Wail of Anguish  4
	if ($timer eq "5678")
	{
		quest::stoptimer("5678");
		my $Next_5678 = int(rand(90))+90;
		quest::settimer("5678",$Next_5678);
		my $CheckH = $npc->HasNPCSpecialAtk("H");
		if ($CheckH == 1)
		{
			plugin::CastOnTarget(5678);
		}
	}

	#Void of Suppresion 5
	if ($timer eq "5677")
	{
		quest::stoptimer("5677");
		my $Next_5677 = int(rand(90))+90;
		quest::settimer("5677",$Next_5677);
		my $CheckH = $npc->HasNPCSpecialAtk("H");
		if ($CheckH == 1)
		{
			plugin::CastOnTarget(5677);
		}
	}

	#Gaze of Anguish 1
	if ($timer eq "5680")
	{
		quest::stoptimer("5680");
		my $Next_5680 = int(rand(60))+60;
		quest::settimer("5680",$Next_5680);
		my $CheckH = $npc->HasNPCSpecialAtk("H");
		if ($CheckH == 1)
		{
			plugin::CastOnTarget(5680);
		}
	}

	#Torrment of Body 2
	if ($timer eq "5676")
	{
		quest::stoptimer("5676");
		my $Next_5676 = int(rand(60))+60;
		quest::settimer("5676",$Next_5676);
		my $CheckH = $npc->HasNPCSpecialAtk("H");
		if ($CheckH == 1)
		{
			plugin::CastOnTarget(5676);
		}
	}

	#STAT BOOST
	if ($timer eq "Stat_Boost")
	{
		quest::stoptimer("Stat_Boost");
		quest::settimer("Stat_Boost",60);
		my $HP_RATIO_CHK_X = int($npc->GetHPRatio());
		
			if ($HP_RATIO_CHK_X < 98)
			{
			$MAX_DMG_Boost = $npc->GetMaxDMG(); 
			$New_MAX_DMG_Boost = $MAX_DMG_Boost + 200;
			quest::modifynpcstat("max_hit", $New_MAX_DMG_Boost);
			plugin::Debug("Max Damamge [$New_MAX_DMG_Boost]");
			}
	}

	###

	#Barrier#

	if ($timer eq "Barrier")
	{
		quest::stoptimer("Barrier");
		$npc->BuffFadeBySpellID(6296);
		$npc->BuffFadeBySpellID(30036);
		$npc->BuffFadeBySpellID(30037);
		$npc->BuffFadeBySpellID(30038);
		$npc->BuffFadeBySpellID(30039);
		$npc->BuffFadeBySpellID(30040);
		$npc->BuffFadeBySpellID(30041);
		$npc->BuffFadeBySpellID(30043);
		$npc->BuffFadeBySpellID(30044);
		$npc->BuffFadeBySpellID(30045);
		$npc->ModifyNPCStat("CR", 100);
		$npc->ModifyNPCStat("PR", 100);
		$npc->ModifyNPCStat("DR", 100);
		$npc->ModifyNPCStat("MR", 100);
		$npc->ModifyNPCStat("FR", 100);
		$Barrier_Active = 1;
		my $Choose_Barrier = quest::ChooseRandom(30036,30037,30038,30039);
		$npc->CameraEffect(2000,3);
		quest::doanim(43);
		$entity_list->MessageClose($npc, 1, 2000, 263, "Ivesi`Vok Muram begins to cast a spell. (Barrier Shift)");
		plugin::Debug("Barrier [$Choose_Barrier]");
		#$HP_RATIO_Check = int($npc->GetHPRatio()); 
		#if ($Restart_End != 1) { $Barrier_End = $HP_RATIO_Check - 8; }
		

		#Slash + Cold
		if ($Choose_Barrier == 30036)
		{ 
			$entity_list->MessageClose($npc, 1, 20000, 335, "Ivesi`Vok Muram's skin shimmers with intense blue light.'");
			$npc->SpellFinished(30036, $npc);
			$npc->SpellFinished(30042, $npc);
			$npc->ModifyNPCStat("CR", -600);
		}

		#Blunt + Fire
		if ($Choose_Barrier == 30037)
		{ 
			$entity_list->MessageClose($npc, 1, 20000, 335, "Ivesi`Vok Muram's skin shimmers with intense red light.'");
			$npc->SpellFinished(30037, $npc);
			$npc->SpellFinished(30043, $npc);
			$npc->ModifyNPCStat("FR", -600);
		}

		#Pierce + Disease/PR
		if ($Choose_Barrier == 30038)
		{ 
			$entity_list->MessageClose($npc, 1, 20000, 335, "Ivesi`Vok Muram's skin shimmers with intense green light.'");
			$npc->SpellFinished(30038, $npc);
			$npc->SpellFinished(30044, $npc);
			$npc->ModifyNPCStat("PR", -600);
			$npc->ModifyNPCStat("DR", -600);
		}

		#Fist/Range + Magic
		if ($Choose_Barrier == 30039)
		{ 
			$entity_list->MessageClose($npc, 1, 20000, 335, "Ivesi`Vok Muram's skin shimmers with intense white light.'");
			$npc->SpellFinished(30039, $npc);
			$npc->SpellFinished(30045, $npc);
			$npc->ModifyNPCStat("PR", -600);
			$npc->ModifyNPCStat("CR", -600);
		}
		quest::settimer("Barrier", 150); #Barrier changes every 8% (May consider changing this function)
	}

	###


	

	#WARP#
	
	if ($timer eq "Warp")
	{
		quest::stoptimer("Warp");

		if ($Warp_Count == 1)
		{ 
			$npc->SpellFinished(8422, $npc); 
			$Target_Save = $npc->GetTarget();
			if ($Target_Save)
			{ 
				$Target_Save_ID = $Target_Save->GetID();
				$npc->SetEntityVariable(1, $Target_Save_ID);
			}
		}

		$npc->NPCSpecialAttacks("EHMCNIDf", 0);
		$npc->WipeHateList();
		$npc->SetOOCRegen(0);
		quest::settimer("Warp_Go",2);
		$npc->DoAnim(2,20);
		$entity_list->MessageClose($npc, 1, 20000, 7, "Ivesi`Vok Muram's leaps into the air.'");
	}

	if ($timer eq "Warp_Go")
	{
		quest::stoptimer("Warp_Go");
		$entity_list->MessageClose($npc, 1, 20000, 7, "Ivesi`Vok Muram's blinks out of sight.'");
		my $Random_Jump = quest::ChooseRandom(1,2,3,4,5,6,7,8);
		if ($Random_Jump == 1) { $npc->GMMove(-167.6, 290.1, -212.5, 104.9); }
		if ($Random_Jump == 2) { $npc->GMMove(-294.8, 202.1, -215.5, 85.9); }
		if ($Random_Jump == 3) { $npc->GMMove(-304.8, 74.5, -212.5, 35.5); }
		if ($Random_Jump == 4) { $npc->GMMove(-212, 14, -212.5, 8); }
		if ($Random_Jump == 5) { $npc->GMMove(116.5, 307.5, -212.5, 135.6); }
		if ($Random_Jump == 6) { $npc->GMMove(216.5, 278.4, -212.5, 171.6); }
		if ($Random_Jump == 7) { $npc->GMMove(299.6, 210.6, -212.5, 165.6); }
		if ($Random_Jump == 8) { $npc->GMMove(298.6, 88.6, -212.5, 212); }
		plugin::Debug("[$mobid] Jump loc $Random_Jump");
		quest::settimer("Kill_Shot",3);
	}

	if ($timer eq "Kill_Shot")
	{
		quest::stoptimer("Kill_Shot");
		$Random_Client = $entity_list->GetRandomClient($x, $y, $z, 500);
		my $Status_Level = 0;
		my $LoS_Check = 0;
		if ($Random_Client)
		{
			$LoS_Check = $npc->CheckLoS($Random_Client); 
			$Status_Level = $Random_Client->Admin();
		

			if (($LoS_Check == 1) && ($Status_Level <= 12))
			{ 
				$npc->SetAppearance(1);
				#
				#$Random_Client = $entity_list->GetClientByID($Random_Client_ID);
				if ($Random_Client)
				{
					my $Client_Name = $Random_Client->GetCleanName();
					$entity_list->MessageClose($npc, 1, 20000, 335, "Ivesi`Vok Muram fixes his gaze upon $Client_Name.'");
					$Random_Client->Message(5, "You feel a gaze of deadly power focusing on you.'");
					$Random_Client->Message(6, "You should hide!'");
					quest::settimer("Gaze",8);
					$npc->FaceTarget($Random_Client);
					$Random_Client_ID = $Random_Client->GetID(); 
				}
			}
		}

		plugin::Debug("[$mname] LoS Check [0] $LoS_Check ($Status_Level)" ); 
		
		$Counter = 0;
		while ((($LoS_Check != 1) && ($Counter < 100)) || ($Status_Level >= 12) && ($Counter < 100))
		{
			$Counter++;
			$Random_Client = $entity_list->GetRandomClient($x, $y, $z, 500);
			if ($Random_Client)
			{
				$LoS_Check = $npc->CheckLoS($Random_Client);
				$Status_Level = $Random_Client->Admin();

			
				if ( ($LoS_Check == 1) && ($Status_Level <= 12) )
				{
					$npc->SetAppearance(1);
					#$Random_Client_ID = $Random_Client->GetID(); 
					#$Random_Client = $entity_list->GetClientByID($Random_Client_ID);
					if ($Random_Client)
					{
						my $Client_Name = $Random_Client->GetCleanName();
						$entity_list->MessageClose($npc, 1, 20000, 335, "Ivesi`Vok Muram fixes his gaze upon $Client_Name.'");
						$Random_Client->Message(5, "You feel a gaze of deadly power focusing on you.'");
						$Random_Client->Message(6, "You should hide!'");
						quest::settimer("Gaze",8);
						$npc->FaceTarget($Random_Client);
						$Random_Client_ID = $Random_Client->GetID(); 
					}
				}
			}

			plugin::Debug("[$mname] LoS Check [$Counter++;] $LoS_Check"); 

			if ($Counter >= 100)
			{ 
				plugin::Debug("[$mname] LoS Check [$Counter++;] ABORT"); 
				if ($Status_Level <= 12) { quest::settimer("Warp",1); }
				if ($Status_Level >  12) { quest::settimer("Warp_End",2); }
			}
		}
	
	}

	if ($timer eq "Gaze")
	{
		quest::stoptimer("Gaze");
		$Random_Client = $entity_list->GetClientByID($Random_Client_ID);
		if ($Random_Client)
		{
			$LoS_Check = $npc->CheckLoS($Random_Client); 
			$npc->FaceTarget($Random_Client);
		
			if ($LoS_Check == 1)
			{
				$npc->SetAppearance(5);
				$Client_Name = $Random_Client->GetCleanName(); 
				$entity_list->MessageClose($npc, 1, 20000, 335, "$Client_Name very existence is nearly obliterated by Ivesi`Vok Muram's magic.");
				$entity_list->MessageClose($npc, 1, 20000, 263, "Ivesi`Vok Muram twitches with power as $Client_Name life force is combines with his own.");
				my $Shout_Message = quest::ChooseRandom(1,2,3,4,5,6);
				if ($Shout_Message == 1) { quest::shout("You thought you could hide from me!"); }
				if ($Shout_Message == 2) { quest::shout("Your energy is stronger then I thought!"); }
				if ($Shout_Message == 3) { quest::shout("You can run but nothing will save you from the death that awaits!"); }
				if ($Shout_Message == 4) { quest::shout("Your kind is pathetic!"); }
				if ($Shout_Message == 5) { quest::shout("Now you know what true power looks like!"); }
				if ($Shout_Message == 6) { quest::shout("You will all soon kneel before me!"); }
				$Client_Name = $Random_Client->GetCleanName(); 
				$Random_Client->SendAppearanceEffect(102,102,102,102);
				$npc->SpellFinished(905, $Random_Client);
				$npc->SpellFinished(5685, $Random_Client);
				$Random_Client->SetHP($Random_Client->GetMaxHP() * .01);
				$Random_Client->SetMana($Random_Client->GetMaxMana() * .01);
				#$Random_Client->SetMana($Random_Client->SetEndurance() * .01);
				#Increase Max Damage by 2% every time gaze hits
				$MAX_DMG = $npc->GetMaxDMG(); 
				$New_MAX_DMG = int($MAX_DMG * 0.02);
				$Final_MAX_DMG = $New_MAX_DMG + $MAX_DMG;
				quest::modifynpcstat("max_hit", $Final_MAX_DMG);
				plugin::Debug("New Max Damage [$Final_MAX_DMG]");
			}

			if ($LoS_Check == 0)
			{ 
				$npc->SetAppearance(5);
				$Client_Name = $Random_Client->GetCleanName(); 
				$entity_list->MessageClose($npc, 1, 20000, 335, "$Client_Name has narrowly avoided Ivesi`Vok Muram's near fatal blast.");
			}
		}
		$Warp_Count = $Warp_Count + 1;
		$HP_RATIO_CHK = int($npc->GetHPRatio());

		if ($HP_RATIO_CHK > 25)
		{
			if ($Warp_Count < $Warp_Count_End) { quest::settimer("Warp",6); }
			if ($Warp_Count >= $Warp_Count_End)
			{
				$npc->DoAnim(2,20);
				quest::settimer("Warp_End",2);
				undef $Warp_Count;
			}
			plugin::Debug("[$mname] Warp Count: $Warp_Count | $Warp_Count_End");
		}

		if ($HP_RATIO_CHK <= 25)
		{
			$npc->DoAnim(2,20); quest::settimer("Warp_End",2);
			undef $Warp_Count; 
			plugin::Debug("[$mname] Warp Count: $Warp_Count | $Warp_Count_End");
		}
	}


	if ($timer eq "Warp_End")
	{
		quest::stoptimer("Warp_End");
		$npc->GMMove(-0.8, 197.7, -249.7, 126.8); 
		$npc->NPCSpecialAttacks("EFRQMCNIDf", 0);
		$Client_ID = $npc->GetEntityVariable(1);
		if ($Client_ID)
		{
			$Client_Check = $entity_list->GetClientByID($Client_ID);
			if ($Client_Check)
			{
				$npc->AddToHateList($Client_Check, 10000);
			}
			$npc->NPCSpecialAttacks("SEFRQMCNIDf", 0);
			quest::settimer("Barrier",10);
			$Warp_Mode = 0;
			$HP_RATIO_Check = int($npc->GetHPRatio()); 
			if ($Restart_End != 1)
			{
				$Barrier_End = $HP_RATIO_Check - 8;
			}
		}
	}

	#####

	#End#

	if ($timer eq "END1")
	{
		quest::stoptimer("END1");
		$Shadowbeast_Activiated = 1; 
		$Ture_Activiated = 1;
		undef $Barrier_End;

		$entity_list->MessageClose($npc, 1, 20000, 262, "Ivesi`Vok Muram crys out in pain, 'Enough! This waste of time ends now! Did you really believe your pathetic weapons and incantions could destroy a being such as myself?'");

		quest::settimer("END2",6);
	}

	if ($timer eq "END2")
	{
		quest::stoptimer("END2");
		quest::spawn2(859249,0,0, -300, 144, -207, 59);
		quest::spawn2(859251,0,0, -292, 145, -239, 59);
		$entity_list->MessageClose($npc, 1, 20000, 335, "A deafening clash of thunder rings through your ears.'");
		$entity_list->MessageClose($npc, 1, 20000, 262, "The Gatekeeper shouts,'Stop! You have weakened the beast enough do not kill him! They will only find another way to bring him back!'");
		quest::settimer("END3",6);
	}

	if ($timer eq "END3")
	{
		quest::stoptimer("END3");
		$entity_list->MessageClose($npc, 1, 20000, 262, "The Gatekeeper shouts, 'You must keep him occupied for a few minutes while I attempt to cast the Stasis spell!'");
		quest::settimer("END4",6);
	}

	if ($timer eq "END4")
	{
		quest::stoptimer("END4");
		$entity_list->MessageClose($npc, 1, 20000, 262, "Ivesi`Vok Muram turns his attention toward The Gate Keeper, 'I don't know who you are but you will find your death as quickly as the others!"); 
		$entity_list->MessageClose($npc, 1, 20000, 7, "Ivesi`Vok Muram charges toward The Gatekeeper! Claws ready to strike."); 
		$npc->NPCSpecialAttacks("HFQMCDf", 0);
		$npc->WipeHateList();
		$npc->NPCSpecialAttacks("FQMCDf", 0);
		quest::modifynpcstat("runspeed", 1);
		quest::attacknpctype(859251);
		$npc->NPCSpecialAttacks("HFQMCDf", 0);
		
		my @clientlist = $entity_list->GetClientList();
		foreach $ent (@clientlist)
		{
			$ent->SpellFinished(5244, $ent);
		}
		
		quest::settimer("END5",2);
		$npc->ModifyNPCStat("MR", 100);
		quest::settimer("Root_Snare_Break",2);
	}


	if ($timer eq "END5")
	{
		quest::stoptimer("END5");
		$entity_list->MessageClose($npc, 1, 20000, 262, "Ivesi`Vok has been hurt greatly he will not be able to with stand your stuns or snares! You can not let him interrupt the casting!'");
		quest::settimer("END6",3);
	}

	if ($timer eq "END6")
	{
		quest::stoptimer("END6");
		$entity_list->MessageClose($npc, 1, 2000, 335, "The Gatekeeper begins to cast a spell. (Stasis of Zebuxoruk)");
		$npc->SetOOCRegen(0);
	}



	#INTRO#

	if ($timer eq "SEQ1")
	{
		quest::stoptimer("SEQ1");
		$entity_list->MessageClose($npc, 1, 20000, 262, "Ivesi`Vok Muram bellows in a voice so deep it shakes the castle walls,'It appears we have guests!'");
		$npc->CameraEffect(1000,3);
		quest::settimer("SEQ2",6);
		$npc->SetAppearance(5);
	}

	if ($timer eq "SEQ2")
	{
		quest::stoptimer("SEQ2");
		$entity_list->MessageClose($npc, 1, 20000, 262, "Ivesi`Vok Muram bellows,'...and just in time for the grand finale! These for a lack of better words 'things' have been so kind to restore flesh to my old bones, not only that but the powers they have imbued in me far exceed any magic I have ever known...'");
		$npc->CameraEffect(1000,3);
		quest::settimer("SEQ3",12);
	}

	if ($timer eq "SEQ3")
	{
		quest::stoptimer("SEQ3");
		quest::doanim(42);
		$entity_list->MessageClose($npc, 1, 20000, 262, "Ivesi`Vok Muram laughs out,'... I never dreamed I would walk this plane agian! I have been brought back to serve as their Overlord and to conquer worlds on their behalf!'");
		$npc->CameraEffect(1000,3);
		quest::settimer("SEQ4",10);
	}

	if ($timer eq "SEQ4")
	{
		quest::stoptimer("SEQ4");
		quest::doanim(2);
		$entity_list->MessageClose($npc, 1, 20000, 262, "Ivesi`Vok Muram shouts out shaking the foundations of the castle,'But I have other plans of my own!'");
		$npc->CameraEffect(2000,5);

		@npclist = $entity_list->GetNPCList();
		foreach $cur (@npclist)
		{
			my $NPC_ID = $cur->GetNPCTypeID();
			if ($NPC_ID == 859245)
			{
				$cur->Damage($npc, 842100, 68, 1, 1, -1, 0);
				#$cur->DoAnim(5,16);	
			}
		}

		quest::settimer("SEQ5",3);
	}


	if ($timer eq "SEQ5")
	{
		quest::stoptimer("SEQ5");
		$entity_list->MessageClose($npc, 1, 20000, 262, "Discordant Councilman Ulik shouts,'Stop him! Stop him now! He can not be allowed to leave!'");
		$entity_list->MessageClose($npc, 1, 20000, 262, "Discordant Councilman Kxtra shouts,'Foolish Ikaavs! You said you could controll him!'");
		$entity_list->MessageClose($npc, 1, 20000, 262, "Discordant Councilman Vakv shouts,'Destroy it before it gains its full power back!'");
		quest::settimer("SEQ6",1);


		@npclist = $entity_list->GetNPCList();
		foreach $cur (@npclist)
		{
			my $NPC_ID = $cur->GetNPCTypeID();
			if ($NPC_ID == 859214)
			{
				$cur->AddToHateList($npc, 1000);	
			}
		}

		quest::settimer("SEQ6",3);
	}

	if ($timer eq "SEQ6")
	{
		quest::stoptimer("SEQ6");
		quest::doanim(43);
		$entity_list->MessageClose($npc, 1, 20000, 262, "Ivesi`Vok Muram shout,'Did you really think you could control me? You pathetic creatures... You will soon learn just how big mistake you made!'");
		$Target = $npc->GetTarget();

		if ($Target)
		{
			quest::doanim(43); 
			$Target->Damage($npc, 99353211, 68, 1, 1, -1, 0);
			$entity_list->MessageClose($npc, 1, 20000, 15, "A lightning warrior commander is obliterated by Ivesi`Vok Muram's magic!'");
		}
		quest::settimer("SEQ7",6);
	}

	if ($timer eq "SEQ7")
	{
		quest::stoptimer("SEQ7");
		quest::doanim(43);
		$entity_list->MessageClose($npc, 1, 20000, 262, "Ivesi`Vok Muram shout,'As soon as I am done here my first order of buisiness will be raise Dranik to the ground and melt the bones of every last remaining Dragorn!'");
		$Target = $npc->GetTarget();

		if ($Target)
		{
			quest::doanim(43); 
			$Target->Damage($npc, 99353211, 68, 1, 1, -1, 0);
			$entity_list->MessageClose($npc, 1, 20000, 15, "A lightning warrior commander is obliterated by Ivesi`Vok Muram's magic!'");
		}
		quest::settimer("SEQ7",6);
	}

	if ($timer eq "SEQ7")
	{
		quest::stoptimer("SEQ7");
		quest::doanim(43);
		$entity_list->MessageClose($npc, 1, 20000, 262, "Ivesi`Vok Muram shout,'Once that minor task is completed the rest of this pathetic world will fall under my absolute domination!'");
		quest::settimer("SEQ8",6);
	}

	if ($timer eq "SEQ8")
	{
		quest::stoptimer("SEQ8");
		$entity_list->MessageClose($npc, 1, 20000, 262, "Ivesi`Vok Muram laugh,'Councilman while I do owe my thanks for restoring my flesh your usefullness to me has run out!'");
		$npc->GMMove($x, $y, $z, 70);
		quest::settimer("SEQ9",6);
	}

	if ($timer eq "SEQ9")
	{
		quest::stoptimer("SEQ9");
		$entity_list->MessageClose($npc, 1, 20000, 262, "Discordant Councilman Ulik shouts,'Impossible! Do not do this.'");
		$entity_list->MessageClose($npc, 1, 20000, 262, "Discordant Councilman Kxtra shouts,'We can help you!'");
		$entity_list->MessageClose($npc, 1, 20000, 262, "Discordant Councilman Vakv shouts,'You need us!'");
		$entity_list->MessageClose($npc, 1, 20000, 263, "Discordant Councilman Jyri begins to cast a spell. (Gate)'");
		$entity_list->MessageClose($npc, 1, 20000, 263, "Discordant Councilman Dlus begins to cast a spell. (Gate)'");
		$entity_list->MessageClose($npc, 1, 20000, 263, "Discordant Councilman Exlo begins to cast a spell. (Gate)'");
		quest::doanim(44);

		@npclist = $entity_list->GetNPCList();
		foreach $cur (@npclist)
		{
			my $NPC_ID = $cur->GetNPCTypeID();
			my $NPC_X = $cur->GetX();
			if (($NPC_ID == 859244) && ($NPC_X > 30))
			{
				$cur->Damage($npc, 59353211, 68, 1, 1, -1, 0);
			}
		}

		quest::settimer("SEQ10",6);
	}

	if ($timer eq "SEQ10")
	{
		quest::stoptimer("SEQ10");
		$entity_list->MessageClose($npc, 1, 20000, 262, "Ivesi`Vok Muram laugh,'Where do you think your going?'");
		$npc->GMMove($x, $y, $z, 187);
		quest::doanim(44);


		@npclist = $entity_list->GetNPCList();
		foreach $cur (@npclist)
		{
			my $NPC_ID = $cur->GetNPCTypeID();
			my $NPC_X = $cur->GetX();
			if (($NPC_ID == 859244) && ($NPC_X < 30))
			{
				$cur->Damage($npc, 59353211, 68, 1, 1, -1, 0);
			}
		}

		quest::settimer("SEQ11",6);
	}

	if ($timer eq "SEQ11")
	{
		quest::stoptimer("SEQ11");
		$entity_list->MessageClose($npc, 1, 20000, 262, "Ivesi`Vok Muram voice booms,'Now prepare to face power beyond your wildest nightmares!'");
		$entity_list->MessageClose($npc, 1, 20000, 263, "Ivesi`Vok begins to cast a spell. (Obliteration of the Muram)!'");
		$npc->GMMove($x, $y, $z, 126);
		$npc->SetAppearance(1);
		quest::settimer("SEQ12",6);
	}


	if ($timer eq "SEQ12") {
		quest::stoptimer("SEQ12");
		quest::settimer("SEQ13",3);
		$npc->SetAppearance(5);
		quest::doanim(43);
		my @clientlist = $entity_list->GetClientList();
		foreach $ent (@clientlist)
		{
			$Rng_CHK = $ent->GetItemIDAt(11); 
			$Prm_CHK = $ent->GetItemIDAt(13);
			$Sec_CHK = $ent->GetItemIDAt(14);
			
			if (!$Rng_CHK) { $Rng_CHK = 0; }
			if (!$Prm_CHK) { $Prm_CHK = 0; }
			if (!$Sec_CHK) { $Sec_CHK = 0; }
			
			$Name = $ent->GetCleanName();         
			plugin::Debug("[Weapon Check] $Name : $Rng_CHK | $Prm_CHK | $Sec_CHK | $Zer_CHK ");
			my $Zer_CHK = plugin::check_hasitem($ent, 99482);

			if (($Rng_CHK == 99168) || ($Rng_CHK == 99169) || ($Rng_CHK == 99772) || ($Rng_CHK == 99477) 
				|| ($Prm_CHK == 99170) || ($Prm_CHK == 99173) || ($Prm_CHK == 99174) || ($Prm_CHK == 99172) || ($Prm_CHK == 99476) || ($Prm_CHK == 99478)|| ($Prm_CHK == 99477)
				|| ($Sec_CHK == 99170) || ($Sec_CHK == 99173) || ($Sec_CHK == 99174) || ($Sec_CHK == 99172) || ($Sec_CHK == 99476) || ($Sec_CHK == 99478)|| ($Sec_CHK == 99477)
				|| ($Sec_CHK == 99167) || ($Zer_CHK == 1))
			{
				if (($Rng_CHK == 99168) || ($Prm_CHK == 99168) || ($Sec_CHK == 99168)) { $ent->Message(263, "Your Dragomori, Spellbook of Ivesi`Vok begins to glow!'"); }
				if (($Rng_CHK == 99169) || ($Prm_CHK == 99169) || ($Sec_CHK == 99169)) { $ent->Message(263, "Your Darkwynd, Bow of Ivesi`Vok begins to glow!'"); }
				if (($Rng_CHK == 99772) || ($Prm_CHK == 99772) || ($Sec_CHK == 99772)) { $ent->Message(263, "Your Tomb of the Fifth Grandmaster begins to glow!'"); }
				if (($Rng_CHK == 99170) || ($Prm_CHK == 99170) || ($Sec_CHK == 99170)) { $ent->Message(263, "Your Arcrist, Runeblade of Ivesi`Vok begins to glow!'"); }
				if (($Rng_CHK == 99173) || ($Prm_CHK == 99173) || ($Sec_CHK == 99173)) { $ent->Message(263, "Your Ethereal Warclub of Ivesi`Vok begins to glow!'"); }
				if (($Rng_CHK == 99174) || ($Prm_CHK == 99174) || ($Sec_CHK == 99174)) { $ent->Message(263, "Your Illumnia, Firestaff of Ivesi`Vok begins to glow!'"); }
				if (($Rng_CHK == 99476) || ($Prm_CHK == 99476) || ($Sec_CHK == 99476)) { $ent->Message(263, "Your Battlefists of the Nethervoid begins to glow!'"); }
				if (($Rng_CHK == 99478) || ($Prm_CHK == 99478) || ($Sec_CHK == 99478)) { $ent->Message(263, "Your Irestone Battlestaff of Domination to glow!'"); }
				if (($Rng_CHK == 99477) || ($Prm_CHK == 99477) || ($Sec_CHK == 99477)) { $ent->Message(263, "Your Widowmaker begins to glow!'"); }
				if (($Rng_CHK == 99472) || ($Prm_CHK == 99472) || ($Sec_CHK == 99472)) { $ent->Message(263, "Your Shadowslayer, Lance of Ivesi`Vok begins to glow!'"); }
				if (($Rng_CHK == 99167) || ($Prm_CHK == 99167) || ($Sec_CHK == 99167)) { $ent->Message(263, "Your Blessed Battleshield of Ivesi`Vok to glow!'"); }
				if ($Zer_CHK == 1) { $ent->Message(263, "Your Ivesi`Vok's Granite Shard of Devastation to glow!'"); }

				$entity_list->MessageClose($npc, 1, 20000, 15, "$Name is unharmed by Ivesi`Vok's magic!'");
			}
			else
			{
				$cur->BuffFadeAll();
				if ($status < 100)
				{
					$cur->Damage($npc, 59353211, 68, 1, 1, -1, 0);
				}
				$entity_list->MessageClose($npc, 1, 20000, 13, "$Name is obilterated by Ivesi`Vok's magic!'");
			}
		}
	}

	if ($timer eq "SEQ13")
	{
		quest::stoptimer("SEQ13");
		$npc->SetAppearance(5);
		$entity_list->MessageClose($npc, 1, 20000, 262, "Ivesi`Vok Muram shout in pure rage,'Impossible! Nothing should be able to with stand my power!'");
		$entity_list->MessageClose($npc, 1, 20000, 262, "Ivesi`Vok Muram laughs,'I have no interest in returning to the grave... Come now then if you think you have what it takes defeat me!'");
		quest::emote("prepares himself for battle.");
		$npc->NPCSpecialAttacks("SEFRQMCNIDf", 0);
		quest::settimer("Barrier", 1);
		quest::settimer("5676",20);
		quest::settimer("Stat_Boost",60);
		#quest::settimer("Check_Weapons",120);
		$HP_RATIO_Check = int($npc->GetHPRatio()); 
		if ($Restart_End != 1)
		{
			$Barrier_End = $HP_RATIO_Check - 8;
		}
		$npc->SetEntityVariable(1000, 1);
		plugin::Debug("START EVENT");
		$entity_list->MessageClose($npc, 1, 20000, 7, "The air around you grows turbulent as chaotic winds envelop the causeway.");
	}

	#####

	#CHECK IF DRANIK WEAPON#
	#TEMP DISABLED 4/5/11 zone crash???
	
	if ($timer eq "Check_Weapons")
	{
	
		if ($DISABLED == 1) {
		quest::stoptimer("Check_Weapons");
		$entity_list->MessageClose($npc, 1, 2000, 263, "Ivesi`Vok Muram begins to cast a spell. (Obliteration of the Muram)");
		my @clientlist = $entity_list->GetClientList();
		foreach $ent (@clientlist)
		{
		
			if ($ent) {
		
			$Rng_CHK = $ent->GetItemIDAt(11); 
			$Prm_CHK = $ent->GetItemIDAt(13);
			$Sec_CHK = $ent->GetItemIDAt(14);

			if (!$Rng_CHK) { $Rng_CHK = 0; }
			if (!$Prm_CHK) { $Prm_CHK = 0; }
			if (!$Sec_CHK) { $Sec_CHK = 0; }

			$Name = $ent->GetCleanName();         
			my $Zer_CHK = plugin::check_hasitem($ent, 99482);
			plugin::Debug("[Weapon Check 1] $Name : $Rng_CHK | $Prm_CHK | $Sec_CHK | $Zer_CHK ");

       		if ( ($Rng_CHK == 99168) || ($Rng_CHK == 99169) || ($Rng_CHK == 99772) || ($Rng_CHK == 99477) 
				|| ($Prm_CHK == 99170) || ($Prm_CHK == 99173) || ($Prm_CHK == 99174) || ($Prm_CHK == 99172) || ($Prm_CHK == 99476) || ($Prm_CHK == 99478)|| ($Prm_CHK == 99477)
				|| ($Sec_CHK == 99170) || ($Sec_CHK == 99173) || ($Sec_CHK == 99174) || ($Sec_CHK == 99172) || ($Sec_CHK == 99476) || ($Sec_CHK == 99478)|| ($Sec_CHK == 99477)
				|| ($Sec_CHK == 99167) || ($Zer_CHK == 1))
			{

				if (($Rng_CHK == 99168) || ($Prm_CHK == 99168) || ($Sec_CHK == 99168)) { $ent->Message(263, "Your Dragomori, Spellbook of Ivesi`Vok begins to glow!'"); }
				if (($Rng_CHK == 99169) || ($Prm_CHK == 99169) || ($Sec_CHK == 99169)) { $ent->Message(263, "Your Darkwynd, Bow of Ivesi`Vok begins to glow!'"); }
				if (($Rng_CHK == 99772) || ($Prm_CHK == 99772) || ($Sec_CHK == 99772)) { $ent->Message(263, "Your Tomb of the Fifth Grandmaster begins to glow!'"); }
				if (($Rng_CHK == 99170) || ($Prm_CHK == 99170) || ($Sec_CHK == 99170)) { $ent->Message(263, "Your Arcrist, Runeblade of Ivesi`Vok begins to glow!'"); }
				if (($Rng_CHK == 99173) || ($Prm_CHK == 99173) || ($Sec_CHK == 99173)) { $ent->Message(263, "Your Ethereal Warclub of Ivesi`Vok begins to glow!'"); }
				if (($Rng_CHK == 99174) || ($Prm_CHK == 99174) || ($Sec_CHK == 99174)) { $ent->Message(263, "Your Illumnia, Firestaff of Ivesi`Vok begins to glow!'"); }
				if (($Rng_CHK == 99476) || ($Prm_CHK == 99476) || ($Sec_CHK == 99476)) { $ent->Message(263, "Your Battlefists of the Nethervoid begins to glow!'"); }
				if (($Rng_CHK == 99478) || ($Prm_CHK == 99478) || ($Sec_CHK == 99478)) { $ent->Message(263, "Your Irestone Battlestaff of Domination to glow!'"); }
				if (($Rng_CHK == 99477) || ($Prm_CHK == 99477) || ($Sec_CHK == 99477)) { $ent->Message(263, "Your Widowmaker begins to glow!'"); }
				if (($Rng_CHK == 99472) || ($Prm_CHK == 99472) || ($Sec_CHK == 99472)) { $ent->Message(263, "Your Shadowslayer, Lance of Ivesi`Vok begins to glow!'"); }
				if (($Rng_CHK == 99167) || ($Prm_CHK == 99167) || ($Sec_CHK == 99167)) { $ent->Message(263, "Your Blessed Battleshield of Ivesi`Vok to glow!'"); }
				if ($Zer_CHK == 1) { $ent->Message(263, "Your Ivesi`Vok's Granite Shard of Devastation to glow!'"); }
				$entity_list->MessageClose($npc, 1, 20000, 15, "$Name is unharmed by Ivesi`Vok's magic!'"); 
				plugin::Debug("[Weapon Check 2]PASS $Name : $Rng_CHK | $Prm_CHK | $Sec_CHK |$Zer_CHK");
			}
			else
			{ 
				$ent->BuffFadeAll();
				$ent->Damage($npc, 59353211, 68, 1, 1, -1, 0); 
				plugin::Debug("[Weapon Check 2]Fail $Name : $Rng_CHK | $Prm_CHK | $Sec_CHK |$Zer_CHK");
				$entity_list->MessageClose($npc, 1, 20000, 13, "$Name is obilterated by Ivesi`Vok's magic!'");
			}
		}}
		}#Disabled
	}

	if ($timer eq "Root_Snare_Break")
	{
		$Debuff_Movement = quest::ChooseRandom(1,2,3,4,5,6); 
		if ($Debuff_Movement == 6) { $npc->BuffFadeByEffect(3); }
		$Debuff_Movement = quest::ChooseRandom(1,2,3,4,5,6); 
		if ($Debuff_Movement == 6) { $npc->BuffFadeByEffect(99); }
	}

	if ($timer eq "End_ATTACK_GATEKEEPER")
	{
		quest::stoptimer("End_ATTACK_GATEKEEPER");
		quest::doanim(44);
		$entity_list->MessageClose($npc, 1, 20000, 263, "Ivesi`Vok begins to cast a spell. (Discordant Light)'");
		$entity_list->MessageClose($npc, 1, 20000, 263, "Ivesi`Vok wounds close.");
		$End_RATIO = int($npc->GetHPRatio());
		$Heal = ($End_RATIO/100) + 0.06;
		$npc->SetHP($npc->GetMaxHP() * $Heal);
		$End_RATIO = int($npc->GetHPRatio());
		quest::settimer("End_HP_CHECK",2);

		if ($End_RATIO <= 19)
		{
			$npc->WipeHateList();
			#$npc->NPCSpecialAttacks("FQMCDf", 0);
			quest::modifynpcstat("runspeed", 1);
			quest::attacknpctype(859251);
			$npc->NPCSpecialAttacks("HFQMCDf", 0);
			$entity_list->MessageClose($npc, 1, 20000, 262, "Ivesi`Vok Muram shout in anger,'Impressive agility! But you will not be able to evade me forever!'");
		}

		if ($End_RATIO >= 20)
		{
			$npc->WipeHateList();
			quest::depop(859249);
			quest::depop(859251);
			$entity_list->MessageClose($npc, 1, 20000, 262, "The Gatekeeper shouts in dismay,'You have allowed him to recover too much strength! Weaken the beast agian I will return for another attempt! I must rest...'");
			$npc->NPCSpecialAttacks("SEFRQMCNIDf", 0);
			
			my @clientlist = $entity_list->GetClientList();
			foreach $ent (@clientlist)
			{
				$npc->AddToHateList($ent, 1);
			}
			quest::settimer("Barrier",6);
			$Restart_End = 1;
		}

	}

	if ($timer eq "End_HP_CHECK")
	{
		quest::stoptimer("End_HP_CHECK");
		quest::settimer("End_HP_CHECK",2);
		$HP_RATIO_CHK = int($npc->GetHPRatio()); 

		if (($HP_RATIO_CHK <= 10) && ($Warp_Mode == 0) && ($Restart_End == 1))
		{
			quest::spawn2(859249,0,0, -300, 144, -207, 59);
			quest::spawn2(859251,0,0, -292, 145, -239, 59);
			$entity_list->MessageClose($npc, 1, 20000, 262, "The Gatekeeper I will try once more! Keep Ivesi`Vok distracted and a safe distance away from me so I can complete the Statis spell!'");
			$npc->WipeHateList();
			#$npc->NPCSpecialAttacks("FQMCDf", 0);
			quest::modifynpcstat("runspeed", 1);
			quest::attacknpctype(859251);
			$npc->NPCSpecialAttacks("HFQMCDf", 0);
			$entity_list->MessageClose($npc, 1, 20000, 7, "Ivesi`Vok Muram charges toward The Gatekeeper! Claws ready to strike."); 
			
			my @clientlist = $entity_list->GetClientList();
			foreach $ent (@clientlist)
			{
				$ent->SpellFinished(5244, $ent);
			}
			undef $Restart_End;
		}
	}

	if ($timer eq "Final1")
	{
		quest::stoptimer("Final1");
		quest::depop(859249);
		quest::spawn2(859249,0,0, 5.9, 172, -247, 137);
		$entity_list->MessageClose($npc, 1, 20000, 262, "The Gatekeeper shouts,'We are lucky on this day! The world nearly avoided assured destruction thanks to your valiant efforts! No words can express my gratitude your bravery here will not be forgetten!'");
		$entity_list->MessageClose($npc, 1, 20000, 262, "The Gatekeeper shouts,'Please accept this chest as a minor token of my thanks, I found it hidden within a secret chamber of the citadel perhaps you will find something of value within!'");
		quest::signalwith(859252,1,0);
		quest::stopalltimers();
		$npc->SetAppearance(2);
		return;
		#quest::settimer("Final2");
	}



	if ($timer eq "color")
	{
		quest::stoptimer("color");
		$npc->SendAppearanceEffect(230,230,230,230,230);
	}


}

sub EVENT_SIGNAL {

	plugin::Debug("[$mname] Signal $signal");


	if ($signal == 1)
	{
		quest::depop(859249);
		$entity_list->MessageClose($npc, 1, 20000, 335, "The Gatekeeper narrowly avoids Ivesi`Vok Muram's deadly blow by teleporting himself a safe distance away!'");
		$entity_list->MessageClose($npc, 1, 20000, 335, "The Gatekeeper you must keep him away from me I will have start the incantation from the beginning!'");
		quest::depop(859249); quest::depop(859251);
		quest::spawn2(859249,0,0, 300, 144, -207, 59);
		quest::spawn2(859251,0,0, 292, 145, -239, 188);
		quest::settimer("End_ATTACK_GATEKEEPER",3);
	
	}

	if ($signal == 2)
	{
		quest::depop(859249);
		$entity_list->MessageClose($npc, 1, 20000, 335, "The Gatekeeper narrowly avoids Ivesi`Vok Muram's deadly blow by teleporting himself a safe distance away!'");
		$entity_list->MessageClose($npc, 1, 20000, 262, "The Gatekeeper you must keep him away from me I will have start the incantation from the beginning!'");
		quest::depop(859249); quest::depop(859251);
		quest::spawn2(859249,0,0, -300, 144, -207, 59);
		quest::spawn2(859251,0,0, -292, 145, -239, 59);
		quest::settimer("End_ATTACK_GATEKEEPER",3);
	}

	if ($signal == 3)
	{
		quest::stoptimer("5675");
		quest::stoptimer("5678");
		quest::stoptimer("5677");
		quest::stoptimer("5680");
		quest::stoptimer("5676");
		quest::stoptimer("End_HP_CHECK");
		quest::stoptimer("Check_Weapons");
		quest::stoptimer("Gaze");
		quest::stoptimer("Stat_Boost");
		quest::stoptimer("Barrier");
		
		$Check_EntID = $entity_list->GetMobByNpcTypeID(859249);
		$Check_EntID->DoAnim(5,44);
		$entity_list->MessageClose($npc, 1, 20000, 262, "The Gatekeeper shouts in a language you do not recognize,'Ori`noo val cali Zebuxoruk!'");
		$entity_list->MessageClose($npc, 1, 20000, 335, "Time seems to slow around you as the air around you becomes suddenly still, torrents of white light engulf Ivesi`Vok Muram!'");
		$entity_list->MessageClose($npc, 1, 20000, 262, "Ivesi`Vok Muram opens his mouth to scream but the words never form.'");
		$entity_list->MessageClose($npc, 1, 20000, 15, "Ivesi`Vok Muram is locked in an enternal stasis!'");
		$npc->WipeHateList();
		$npc->NPCSpecialAttacks("ABH", 0);
		quest::modifynpcstat("runspeed", 0);
		$npc->WipeHateList();
		$npc->SaveGuardSpot(0);
		$npc->SetAppearance(2);
		quest::doanim(42);
		quest::settimer("Final1",6);
		quest::settimer("color",3);
		#quest::we(15, "A flash of blinding white light briefly illuminates the sky above you.");
	}

}

sub EVENT_DEATH {

	quest::we(13, "$mname EVENT STATUS: FAIL [Please contact GM to report this immediately]");
			quest::depop(859249);
		quest::spawn2(859249,0,0, 5.9, 172, -247, 137);
		$entity_list->MessageClose($npc, 1, 20000, 262, "The Gatekeeper shouts,'We are lucky on this day! The world nearly avoided assured destruction thanks to your valiant efforts! No words can express my gratitude your bravery here will not be forgetten!'");
		$entity_list->MessageClose($npc, 1, 20000, 262, "The Gatekeeper shouts,'Please accept this chest as a minor token of my thanks, I found it hidden within a secret chamber of the citadel perhaps you will find something of value within!'");
		quest::signalwith(859252,1,0);
	$timestamp = localtime(time);
	quest::write("text_files/Dranik_Kill.txt","[$timestamp]:$mname was killed by $name the $class ERROR LOG OF IV SHOULD NEVER BE KILLED.");

}
