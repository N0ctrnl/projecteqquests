sub EVENT_SPAWN {
  quest::set_proximity($x - 4000, $x + 4000, $y - 4000, $y + 4000,$z - 200, $z + 200);
}

sub EVENT_ENTER {
	#if(($client->GetClientVersionBit() & 3)!= 0) { #062/Titanium
		quest::movepc(10,-1570,-25,20,231);
	#} else {
	#	quest::movepc(382,-1442,-1012,35,0); #SoF+
	#}
}
