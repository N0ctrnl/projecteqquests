## Tirranum_the_Arisen 870057
## Final form
## Spell 6536 Tirranums fire ae goes off entire fight 1 min intervals
## at 89% start doing DS 500dd
## at 80% PBAE/fire +knockback every 15 sec
## 90-50% adds every 30 sec, 50-20 every 20 sec, from 20-0 every 15sec
## adds die when dragon dies, all timers stop. Loot on corpse.

$combat_start;

sub EVENT_COMBAT {

	if ($combat_state == 1)
	{
		quest::setnexthpevent(89);
		quest::emote("eyes burn with rage");
		quest::settimer("Tirr_AE2",90);
		quest::settimer("Tirr_Adds4", 45);
		#$npc->SetHP(1350000);  
		$npc->SetHP($npc->GetMaxHP() * .9);
		plugin::CastOnTarget(6536);
		$combat_start=1;
		quest::signalwith(2700631,1,0);
	}



	if ($combat_state == 0)
	{
		quest::emote("recovers quickly from the battle");
		#$npc->SetHP(1500000);
		$npc->SetHP($npc->GetMaxHP() * 1);
		quest::stoptimer("Tirr_DS2");
		quest::stoptimer("Tirr_AE2");
		quest::stoptimer("Tirr_AE3");
		quest::stoptimer("Tirr_Adds4");
		quest::stoptimer("Tirr_Adds5");
		quest::stoptimer("Tirr_Adds6");
		quest::depop (2700631);  
		  
		if ($combat_start == 1)
		{
			$combat_start=2;
			quest::signalwith(2700631,2,300000);
			quest::settimer("depop_adds",180);
		}
	}

}

sub EVENT_HP  { 

  if ($hpevent == 89) {
    quest::setnexthpevent(81);
    quest::settimer("Tirr_DS2",60);
    quest::emote("skin ignites in flames");
$npc->CastSpell(6145,$mobid); }

  if ($hpevent == 81) {
    quest::setnexthpevent(51);
    quest::settimer("Tirr_AE3",120);
#   quest::shout("ae3 START");
plugin::CastOnTarget(6542); }

  if ($hpevent == 51) {
    quest::setnexthpevent(21);
    quest::settimer("Tirr_Adds5",35);
    quest::stoptimer("Tirr_Adds4"); }

  if ($hpevent == 21) {
    quest::settimer("Tirr_Adds6",25);
    quest::stoptimer("Tirr_Adds5"); }

}

sub EVENT_TIMER {

  if ($timer eq "Tirr_DS2") {
    quest::emote("skin ignites in flames");
#   quest::shout("ae ds");
$npc->CastSpell(6145,$mobid); }

  if ($timer eq "Tirr_AE2") {
    quest::emote("unleashes a deadly wave of flames");
#   quest::shout("ae 2");
plugin::CastOnTarget(6536); }

  if ($timer eq "Tirr_AE3") {
    quest::emote("unleashes a scalding blast");
#   quest::shout("ae 3");
plugin::CastOnTarget(6542); }

  if ($timer eq "Tirr_Adds4") {
    quest::spawn2(870064,0,0, -798.56, 3386.64, -85.00,0);
    quest::settimer("Tirr_Adds4", 45); }

  if ($timer eq "Tirr_Adds5") {
    quest::spawn2(870064,0,0, -798.56, 3386.64, -85.00,0);
    quest::settimer("Tirr_Adds5",35); }

  if ($timer eq "Tirr_Adds6") {
    quest::spawn2(870064,0,0, -798.56, 3386.64, -85.00,0);
    quest::settimer("Tirr_Adds6",25); }

  if ($timer eq "depop_adds") {
    if ($combat_start == 2) {
      quest::depopall (870059); }
   }

}



sub EVENT_DEATH {

$timestamp = localtime(time);

  quest::spawn2(2700633,0,0, -740.2, 2914.7, 42.2,120.9);
  quest::stoptimer("Tirr_DS2");
  quest::stoptimer("Tirr_AE2");
  quest::stoptimer("Tirr_AE3");
  quest::stoptimer("Tirr_Adds4");
  quest::stoptimer("Tirr_Adds5");
  quest::stoptimer("Tirr_Adds6");
  quest::emote("flames have been extinquished");
  quest::depop (2700631);  
  quest::depop (870064);
  quest::depopall (870059);
  quest::write("text_files/bossdeaths.txt","[$timestamp]: $mname was killed by $name, the $class ~~~");

}
