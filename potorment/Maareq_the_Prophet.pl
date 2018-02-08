my $spawn1 = undef;

sub EVENT_SPAWN {
  $SpawnX = $x;
  $SpawnY = $y;
  $SpawnZ = $z;
  $SpawnH = $h;
  $LeashedID = $entity_list->GetMobByNpcTypeID(207004);
  quest::settimer("CheckLeash", 1);
}


sub EVENT_AGGRO {
  quest::settimer(3,30);
  quest::settimer(4,1800);
  quest::setnexthpevent(15);
  quest::stoptimer("CheckLeash");
  quest::settimer("CheckLeash", 1);
}

sub EVENT_TIMER {
  if($timer eq "3") {
    if($spawn1 <= 5 || $spawn == undef) {
    quest::ChooseRandom((quest::spawn2(207069,0,0,-32,-95,452,68)),(quest::spawn2(207069,0,0,-32,-135,452,0)),(quest::spawn2(207069,0,0,44,-50,452,0)),(quest::spawn2(207069,0,0,0,-52,452,0)),(quest::spawn2(207069,0,0,-25,-116,460,0)));
    $spawn=$spawn+1;
    }
  }
  if($timer eq "4") {
    $spawn1=undef;
    quest::stoptimer(3);
    quest::stoptimer(4);
  }
  if ($timer eq "CheckLeash") {
    quest::stoptimer("CheckLeash");
    if (!$LeashedID || $LeashedID->IsCorpse()) { #if the mob isn't up

      return;
    }

    if ($x > 60 || $x < -90 || $y < -150 || $y > 6 || $z < 450 || $z > 480) {
      $LeashedID->GMMove($SpawnX, $SpawnY, $SpawnZ, $SpawnH);
    }
    quest::settimer("CheckLeash",1);
  }
}

sub EVENT_HP {
	if($hpevent == 15) {
		quest::depop_withtimer();
		#set maareq's respawn, without this line he will repop on zone reset
		#commented this out and put it in death event of the #a_twisted_crawler
		#only to allow a failed raid to redo the event without putting in smarter
		#logic to keep the #a_twisted_crawler up through a zone reset/empty.
		#quest::updatespawntimer(42165,43200000);
		quest::spawn2(207070,0,0,$x,$y,$z,$h);
		quest::stoptimer(3);
		quest::stoptimer(4);
	}
}

sub EVENT_DEATH_COMPLETE {
  quest::stoptimer("CheckLeash");
}
