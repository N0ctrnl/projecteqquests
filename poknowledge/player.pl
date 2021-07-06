sub EVENT_CLICKDOOR {
  if ($doorid == 19) {
    quest::movepc(46, -34, -721, -27, 221.21); # Zone: innothule
  }
  if ($doorid == 22){
    # Erudin
    quest::movepc(38, 296, -2330, -45.4, 127); # Zone: tox
  }
  if ($doorid == 32){
    # Paineel
    quest::movepc(38, -569, 2325, -43.4, 39); # Zone: tox
  }
  if ($doorid == 24) {
    # Steamfont
    quest::movepc(56, 933.79, -1358, -109); # Zone: steamfont
  }
  if ($doorid == 25) {
    # West Freeport
    quest::movepc(9, 77.31, -660.57, -30.24); # Zone: freportw
  }
}


sub set_current_position() {
	$client->SetEntityVariable("last_x", $client->GetX());
	$client->SetEntityVariable("last_y", $client->GetY());
}
