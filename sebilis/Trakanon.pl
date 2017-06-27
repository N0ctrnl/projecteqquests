#BEGIN File: sebilis\#Trakanon.pl

sub EVENT_SPAWN {
  quest::attacknpc(89168)
}

sub EVENT_DEATH_COMPLETE {
  quest::signalwith(10,1,0); #UDB - Signal to start timer on UDB
}
