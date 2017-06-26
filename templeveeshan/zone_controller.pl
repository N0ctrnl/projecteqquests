#Spawns Vulak if no boss mobs are up. 
my $check = 0;

sub EVENT_SPAWN {  
  $check = 0;
  quest::settimer("vulak",60);
  quest::disable_spawn2(382992);
}

sub EVENT_TIMER {
$check = 0;
  if($timer eq "vulak") {
    quest::stoptimer("vulak");
    $check_boss = $entity_list->GetMobByNpcTypeID(124077);
    if ($check_boss) {
      $check = 1
    }
    $check_boss = $entity_list->GetMobByNpcTypeID(124076);
    if ($check_boss) {
      $check = 1
    }
    $check_boss = $entity_list->GetMobByNpcTypeID(124008);
    if ($check_boss) {
      $check = 1
    }
    $check_boss = $entity_list->GetMobByNpcTypeID(124103);
    if ($check_boss) {
      $check = 1
    }
    $check_boss = $entity_list->GetMobByNpcTypeID(124074);
    if ($check_boss) {
      $check = 1
    }
    $check_boss = $entity_list->GetMobByNpcTypeID(124017);
    if ($check_boss) {
      $check = 1
    }
    if ($check == 1) {
      quest::settimer("vulak",60);
    } 
    if ($check == 0 && !defined $qglobals{vulak} && !$entity_list->IsMobSpawnedByNpcTypeID(124155)) {
#      quest::spawn2(124155,0,0,-739.4,517.2,121,255);
      quest::enable_spawn2(382992);
      quest::settimer("vulak",60);
    }
    elsif ($check == 0) {
      quest::settimer("vulak",3600);
    }
  }
}      

sub EVENT_SIGNAL {
  if ($signal == 1) {
    my $variance = int(rand(720));
    my $spawntime = 4320 + $variance;
    # Vulak dead. Kill the timer.
    quest::stoptimer("vulak");
    quest::disable_spawn2(382992);
    quest::setglobal("vulak",1,3,"M$spawntime");
    quest::settimer("vulak",60);
  }
  if ($signal == 2) {
    # Vulak's dead. Set the lockout and start the timer.
    quest::setglobal("vulak",1,3,"M$spawntime");
    quest::settimer("vulak",300);
  }
}
