sub EVENT_SPAWN {
  quest::settimer("bbshout",10);
}
  
sub EVENT_TIMER {
  if ($timer eq "bbshout") {
    quest::stoptimer("bbshout");
    quest::shout("Bah! Where be the Cazic Thule Puppet! Ridiculously funny!");
    quest::settimer("bbsay",10);
  }
  if ($timer eq "bbsay") {
    quest::stoptimer("bbsay");
    quest::say("Well, there is nothing to see here. Go home everyone!");
    quest::depop_withtimer();
  }
}
