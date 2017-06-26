sub EVENT_SAY {
  if ($text=~/hail/i) {
    quest::say("Greetings, friend. Perhaps an intelligent Erudite such as you can assist me in a friendly game of find the exit. I really like being with friends rather than being alo... No! NONONO! Make the fluffy goodness stop! You must help me! Squire!!! Squire! Curse him where is he when I need him. Find my squire you pathetic fool!");
    quest::depop_withtimer();
  }
}

sub EVENT_ITEM {
  if (plugin::check_handin(\%itemcount, 24553 => 1)) {
    quest::say("You have found it!! Thank Innoruuk! I am sorry that you had to witness my moment of weakness. These tunnels twist and bend my very thoughts. Perhaps this trinket will assist you in your journey. I pray to the lord of hate that you find this madman and put an end to this insanity. ");
    quest::summonitem(13073,1);
  }
  plugin::return_items(\%itemcount);
  quest::depop_withtimer();
}
