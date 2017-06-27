sub EVENT_ITEM {
  if (plugin::check_handin(\%itemcount, 24565 => 1)) {
    quest::say("You have found it!! Thank Tunare! I apologize for my rude behaviour. These tunnels twist and bend my very thoughts. Perhaps this will assist you in your escape from this cruel joke Fizzlethorpe has been playing with our minds. I thank you friend.");
    quest::summonitem(13073);
    quest::depop_withtimer();
  }
  plugin::return_items(\%itemcount);
}

sub EVENT_SAY {
  if($text=~/hail/i) {
  quest::say("Greetings! It is good to see another face within these depths. I have been traveling these mazes for many months now. Judging by the look of you, I do not expect that you will locate the exit. Especially since I have not yet been able to. My only wish is to find a squire to complete my knighthood. Say you wouldn't happen to... never mind. I do not expect that you can even comprehend the full extent of my attempt to communicate with you.");
  }
}
