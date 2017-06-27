## May/may Not need to add aggro event

sub EVENT_SPAWN {

  quest::setnexthpevent(76);
  quest::depop (870064);
  quest::emote ("rises from the lava to protect Tirranun");

}

sub EVENT_HP {  
     
    if($hpevent == 76) {
        quest::npctexture(4);
        quest::setnexthpevent(51); }

    if($hpevent == 51) {
        quest::npctexture(1);
        quest::setnexthpevent(26); }

    if($hpevent == 26) {
        quest::npctexture(2); }

}
