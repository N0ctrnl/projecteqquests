# second part of the arch lich rhag`zadune cycle
#

sub EVENT_DEATH_COMPLETE {
  quest::setglobal("rhag2_dead",1,3,"S259200");
  quest::signalwith(10,5,1);
}

# EOF zone: ssratemple ID: 162178 NPC: #Rhag`Mozdezh

