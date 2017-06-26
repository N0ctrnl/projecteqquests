sub EVENT_SAY {
  if ($text=~/hail/i) {
    quest::say("Do you have something Ferjeneror?");
  }
  elsif ($text=~/no/i) {
    quest::say("Then DIE!");
    quest::attack($name);
  }
  elsif ($text=~/yes/i) {
    quest::say("THEN GIVE IT!");
  }
  elsif ($text=~/give what/i) {
    quest::say("Outside the gates of fur lined feet. There lies a swarm of smelly meat. A single king or colors four, you must supply for Generor.");
  }
}

sub EVENT_ITEM {
  if ((plugin::check_handin(\%itemcount, 1787 => 1)) && (plugin::check_handin(\%itemcount, 1788 => 1)) && (plugin::check_handin(\%itemcount, 1789 => 1)) && (plugin::check_handin(\%itemcount, 1790 => 1))) {
    quest::say("Indeed you found the four I need. I give you this to feed your greed. A paper knight of blackened heart. A paper throne to match his art. A paper crown of darkest night. And bloody throne to show his might. Together hide within your deck. To guard that mess below your neck.");
    quest::summonitem(17054);
    quest::exp(100);
  }
  elsif (plugin::check_handin(\%itemcount, 1791 => 1)) {
    quest::say("Indeed you found the one I need. I give you this to feed your greed. A paper knight of blackened heart. A paper throne to match his art. A paper crown of darkest night. A throne of ice to chill the sight. Inside the deck you place the four, to guard the wings that fly the floor.");
    quest::summonitem(17054);
    quest::exp(100);
  }
  plugin::return_items(\%itemcount);
} 
