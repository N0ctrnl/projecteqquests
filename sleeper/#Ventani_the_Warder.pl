$nanzata = $entity_list->GetMobByNpcTypeID(128090);
$tukaarak = $entity_list->GetMobByNpcTypeID(128092);
$hraashna = $entity_list->GetMobByNpcTypeID(128093);
sub EVENT_DEATH_COMPLETE {
  if (!$nanzata && !$tukaarak && !$hraashna) {
    quest::signalwith(128094,66,0);
    quest::shout("Warders, I have fallen. Prepare yourselves, these fools are determined to unleash doom!");
  }
  else {
    quest::shout("Warders, I have fallen. Prepare yourselves, these fools are determined to unleash doom!");
    #quest::setglobal("ventani",1,2,"F");
    if ($client->GetRaid()->GetMember($i)) {
      $client->GetRaid()->GetMember($i)->SetGlobal("Ventani",1,2,"F")
    }
  }
}
