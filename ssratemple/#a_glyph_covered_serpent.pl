sub EVENT_DEATH_COMPLETE {
	quest::setglobal("glyphed_dead",1,3,"D4");
	quest::signalwith(10,1,1);
}
