sub EVENT_SPAWN {
  quest::settimer(1,30);
}

sub EVENT_AGGRO {
  quest::stoptimer(1);
}

sub EVENT_TIMER {
  quest::stoptimer(1);
  if($timer == 1 && !$hate_state){
    quest::depop();
  }
}

sub EVENT_HATE_LIST {
  quest::stoptimer(1);
  if(!$hate_state){
    quest::settimer(1,30);
  }
}
