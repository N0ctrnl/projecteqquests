# Gargoyle Illusion Click

#sub EVENT_ITEM_CLICK_CAST {
sub EVENT_SPELL_EFFECT_CLIENT {
  $Zone = $client->GetZoneID();
  if($Zone < 187 || $Zone == 202 || $Zone == 203 || $Zone == 408 || $Zone == 226 || $Zone == 411) {
# Acumen first, then the good ones. This keeps MGB from working with the first spell (FoE).
    if($mlevel > 44){
      quest::castspell(2886, $client->GetID());
      quest::castspell(3185, $client->GetID());
      quest::castspell(2510, $client->GetID());
      quest::castspell(2590, $client->GetID());
      quest::castspell(1464, $client->GetID());
      quest::castspell(2629, $client->GetID());
      quest::castspell(2570, $client->GetID());
      quest::castspell(2895, $client->GetID());
      quest::castspell(2530, $client->GetID());
      quest::castspell(1580, $client->GetID());
    }
    elsif ($mlevel < 44 && $mlevel > 20){
      # Just a dummy spell for now (damage shield)
      quest::castspell(356, $client->GetID());
    } else {
	  #    quest::castspell(2886, $client->GetID());
	  #    quest::castspell(3185, $client->GetID());
	  #    quest::castspell(2510, $client->GetID());
	  #    quest::castspell(2590, $client->GetID());
	  #    quest::castspell(1464, $client->GetID());
	  #    quest::castspell(2629, $client->GetID());
	  #    quest::castspell(2570, $client->GetID());
    #    quest::castspell(2895, $client->GetID());
    #    quest::castspell(60001, $client->GetID());
    #    quest::castspell(2530, $client->GetID());
    #    quest::castspell(1580, $client->GetID());

        plugin::Whisper("You cannot use this item in your current zone");
    #    plugin::Whisper("By the grace of the almighty Ender, you are now buffed");
    #    quest::summonitem(132521,1);
    }
  }
}
