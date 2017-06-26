sub EVENT_SPAWN {
	$x = $npc->GetX();
	$y = $npc->GetY();
	quest::set_proximity($x - 70, $x + 70, $y - 70, $y + 70);
}

sub EVENT_ENTER {
	$client->Message(315, "Greater Faydark");
	quest::movepc(54,-56.33,2552.77,18.97,125);
}

sub EVENT_EXIT {
	quest::set_proximity($x - 70, $x + 70, $y - 70, $y + 70);
}
