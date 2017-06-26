sub EVENT_SPAWN {
  quest::settimer(1,5);
}

sub EVENT_TIMER {
  if($timer == 1) {
    quest::stoptimer(1);
    quest::say("Uhhh... I'm not feeling so good. Someone call for a cleric.");
    $npc->SetAppearance(0);
    $npc->SetAppearance(3);
  }
}
