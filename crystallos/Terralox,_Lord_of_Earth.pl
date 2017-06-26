###############################################################################################################################
##TODO figure out why there is such a delay between sending the grid command and actually starting to move to 1st WP         ##
##TODO work on boulder script. find a better way to moveto random player, hit, then explode.																															 ##
##																															 ##
##EVENT INFO - Terralox - 1000013
##             Terratykes - 1000014
##			   Boulder - 1000015																											 ##
##
##  GRID# 546786                                                                                                                           ##
###############################################################################################################################

sub EVENT_SPAWN 
{
	#plugin::ModSpecialAttack("SERrFQMCNIDfABH"); #immune to melee/spells no aggro
	plugin::Debug("Spawn $mobid");
	quest::modifynpcstat(runspeed, 0); #root mob
	quest::set_proximity($x-170,$x+170,$y-170,$y+170,$z-170,$z+10); #proximity for enter event
	#$npc->SendAppearanceEffect(335);

}

sub EVENT_SAY 
{

my $business = quest::saylink("business",1);
my $Storm_of_the_Elements = quest::saylink("Storm of the Elements",1);
my $wrath = quest::saylink("wrath",1);
 
 
    if ($text =~/Hail/i){
    quest::say("What brings mortals this deep into the realm of the earth keepers? Ponz Knows better than to let anyone get by. Very well then, off you go. You have no [$business] here."); 
    }

	if ($text =~/business/i){
	quest::emote ("roars with laughter.");
	quest::say("You dare threaten me? The great keeper of earth! Foolish mortals, be off with you I don't have time for this. [$Storm_of_the_Elements] should have stopped you at the gate");
	}

	if ($text =~/Storm of the Elements/i){
	quest::say("Storm of the Elements sent you, you say?. How dare you attempt to decieve me! Storm of the Elements does not send anyone into our realm. This is not the place for mortals. I've asked you to leave, now my patience has grown thin! Leave at once, or deal with my [$wrath]!");
	}

	if ($text =~/wrath/i){
	quest::me ("Terralox's shell slightly shifts, as he readies himself to attack.");
	quest::shout("Prepare to meet your fate mortals!");
	$npc->NPCSpecialAttacks(ABH,1); #attackble
	quest::settimer("boulder1",20); 
	quest::settimer("tykes",30);
	#quest::setnexthpevent(75);
	plugin::Debug("first timers started");
	}
}

sub EVENT_ENTER 
{
	quest::emote("senses the presence of creatures unnatural to this realm.");
	quest::clear_proximity();
	
}

sub EVENT_COMBAT 
{

	if ($combat_state == 0) 
	{
	
	}
	
	if ($combat_state == 1)
	{
	#quest::setnexthpevent(75);
	quest::clear_proximity();	
	}
	
	if ($npc->GetHPRatio()>=75)	{ quest::setnexthpevent(75); }
	#if ($npc->GetHPRatio()>=50) ( quest::setnexthpevent(50); }
}

sub EVENT_HP 
{

	if ($hpevent == 75) 
	{
	#quest::clear_proximity();
	$npc->WipeHateList();
	quest::modifynpcstat(runspeed, 2.25);
	quest::stoptimer("boulder1");
	quest::stoptimer("tykes");
	$npc->NPCSpecialAttacks(ABH,0);
	quest::emote("'s shell hardens as he prepares to move.");
	#quest::start(546786);#starts movement grid
	plugin::Debug("HP Event $hpevent fired");
	}

	if ($hpevent == 50) 
	{
	#quest::clear_proximity();
	$npc->WipeHateList();
	quest::modifynpcstat(runspeed, 2.25);
	quest::stoptimer("boulder1");
	quest::stoptimer("tykes");
	$npc->NPCSpecialAttacks(ABH,0);
	quest::emote("'s shell hardens as he prepares to move.");
	#quest::start(546786); #starts movement grid
	plugin::Debug("HP Event $hpevent fired");
	}
	
	if ($hpevent ==25)
	{
	$npc->WipeHateList();
	quest::modifynpcstat(runspeed, 2.25);
	quest::stoptimer("boulder1");
	quest::stoptimer("tykes");
	$npc->NPCSpecialAttacks(ABH,0);
	quest::emote("'s shell hardens as he prepares to move.");
	#quest::start(546786);
	plugin::Debug("HP Event $hpevent fired");
	}
	
	if ($hpevent == 7)
	{
	$npc->WipeHateList();
	quest::modifynpcstat(runspeed, 10.0);
	quest::stoptimer("boulder1");
	quest::stoptimer("tykes");
	$npc->NPCSpecialAttacks(ABH,0);
	quest::emote("Scuttles away quickly, you must finish him!");
	#quest::start(546786);
	plugin::Debug("HP Event $hpevent fired");
	}
	
	if ($hpevent == 1)
	{
	$npc->WipeHateList();
	quest::settimer("END1",5);
	plugin::Debug("HP Event $hpevent fired");
	}
}

sub EVENT_TIMER 
{

	if ($timer eq "boulder1")
	{
	quest::doanim(19);
	quest::spawn2(1000015,0,0,$x,$y,$z,$h); #spawns boulder NPC, Boulder set to pick random player hit for 32k then explode
	plugin::Debug("TIMER $timer FIRED");
	}
	
	if ($timer eq "MOVE1")
	{
	$npc->NPCSpecialAttacks(ABH,1);
	quest::modifynpcstat(runspeed, 0);
	quest::emote("says something about something and blah blah");
	quest::stoptimer("MOVE1");
	quest::settimer("boulder1",20);
	quest::settimer("tykes",30);
	quest::setnexthpevent(50);
	plugin::Debug("TIMER $timer started");	
	}
	
	if ($timer eq "MOVE2")
	{
	$npc->NPCSpecialAttacks(ABH,1);
	quest::modifynpcstat(runspeed, 0);
	quest::emote("says something about something and blah blah");
	quest::stoptimer("MOVE2");
	quest::settimer("boulder1",20);
	quest::settimer("tykes",30);
	quest::setnexthpevent(25);
	plugin::Debug("TIMER $timer started");	
	}
	
	if ($timer eq "MOVE3")
	{
	$npc->NPCSpecialAttacks(ABH,1);
	quest::modifynpcstat(runspeed, 0);
	quest::emote("says something about something and blah blah");
	quest::stoptimer("MOVE3");
	quest::settimer("boulder1",20);
	quest::settimer("tykes",30);
	quest::setnexthpevent(7);
	plugin::Debug("TIMER $timer started");	
	}
	
	if ($timer eq "tykes")
	{
	quest::say("come forth little ones, and feast on the mortals!");
	quest::spawn2(1000014,0,0,$x+10,$y,$z,$h);
	quest::spawn2(1000014,0,0,$x-10,$y,$z,$h);
	quest::spawn2(1000014,0,0,$x,$y+10,$z,$h);
	quest::spawn2(1000014,0,0,$x,$y-10,$z,$h);
	quest::spawn2(1000014,0,0,$x+10,$y-10,$z,$h);
	quest::spawn2(1000014,0,0,$x-10,$y+10,$z,$h);
	quest::spawn2(1000014,0,0,$x+10,$y+10,$z,$h);
	quest::spawn2(1000014,0,0,$x-10,$y-10,$z,$h);
	plugin::Debug("TIMER $timer fired");
	}
	
	if ($timer eq "END1")
	{
	quest::stoptimer("END1");
	quest::say("You have bested me this day!");
	quest::settimer("END2",2);
	plugin::Debug("TIMER $timer started");
	}
	
	if ($timer eq "END2")
	{
	quest::stoptimer("END2");
	quest::say("I shall sacrifice myself to the Earthen Gods as to not bring anymore shame to them");
	#$npc->Kill;
	quest::settimer("END3",2);
	plugin::Debug("TIMER $timer started");
	}
	
	if ($timer eq "END3")
	{
	quest::emote("throws himself into the pit behind him, as the Earthen Gods bestow treasures upon you");
	plugin::Debug("TIMER $timer started");
	quest::stoptimer("END3");
	quest::settimer("KILL",2);
	plugin::SetAnim(dead);
	}
	
	if ($timer eq "KILL")
	{
	quest::stoptimer("KILL");
	#quest::spawn2(999343,0,0,-124.4,2868.9,-321.2,34.9); #spawn chest
	quest::depop(1000013);
	
	}
}

sub EVENT_WAYPOINT_ARRIVE
{

	if ($wp == 4)
	{
	$npc->SaveGuardSpot(); #makes NPC not run back to wp 1
	plugin::Debug("arrived at [$wp] at [$x, $y, $z]");
	quest::stop(); #stops the grid (should this be pause?)
	quest::settimer("MOVE1",1);
	plugin::Debug("TIMER $timer started");
	}
		
	if ($wp == 8)
	{
	$npc->SaveGuardSpot(); #makes NPC not run back to wp 1
	plugin::Debug("arrived at [$wp] at [$x, $y, $z]");
	quest::stop(); #stops the grid (should this be pause?)
	$npc->SaveGuardSpot();
	quest::settimer("MOVE2",1);
	plugin::Debug("TIMER $timer started");
	}
		
	if ($wp == 14)
	{
	$npc->SaveGuardSpot(); #makes NPC not run back to wp 1
	plugin::Debug("arrived at [$wp] at [$x, $y, $z]");
	quest::stop(); #stops the grid (should this be pause?)
	$npc->SaveGuardSpot();
	quest::settimer("MOVE3",1);
	plugin::Debug("TIMER $timer started");
	}
	
	if ($wp == 26)
	{
	quest::forcedooropen(43);
	quest::forcedooropen(44);
	}
	
	if ($wp == 27)
	{
	$npc->SaveGuardSpot(); #makes NPC not run back to wp 1
	plugin::Debug("arrived at [$wp] at [$x, $y, $z]");
	quest::stop(); #stops the grid (should this be pause?)
	$npc->SaveGuardSpot();
	$npc->NPCSpecialAttacks(ABH,1);
	quest::modifynpcstat(runspeed, 0);
	quest::setnexthpevent(1);
	plugin::Debug("waiting for hpevent 1");
	}
	
	
}

sub EVENT_WAYPOINT_DEPART{

	if ($wp == 0){
	quest::forcedooropen(45); #opens doors leading out of room
	quest::forcedooropen(46);
	plugin::Debug("Doors opening");
	}
}
	