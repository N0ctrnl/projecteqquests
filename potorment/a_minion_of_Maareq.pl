sub EVENT_SPAWN {
  $SpawnX = $x;
  $SpawnY = $y;
  $SpawnZ = $z;
  $SpawnH = $h;
  quest::settimer(2,61);
  quest::settimer(99,1);
}

sub EVENT_TIMER {
  $LeashedID = $entity_list->GetMobByNpcTypeID(207069);
  my $x = $npc->GetX();
  my $y = $npc->GetY();
  my $z = $npc->GetZ();
  {
    quest::stoptimer(99);
    quest::settimer(99,1);
  }
  if($timer == 2) {
    quest::depop();
  }

  if ($timer == 99) {
    if (!$LeashedID || $LeashedID->IsCorpse()) { #if the mob isn't up
      return;
    }

    if ($x > 60 || $x < -90 || $y < -150 || $y > 6 || $z < 450 || $z > 480) {
      $LeashedID->GMMove($SpawnX, $SpawnY, $SpawnZ, $SpawnH);
    }
  }
}


