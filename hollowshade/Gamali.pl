
sub EVENT_ITEM {
  if (plugin::check_handin(\%itemcount, 16598 => 1)) {
    quest::say("Thank you! Here is a bottle of fresh water.");
	quest::summonitem(31761);
  }
  plugin::return_items(\%itemcount);
}
#END of FILE Zone:hollowshade  ID:166000 -- Ahom_Guzhin