# Gargoyle Illusion Click

sub EVENT_ITEM_CLICK {
  if($spell_id == 28013 && ($questitem->IsAttuned() == 1)) {
    $client->CastSpell(12454, $client->GetID());
  }
  elsif ($questitem->IsAttuned() != 1) {
    $client->Message(13, "You must attune this item to your character (by equipping it) before you can use the activated effect.");
  }
}
