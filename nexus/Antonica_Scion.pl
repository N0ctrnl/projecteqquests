sub EVENT_SAY {
  if ($text=~/Hail/i){
    quest::say("Hello there. The spires are undergoing maintenance. If you need to know more about [" . quest::saylink("travel to The Commonlands") . "], I can help you with this.");
  }
  elsif ($text=~/travel to The Commonlands/i){
    quest::selfcast(2708); #antonica
  }
}
