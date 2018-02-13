# Gindan Blademaster
sub EVENT_SPAWN {
  $hp_pct = quest::ChooseRandom(71,51,21);
  quest::setnexthpevent($hp_pct);
}

sub EVENT_AGGRO {
  quest::settimer(1,1);
}

sub EVENT_TIMER {
  my $npchp = int($npc->GetHPRatio());
  if($timer == 1 && $npchp < $hp_pct){
    quest::stoptimer(1);
    quest::depop_withtimer();
    quest::spawn2(214200,0,0,($x + 10),$y,$z,$h);
    quest::spawn2(214201,0,0,($x - 10),$y,$z,$h); #Gindan Blademaster
  } elsif($timer == 1){
    quest::stoptimer(1);
    quest::settimer(1,2)
  }
}

sub EVENT_HP {
  if($hpevent == $hp_pct){
    quest::stoptimer(1);
    quest::depop_withtimer();
    quest::spawn2(214200,0,0,($x + 10),$y,$z,$h);
    quest::spawn2(214201,0,0,($x - 10),$y,$z,$h); #Gindan Blademaster
  }
}
