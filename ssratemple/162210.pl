# #a_shissar_wraith
sub EVENT_SPAWN {
  quest::settimer("depop", 1800);
  quest::disable_spawn2(20000);
  quest::disable_spawn2(20001);
  quest::disable_spawn2(19997);
  quest::disable_spawn2(19996);
  quest::disable_spawn2(20002);
  quest::disable_spawn2(20003);
  quest::disable_spawn2(19998);
  quest::disable_spawn2(19999);

}

sub EVENT_TIMER {
  if ($timer eq "depop") {
    quest::stoptimer("depop");
    quest::depop();
  }
}
