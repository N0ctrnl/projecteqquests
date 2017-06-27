sub EVENT_DEATH_COMPLETE {
	quest::setglobal("exiled_dead",1,3,"D4");
	quest::signalwith(10,2,0);
}
