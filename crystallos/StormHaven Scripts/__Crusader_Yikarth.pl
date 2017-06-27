#314 emote white, 263, blue
#327 Raid cyan
#335 System yellow
#264,283,288 blue spell, 284 yell, 28 red, 303 white
#who 281 purple
#group 258,309 white
#guild, green 259, purple 281, white 310
#ooc 311 white, 260 green
#auction: 260, 261 green, 311, 312 white
#shout: 262 red, 313 white
#item speach, 344 yellow, 388 white.
#skills. 270 blue, 334 yellow, 338 white.
#pet response 337

sub EVENT_SPAWN {
quest::settimer("SetStats", 1);
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
$entity_list->MessageClose($npc, 1, 600, 335, "$Npc_Name experiences a divine balance.");
$entity_list->MessageClose($npc, 1, 600, 335, "$Npc_Name body pulses with divine reverence.");

}




sub EVENT_COMBAT { 


  if ($combat_state == 1)  {
  quest::say("My Marr guide me to victory!");
  quest::settimer("ArmorBreak", 89 );
  quest::settimer("Dark_Bal", 30 );
  quest::settimer("AE_Ice", 49 );
  quest::settimer("Leash_Check", 12);
  quest::stoptimer("Reset");
  quest::settimer("LoS", 6);
  }

 if ($combat_state == 0) {
 quest::settimer("Reset", 15);
 }


}

sub EVENT_TIMER {

if ($timer eq "Reset") {
quest::stoptimer("Reset");
quest::stoptimer("Armor Break");
quest::stoptimer("Dark_Bal");
quest::stoptimer("AE_Ice");
quest::stoptimer("Leash_Check");
quest::settimer("SetStats",1);
quest::stopimer("LoS");
$npc->WipeHateList();
$npc->SetHP($npc->GetMaxHP() * 1);
quest::emote("calms down.");
}

if ($timer eq "SetStats") {
quest::stoptimer("Reset");
quest::stoptimer("Armor Break");
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
}

if ($timer eq "Leash_Check") {


	if ($x < -1025) {
	$npc->GMMove($NPC_X, $NPC_Y, $NPC_Z, $NPC_H);
	quest::stoptimer("Leash_Check");
	$npc->WipeHateList();
	$npc->SetHP($npc->GetMaxHP() * 1);
	}
	

}

if ($timer eq "LoS") {
my $Target_Cl = $npc->GetTarget();
my $Target_ID = $Target_Cl->GetID();
my $LoS_Check = $npc->CheckLoS($Target_Cl);
#$Target_Cl->CastSpell(5244, $Target_ID);
#quest::shout("LOS CLEARED");
}


#Arctic Blast -13330 -500 mana
if ($timer eq "AE_Ice") {
quest::stoptimer("AE_Ice");
$TimerX = int(rand(35)) + 50; 
quest::settimer("AE_Ice", $TimerX );
my $Spell_Target = $npc->GetTarget();
quest::emote("blades shimmers as he calls out a prayer to Marr.");

	if ($Spell_Target) {
	my $Spell_Target_ID = $Spell_Target->GetID();
	$npc->CastSpell(4471, $Spell_Target_ID);

	}
}

if ($timer eq "Dark_Bal") {
quest::stoptimer("Dark_Bal");
$TimerA = int(rand(35)) + 35;
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

if ($timer eq "ArmorBreak") {
quest::stoptimer("ArmorBreak");
$TimerC = int(rand(35)) + 45; 
quest::settimer("ArmorBreak", $TimerC );
my $Spell_Target = $npc->GetTarget();

	if ($Spell_Target) {
	my $Spell_Target_ID = $Spell_Target->GetID();
	$npc->CastSpell(8424, $Spell_Target_ID);

	}
}

}

sub EVENT_DEATH {
quest::say("I die for the honor of the Dragorn...");
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

