sub EVENT_DEATH_COMPLETE {
 if ($client->GetRaid()) {
   for ($i = 0; $i < 72; $i++) {
   if ($raid->GetRaid()->GetMember($i)) {
     $raid->GetRaid()->GetMember($i)->SetGlobal("MoTG", 1, 5, "F");
   }
 }
  }
}
