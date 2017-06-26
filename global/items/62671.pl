sub EVENT_ITEM_CLICK {
plugin::debug("Test"};
	if($spell_id == 7653)
	{
		$client->SetEntityVariable("PlacingItemID", $itemid);
		$client->SetEntityVariable("PlacingGrowth", 500);
		$client->SetEntityVariable("PlacingSize", 10);
		$client->Message(15, "You ready the $itemname for use.");
		return 1;
	}
	return 0;
}

sub EVENT_DROP_ITEM
{
	if($spell_id == 7653)
	{
		$client->Message(15, "The $itemname falls back into your hands. You must destroy that item or place it using its click effect.");
		quest::summonitem($itemid, $quantity);
		return 1;
	}
	return 0;
}
