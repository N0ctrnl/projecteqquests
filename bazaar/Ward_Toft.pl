sub EVENT_SAY {
  if($text=~/Hail/i) {
    quest::say("Hey");
    $client->GrantAlternateAdvancementAbility(334, 5, 1);
  }
}

