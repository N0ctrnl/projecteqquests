sub EVENT_SPAWN {
  quest::settimer(1,300);
}

sub EVENT_TIMER {
  if($timer == 1) {
    quest::stoptimer(1);
    quest::say("Where is that sniveling little worm?");
    quest::settimer(2,10);
  }
  elsif($timer == 2) {
    quest::stoptimer(2);
    quest::say("He was supposed to be here hours ago!");
    quest::settimer(3,10);
  }
  elsif($timer == 3) {
    quest::stoptimer(3);
    quest::say("I don't know why the chief tolerates this insolent fool. If he is discovered he'll betray us for sure.");
    quest::settimer(4,10);
  }
  elsif($timer == 4) {
    quest::stoptimer(4);
    quest::say("If he makes me wait another minute I'll gut him myself...");
    quest::settimer(5,10);
  }
  elsif($timer == 5) {
    quest::stoptimer(5);
    quest::spawn2(116140,0,0,1056,-3406,145.55,195);
    quest::settimer(6,10);
  }
  elsif($timer == 6) {
    quest::stoptimer(6);
    quest::say("Ahh, good to see you my little friend, I was beginning to think something had happened to you.");
    quest::settimer(7,300);
  }
  elsif($timer == 7) {
    quest::stoptimer(7);
    quest::depop(116140);
    quest::settimer(1,300);
  }
}
