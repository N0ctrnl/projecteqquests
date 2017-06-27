sub EVENT_SPAWN
{
	quest::moveto(446.6,666.7,-46.8,0,1);
	quest::settimer(healing,18);
}

sub EVENT_TIMER
{

	if ($timer eq "healing"){

	$entity_list->MessageClose($npc, 1, 20000, 1, "healing waters begins to cast a spell. (Waters of Life)");
	quest::signalwith(999999,"waterheal",0);
	quest::gmsay("heal signal sent",13,0);

	}
}

sub EVENT_SIGNAL{}