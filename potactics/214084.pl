sub EVENT_SPAWN {
  quest::settimer(1,300);
}

sub EVENT_TIMER {
  quest::stoptimer(1);
  if($timer == 1){
    quest::depop();
  }
}

sub EVENT_COMBAT {
  if($combat_state == 0){
    quest::settimer(1,300);
  } elsif($combat_state == 1){
    quest::stoptimer(1);
  }
}
