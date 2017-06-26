sub EVENT_ITEM_CLICK_CAST {
  if($spell_id == 1806) {
    quest::castspell(1806, $client->GetID());
}
