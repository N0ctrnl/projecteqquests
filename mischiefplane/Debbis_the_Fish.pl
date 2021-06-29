sub EVENT_SAY {
  if ($text=~/hail/i) {
    quest::say("If only I could walk in somebody elses shoes just for a day. It's not easy being a skunk you know.");
  }
}

sub EVENT_ITEM {
  if (plugin::check_handin(\%itemcount, 6883 => 1)) {
    quest::say("Oh wow! A rabbits foot!! Thank you so much. Here take this, I won't need this smelly thing any more.");
    quest::summonitem(3190);
    quest::faction(391,51);
    quest::exp(100);
  }
  plugin::return_items(\%itemcount);
} 
