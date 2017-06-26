#Zone: Plane of Mischief
#Short Name: mischiefplane
#Zone ID: 126
#
#NPC Name: Bob the Painter
#NPC ID: 126268

sub EVENT_SAY {
  if ($text=~/hail/i) {
    quest::say("Ey yo. Ever read the book of mischief? The libraries full of em! Say... if you ever find the missin chapter on wealth, lemme know. I'll give ya this here pot o' gold I found.");
  }
  elsif ($text=~/library/i) {
    quest::say("I'd love ta check out a book... especially the book of mischief. Every time I get a library card, them freakin monkeys come and take it from me. Say, maybe you can get one from em!");
  }
}

sub EVENT_ITEM {
  if (plugin::check_handin(\%itemcount, 18008 => 1)) {
    quest::summonitem(17326);
    quest::say("Ay!!! this is poifect! 'ere take this pot o' gold. It's empty at the moment. Go ask my brother Vinny about the pot and mebbe he'll have a clue how ta get it full agin.");
  }
   plugin::return_items(\%itemcount);
} 

sub EVENT_SIGNAL {
  if ($signal == 1) { #Treasure Chest is aggro. Despawn.
    quest::say("Oh my! You've done gone made them angry. I'm outta here.");
    quest::depop_withtimer();
  }
}
