my $check;
my $variance = int(rand(600));
my $spawntime = 5760 + $variance;

sub EVENT_SPAWN {
  quest::settimer("cursed",60);
}

sub EVENT_TIMER {
  $check = 0;
  if($timer eq "cursed") {
    quest::stoptimer("cursed");
    $check_boss = $entity_list->GetMobByNpcTypeID(162270);#cursed_one
    if ($check_boss) {
      $check = 1;
    }
    $check_boss = $entity_list->GetMobByNpcTypeID(162271);#cursed_two
    if ($check_boss) {
      $check = 1;
    }
    $check_boss = $entity_list->GetMobByNpcTypeID(162272);#cursed_three
    if ($check_boss) {
      $check = 1;
    }
    $check_boss = $entity_list->GetMobByNpcTypeID(162273);#cursed_four
    if ($check_boss) {
      $check = 1;
    }
    $check_boss = $entity_list->GetMobByNpcTypeID(162274);#cursed_five
    if ($check_boss) {
      $check = 1;
    }
    $check_boss = $entity_list->GetMobByNpcTypeID(162275);#cursed_six
    if ($check_boss) {
      $check = 1;
    }
    $check_boss = $entity_list->GetMobByNpcTypeID(162276);#cursed_seven
    if ($check_boss) {
      $check = 1;
    }
    $check_boss = $entity_list->GetMobByNpcTypeID(162277);#cursed_eight
    if ($check_boss) {
      $check = 1;
    }
    $check_boss = $entity_list->GetMobByNpcTypeID(162278);#cursed_nine
    if ($check_boss) {
      $check = 1;
    }
    $check_boss = $entity_list->GetMobByNpcTypeID(162279);#cursed_ten
    if ($check_boss) {
      $check = 1;
    }
    if ($check == 1) {
      quest::settimer("cursed",60);
    }

    if ($check == 0) {
      if (!defined $qglobals{glyphed_dead} && !defined $qglobals{cursed_dead} && !defined $qglobals{exiled_dead}) {
        quest::spawn2(162261,0,0,-51,-9,-218.1,63);# Glyphed
      }
#      elsif (defined $qglobals{glyphed_dead} && !defined $qglobals{cursed_dead} && !defined $qglobals{exiled_dead}) {
#        quest::spawn2(162253,0,0,-51,-9,-218.1,63); # Runed
#      }
#      elsif (defined $qglobals{glyphed_dead} && !defined $qglobals{exiled_dead}) {
#        quest::spawn2(162261,0,0,-51,-9,-218.1,63);#glyphed
#      }
    }
  }
}

sub EVENT_SIGNAL {
  if ($signal == 0) {
    quest::settimer("cursed",5);
  }
  if ($signal == 1) {
    if(!defined $qglobals{exiled_dead}) {
      quest::spawn2(162232,0,0,-51,-9,-218.1,63);#Exiled
    } elsif (defined $qglobals{exiled_dead}) {
      quest::spawn2(162214,0,0,-51,-9,-218.1,63);#Banished
    }
  }
  if ($signal == 2) {
    if(!defined $qglobals{cursed_dead}) {
      quest::spawn2(162206,0,0,-51,-9,-218.1,63);#Cursed
    }
  }
  if ($signal == 3) {
    # Cursed is dead. Set the global.
    quest::setglobal("cursed_dead",1,3,"D4");
    quest::stoptimer("cursed");
  }
  if ($signal == 4) {
    # Rhag1 is dead - Enable Rhag2 spawn
    if (!defined $qglobals{rhag2_dead}) {
      quest::enable_spawn2(382989); # Enable Rhag2
    }
  }
  # Rhag2 dead
  if ($signal == 5) {
    if (!defined $qglobals{al_dead}) {
      # Arch Lich global is clear - Enable Arch Lich spawn
      quest::disable_spawn2(382989); # Disable Rhag2
      quest::enable_spawn2(382990); # Enable Arch Lich
    }
  }
  if ($signal == 6) {
    # Arch Lich is dead - Disable his spawn
    quest::setglobal("al_dead",1,3,"S259200");
    quest::disable_spawn2(382990); # Disable Arch Lich
  }
}
