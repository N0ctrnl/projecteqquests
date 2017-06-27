# beginning of the arch lich rhag`zadune cycle
#
sub EVENT_SPAWN {
  quest::disable_spawn2(382989); # Disable Rhag2
  quest::disable_spawn2(382990); # Disable Arch Lich
}

sub EVENT_DEATH_COMPLETE {
  quest::setglobal("rhag1_dead",1,3,"S259200");
  quest::enable_spawn2(382989); # Enable Rhag2
  quest::signalwith(10,4,1);
}

# EOF zone: ssratemple ID: 162178 NPC: #Rhag`Zhezum

