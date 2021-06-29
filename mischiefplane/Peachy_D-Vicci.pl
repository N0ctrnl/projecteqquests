#Zone: Plane of Mischief
#Short Name: mischiefplane
#Zone ID: 126
#
#NPC Name: Peachy D`Vicci
#NPC ID: 126171

sub EVENT_SAY {
  if ($text=~/hail/i) {
    quest::say("Hey there! Wanna test your luck? I have here my mystery satchel filled with gifts. Sometimes you get something nice, and sometimes ya get nothing at all. Wanna give it a shot? It only costs two funnies.");
  }
}

sub EVENT_ITEM {
  if (plugin::check_handin(\%itemcount, 9504 => 2)) {
    quest::summonitem(quest::ChooseRandom(9505,9506,9507,9508,9509,9511,9512,9513,6877));
    quest::emote("reaches into her satchel and pulls out a small box.");
    quest::say("Here ya go! Enjoy it. Come back soon. Just a warning though, I cant give you a box that you already have. There isn't enough for everyone you know!");
  }
  plugin::return_items(\%itemcount);
} 
