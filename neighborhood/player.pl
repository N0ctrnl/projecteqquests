sub EVENT_CLICKDOOR {

my $door = $entity_list->GetDoorsByDoorID($doorid);
	if($door->GetModelName() eq "OBP_LOTSQUARE")
	{
		$client->Message(15, "This is a house plot. What would you like to do with it?");
		$client->Message(15, quest::saylink("#house check", 1, "   ::Check Ownership"));
		$client->Message(15, quest::saylink("#house buy", 1, "   ::Buy this House"));
		$client->Message(15, quest::saylink("#house sell", 1, "   ::Sell this House"));
		$client->Message(15, quest::saylink("#house payrent", 1, "   ::Pay this House's Rent"));
		$client->SetEntityVariable("HouseInteractID", $door->GetDoorDBID());
	}
}