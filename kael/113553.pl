# NPC for the plate cycle in Kael. The proximity and echo will need to be replaced when NPC listening to commands when not targeted is implemented.
sub EVENT_SPAWN {  
  $x = $npc->GetX();
  $y = $npc->GetY();
  $z = $npc->GetZ();
  quest::set_proximity($x - 30, $x + 30, $y - 30, $y +30);
  quest::enable_proximity_say();
}

sub EVENT_PROXIMITY_SAY {
  $giant1 = $entity_list->IsMobSpawnedByNpcTypeID(113251); #Klaggan Iceshard
  $giant2 = $entity_list->IsMobSpawnedByNpcTypeID(113019); #Klaggan Iceshard
  $giant3 = $entity_list->IsMobSpawnedByNpcTypeID(113283); #Vorken Iceshard
  $giant4 = $entity_list->IsMobSpawnedByNpcTypeID(113018); #A Frost Giant Lord
  $giant5 = $entity_list->IsMobSpawnedByNpcTypeID(113193); #A Frost Giant Lord
  $dwarf1 = $entity_list->IsMobSpawnedByNpcTypeID(113508); #Doldigun Steinwielder
  $dwarf2 = $entity_list->IsMobSpawnedByNpcTypeID(113440); #Doldigun Steinwielder
#  $giant3 = $entity_list->IsMobSpawnedByNpcTypeID(113508);
#  $giant4 = $entity_list->IsMobSpawnedByNpcTypeID(113508);
  if($text=~/dain/i && !$dwarf1 && !$dwarf2 && !$giant1 && !$giant2 && !$giant3 && !$giant4 && !$giant5 && !defined $qglobals{doldigun}) {
    quest::spawn2(113440,0,0,1126.4,-840.6,-118.3,62.6); #Doldigun, non-loot version
    quest::setglobal("doldigun",1,3,"M30");
  }
}

sub EVENT_SIGNAL {
#  if ($dwarf == 1) {
  if ($signal == 1 && !$entity_list->IsMobSpawnedByNpcTypeID(113440) && !$entity_list->IsMobSpawnedByNpcTypeID(113508)) {
    quest::spawn2(113508,29,0,1130.3,-933.2,-125.6,63.4);
  }
}
