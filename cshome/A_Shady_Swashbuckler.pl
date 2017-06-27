sub EVENT_SAY {
  if ($text=~/test/i) {
    if($client->FindBuff(4520)) {
      quest::gmsay("Success!", 13, 0, 0, 0);
    } 
    if (!$client->FindBuff(4520)) {
      quest::gmsay("Fail!");
    }
  }
}
