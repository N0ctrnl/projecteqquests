sub EVENT_SPAWN {
quest::settimer("SetStats",1);
}

sub EVENT_SIGNAL {

$DragonAC = $DragonAC + ($signal * 20);
$DragonMax = $DragonMax + ($signal * 200);
$DragonMin = $DragonMin + ($signal * 50);
$DragonACC = $DragonACC + ($signal * 10);
$DragonATK = $DragonATK + ($signal * 30);

quest::modifynpcstat("ac", $DragonAC);
quest::modifynpcstat("max_hit", $DragonMax);
quest::modifynpcstat("min_hit", $DragonMin);
quest::modifynpcstat("accuracy", $DragonACC);
quest::modifynpcstat("atk", $DragonATK);

$Npc_Name = $npc->GetCleanName();
$entity_list->MessageClose($npc, 1, 500, 335, "$Npc_Name experiences a divine balance.");
$entity_list->MessageClose($npc, 1, 500, 335, "$Npc_Name body pulses with divine reverence.");

}

sub EVENT_COMBAT { 


  if ($combat_state == 1)  {
  quest::say("For the honor of the Dragorn!");
  quest::settimer("Slow", 55 );
  quest::settimer("Dark_Bal", 32 );
  quest::settimer("AE_Ice", 75 );
  quest::settimer("Leash_Check", 12);
  quest::settimer("LoS", 6);
  quest::stoptimer("Reset");
  }

 if ($combat_state == 0) {
 quest::settimer("Reset", 15);
 }

  

}

sub EVENT_TIMER {

if ($timer eq "Reset") {
quest::stoptimer("Reset");
quest::stoptimer("Slow");
quest::stoptimer("Dark_Bal");
quest::stoptimer("AE_Ice");
quest::stoptimer("Leash_Check");
quest::settimer("SetStats",1);
$npc->WipeHateList();
$npc->SetHP($npc->GetMaxHP() * 1);
quest::emote("calms down.");
quest::stopimer("LoS");
}

if ($timer eq "SetStats") {
quest::stoptimer("Reset");
quest::stoptimer("Slow");
quest::stoptimer("Dark_Bal");
quest::stoptimer("AE_Ice");
quest::stoptimer("Leash_Check");
quest::stoptimer("SetStats");
$NPC_X = $npc->GetX();
$NPC_Y = $npc->GetY();
$NPC_Z = $npc->GetZ();
$NPC_H = $npc->GetHeading();

$DragonAC = 1500 ;
$DragonMax = int(17500 * 0.75) ;
$DragonMin = int(6100 * 0.75) ;
$DragonACC = 200 ;
$DragonATK = 1800 ;
quest::modifynpcstat("ac", $DragonAC);
quest::modifynpcstat("max_hit", $DragonMax);
quest::modifynpcstat("min_hit", $DragonMin);
quest::modifynpcstat("accuracy", $DragonACC);
quest::modifynpcstat("atk", $DragonATK);
my $DTest = $npc->GetMaxDMG();
quest::gmsay("$DTest");
}

if ($timer eq "LoS") {
my $Target_Cl = $npc->GetTarget();
my $Target_ID = $Target_Cl->GetID();
my $LoS_Check = $npc->CheckLoS($Target_Cl);
#$Target_Cl->CastSpell(5244, $Target_ID);
#quest::shout("LOS CLEARED");
}


if ($timer eq "Leash_Check") {


	if ($x < -1025) {
	$npc->GMMove($NPC_X, $NPC_Y, $NPC_Z, $NPC_H);
	quest::stoptimer("Leash_Check");
	$npc->WipeHateList();
	$npc->SetHP($npc->GetMaxHP() * 1);
	}
	

}
#Frost thunder Slow + 9k DD
if ($timer eq "AE_Ice") {
quest::stoptimer("AE_Ice");
$TimerA = int(rand(35)) + 45;
quest::settimer("AE_Ice", $TimerA );
quest::emote("raises his gleaming blade in the air then strikes it into the ground.");
$npc->CastSpell(8875, $mobid);


}

if ($timer eq "Dark_Bal") {
quest::stoptimer("Dark_Bal");
$TimerA = int(rand(35)) + 45;
quest::settimer("Dark_Bal", $TimerA );
my $Spell_Target = $npc->GetTarget();
quest::settimer("Stun", 2 );

	if ($Spell_Target) {
	my $Spell_Target_ID = $Spell_Target->GetID();
	$npc->CastSpell(5022, $Spell_Target_ID);

	}
}

if ($timer eq "Stun") {
quest::stoptimer("Stun");
my $Spell_Target = $npc->GetTarget();

	if ($Spell_Target) {
	my $Spell_Target_ID = $Spell_Target->GetID();
	$npc->CastSpell(8561, $Spell_Target_ID);

	}
}

if ($timer eq "Slow") {
quest::stoptimer("Slow");
$TimerD = int(rand(15)) + 50; 
quest::settimer("Slow", $TimerD );
my $Spell_Target = $npc->GetTarget();
quest::emote("swipes his left claw at your arm.");

	if ($Spell_Target) {
	my $Spell_Target_ID = $Spell_Target->GetID();
	$npc->CastSpell(7718, $Spell_Target_ID);

	}
}



}

sub EVENT_DEATH {
quest::say("I have sacraficed myself for the honor of the Dragorn! Reverend smite these foes!");
quest::signalwith(859011,1,0);
quest::emote("armor lets out a loud clank as it hits the ground.");
}

sub EVENT_KILLED_MERIT {

if (defined($qglobals{Dranik_exp})) {
$Exp_mod = 100; 
quest::setglobal("Dranik_exp", $qglobals{Dranik_exp}+$Exp_mod, 5, "F");
my $total_energy = $qglobals{Dranik_exp} + $Exp_mod;
$client->Message(5, "Your Globe of Discordant Energy pulses, its power level has been raised to [$total_energy]! ");
}
}

