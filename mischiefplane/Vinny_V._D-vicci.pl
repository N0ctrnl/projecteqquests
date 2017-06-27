#Zone: Plane of Mischief
#Short Name: mischiefplane
#Zone ID: 126
#
#NPC Name: Vinny V. D'vicci
#NPC ID: 126277

sub EVENT_SAY {
  if ($text=~/hail/i) {
    quest::say("I'm fishing fishing fishing. I fish the whole week through. Just fishing fishing fishing. It's what I always do.");
  }
  elsif ($text=~/what card/i) {
    quest::say("Ya I know cards. But info aint free ya know. Now I've been down in the luck department. Im lookin for a good luck charm. Im sure theres one to be found in here somewhere's. And if ya happen to find any of em cods.. cahds.. whateva.. Just hand em on over. Jus none of em kings, squires, thrones, jesters, or crowns. Those cahds are common.");
  }
  elsif ($text=~/pot of gold/i) {
    quest::say("Pot o` gold? Bwahahahaha! Only pot around is them ones I warsh my clothes in. Gotta be careful though, one time I dropped one of dem woids of wealth in and BADABING no clothes jus a stinkin coin that wouldn't buy me a fishin grub.");
  }
  elsif ($text=~/mouse/i) {
    quest::say("Yah well, can't say I blame ya kid. Ol` Bristle may be soft but he's a wily one. Rats in the sewers kid, they gots some cards. Have yerself some fun wid em. I'll see ya around.");
  } 
  elsif ($text=~/man/i) {
    quest::say("Foist ya gotta help my brudda Bob. Getcherself one of em books `es talkin about. Den.. ya`s gotta find me dem woids of wealth. Well? Watcha standin here gawkin at me for? Get movin!");
  }
}

sub EVENT_ITEM {
  if (plugin::check_handin(\%itemcount, 18008 => 1)) {
    quest::say("Ha! Yer a brave one aintcha. You really think yooz can take over da god's domain? Bwahahahahaha! Well tanks kid. Now go away, quit botherin me. I don't need no stinkin mailman. I need a general.");
    quest::faction(391,10);
  }
  elsif (plugin::check_handin(\%itemcount, 6876 => 1)) {
    quest::say("Nice work kid. Now I'm feelin lucky. So's ya say ya wanna learn about cards right? Lemme tell ya. Them cards are nice but lets have some REAL fun. Yer resourceful, I like that. What say we take over this joint fer ourselves? Ol' Bristle's gettin soft, ya know? Wadda ya say? Man or mouse?");
    quest::faction(391,30);
    quest::exp(30);
  }
  elsif ((plugin::check_handin(\%itemcount, 1787 => 1)) || (plugin::check_handin(\%itemcount, 1788 => 1)) || (plugin::check_handin(\%itemcount, 1789 => 1)) || (plugin::check_handin(\%itemcount, 1790 => 1)) || (plugin::check_handin(\%itemcount, 1791 => 1))) {
    quest::say("Oh wow! Yooz found a fish card! Tanks!");
    quest::faction(391,10);
  }
}

