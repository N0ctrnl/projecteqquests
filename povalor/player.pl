$level_for_tier_three = 62;

sub EVENT_CLICKDOOR {
  #hohonora from behind AD
  if($doorid == 3) {
    if($client->GetLevel() >= $level_for_tier_three || (defined $qglobals{pop_poj_mavuin} && defined $qglobals{pop_poj_tribunal} && defined $qglobals{pop_poj_valor_storms} && defined $qglobals{pop_pov_aerin_dar}) || (defined $qglobals{pop_alt_access_hohonora})) {
      if(quest::has_zone_flag(211) != 1) {
        quest::set_zone_flag(211);
      }
    }
  }
  #door under AD
  #Keep this locked while AD is alive to avoid him falling through - which will probably happen anyway
  if($doorid == 11) {
    if($entity_list->GetNPCByNPCTypeID(208074)) {
        $entity_list->FindDoor(11)->SetLockPick(1);
    } 
    if(!$entity_list->GetNPCByNPCTypeID(208074)) {
      $entity_list->FindDoor(11)->SetLockPick(0);
    }
  }
}
