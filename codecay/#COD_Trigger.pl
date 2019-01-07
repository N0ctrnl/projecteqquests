sub EVENT_SPAWN{
  quest::settimer(77,3600); #1 hour depop
  $high_priest=0;
}

sub EVENT_TIMER {
  if($timer == 77 && $high_priest == 2){
    quest::stoptimer(77);
    quest::spawn2(200032,0,0,310,328,-71.5,250);
    $high_priest=0;
  }

  if($timer == 69) {
    quest::stoptimer(69);
    $high_priest=0;
  }
}

sub EVENT_SIGNAL{
  $high_priest=$high_priest+1;
  quest::settimer(69,14400);
}

