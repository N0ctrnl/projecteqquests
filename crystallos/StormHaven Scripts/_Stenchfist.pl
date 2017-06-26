sub EVENT_SPAWN {
$npc->SetEntityVariable(1, 0);
$Total_Adds = 15;
quest::settimer("Start",1);
quest::settimer("Depop",600);
$Save_WP = 500;
}

sub EVENT_COMBAT { 

 	if ($combat_state == 1) {   
	quest::emote("slams its massive diseased foot into the earth.");  
	quest::settimer("Move_Next_WP", 180);
	$npc->SetOOCRegen(0);
	quest::stoptimer("Reset");
	}
  
	if ($combat_state == 0) { 
	quest::settimer("Reset", 600);
	
	
	}
 
}
	
	
sub EVENT_WAYPOINT_ARRIVE {

	my $WP_ID = $npc->GetWaypointID();
	
	
	
	
	
	
	
	#$npc->SaveGuardSpot(0);
	
	$Add_Count = 1;
	
	$Is_Avctive = $npc->GetEntityVariable(1);
	#plugin::Debug("[Stenchfist] $Is_Avctive Active?");
	
	plugin::Debug("[Stenchfist] Way Point $mname $WP_ID  ($Save_WP != $WP_ID)");
	
	if ($Save_WP != $WP_ID) {
	$Save_WP = $WP_ID;
	
		if ($Is_Avctive >= 1) {
		quest::settimer("Move_Next_WP",180);
		quest::modifynpcstat("runspeed", 0.0001);
		$npc->NPCSpecialAttacks("SEFQMCNIDf", 0);
				
			while ($Add_Count <= $Is_Avctive) {
			$Choose_Add = quest::ChooseRandom(467039,467046,467047,467048,467049,467051,467052,467054,467055,467057,467089);
			$Xmod = int(rand(120)) - 60;
			$Ymod = int(rand(120)) - 60;
			quest::spawn2($Choose_Add,0,0, $x + $Xmod, $y + $Ymod, $z, $h);
			$Add_Count++;
			}
		}
	}
}	

sub EVENT_TIMER {

	if ($timer eq "Reset") {
	quest::stoptimer("Reset");
	quest::depopall(467039);
	quest::depopall(467046);
	quest::depopall(467047);
	quest::depopall(467048);
	quest::depopall(467049);
	quest::depopall(467051);
	quest::depopall(467052);
	quest::depopall(467054);
	quest::depopall(467055);
	quest::depopall(467057);
	quest::depopall(467089);
	quest::doanim(44);
	$npc->SetOOCRegen(5000);
	quest::stoptimer("Move_Next_WP");
	}


	if ($timer eq "Start") {
	quest::stoptimer("Start");
	plugin::Debug("Start Path");
	quest::start(17);
	}
	
	if ($timer eq "Depop") {
	
	
		if (!defined($qglobals{Rare_Oceangreenvillage_Spawn})) 
		{ 
		quest::emote("is called back to the temple.");
		$Minutes = "M";
		$Duration = plugin::RandomRange(5760,10800);
		$Global_Duration = "$Minutes$Duration";
		#quest::setglobal("Rare_Oceangreenvillage", $Duration, 7, "$Global_Duration");
		quest::setglobal("Rare_Oceangreenvillage", 1, 7, "D3");
		quest::depop();
		}
	
	
	}

	if ($timer eq "Move_Next_WP") {
	quest::stoptimer("Move_Next_WP");
	quest::modifynpcstat("runspeed", 1.25);
	$npc->WipeHateList();
	quest::emote("skin turns hard as stone.");
	$entity_list->MessageClose($npc, 1, 500, 15, "Stenchfist pounds the earth with its massive hands waking the dead from their eternal slumber.");
	$npc->NPCSpecialAttacks("HINABf", 0);
	quest::doanim(44);
	$npc->WipeHateList();

		if ((!$Total_Adds) || ($Total_Adds < 10)) 
		{ 
		$Total_Adds = 12; 
		}
		
	$Total_Adds = $Total_Adds + 1;
	$npc->SetEntityVariable(1, $Total_Adds);
	
	$Is_Avctive = $npc->GetEntityVariable(1);
	$Add_Count = 1;
	
		while ($Add_Count <= $Is_Avctive) {
		$Choose_Add = quest::ChooseRandom(467039,467046,467047,467048,467049,467051,467052,467054,467055,467057,467089);
		$Xmod = int(rand(120)) - 60;
		$Ymod = int(rand(120)) - 60;
		quest::spawn2($Choose_Add,0,0, $x + $Xmod, $y + $Ymod, $z, $h);
		$Add_Count++;
		}
	
	}

}

sub EVENT_DEATH {
quest::we(15, "The flow of time stabilizes as Stenchfist's gargantuan body falls lifeless to the earth.");
$timestamp = localtime(time);
quest::write("text_files/SoD_Rare_Named.txt","[$timestamp]:$mname was killed by $name the $class.");

	$Minutes = "M";
	$Duration = plugin::RandomRange(5760,10800);
	$Global_Duration = "$Minutes$Duration";
	#quest::setglobal("Rare_Oceangreenvillage", $Duration, 7, "$Global_Duration");
	quest::setglobal("Rare_Oceangreenvillage", 1, 7, "D3");
	quest::setglobal("Rare_Oceangreenvillage_Spawn", 1, 7, "S1"); #Delete Global
	plugin::Debug("Global Set");

}


