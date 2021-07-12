sub EVENT_ENTERZONE {
  # Define ZoneID arrays that we'll compare against
  my @start_zones = (1,2,3,8,9,10,19,22,23,24,29,30,34,35,40,41,42,45,49,52,54,55,60,61,62,67,68,75,82,106,155,202,382,383,392,393,408);
  my @indoor_zones = (18,31,32,36,39,40,41,42,44,64,65,66,73,80,81,88,89,97,101,103,104,105,107,108,109,111,112,113,121,123,124,125,128,150,151,153,154,156,157,158,161,162,164,179,200,212,214,216,226,227,228,229,230,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278);
  my @no_levitate_zones = (39,71,109,112,124,125,158,159,160,163,164,179,223,227,231,239,242,251,273);

  #message only appears in Cities / Pok and wherever the Wayfarer Camps (LDON) is in.  This message won't appear in the player's home city.
  if($ulevel >= 15 && !defined($qglobals{Wayfarer})) {
    if($client->GetStartZone()!=$zoneid && ($zoneid ~~ @start_zones)){
      $client->Message(15,"A mysterious voice whispers to you, 'If you can feel me in your thoughts, know this -- something is changing in the world and I reckon you should be a part of it. I do not know much, but I do know that in every home city and the wilds there are agents of an organization called the Wayfarers Brotherhood. They are looking for recruits . . . If you can hear this message, you are one of the chosen. Rush to your home city, or search the West Karanas and Rathe Mountains for a contact if you have been exiled from your home for your deeds, and find out more. Adventure awaits you, my friend.'");
    }
  }

  # Remove mount if zone is indoor
  if($zoneid ~~ @indoor_zones){
    $client->BuffFadeByEffect(113); 
  } 

  # Remove any levitate buffs if the zone does not allow them
  if($zoneid ~~ @no_levitate_zones){
    $client->BuffFadeByEffect(57);
  }

  if ($status < 200) {
    plugin::LeaderBoardsUpdate();
  }
}

sub EVENT_CONNECT {
  # Grant Veteral AAs, 9th spell gem and 5 additional buffs
  $client->GrantAlternateAdvancementAbility(481, 1, 1);
  $client->GrantAlternateAdvancementAbility(484, 1, 1);
  $client->GrantAlternateAdvancementAbility(8081, 1, 1);
  $client->GrantAlternateAdvancementAbility(8130, 1, 1);
  $client->GrantAlternateAdvancementAbility(453, 1, 1);
  $client->GrantAlternateAdvancementAbility(334, 5, 1);
  $client->GrantAlternateAdvancementAbility(347, 1, 1);

  if($client->GetStartZone() == 9 || $client->GetStartZone() == 10){
    # of Freeport
    quest::enabletitle(388);
  } 
  if ($client->GetStartZone() == 45 || $client->GetStartZone() == 1 || $client->GetStartZone() == 2){
    # of Qeynos
    quest::enabletitle(387);
  } 
  if ($client->GetStartZone() == 29){
    # of Halas
    quest::enabletitle(398);
  } 
  if ($client->GetStartZone() == 23 || $client->GetStartZone() == 24){
    # of Erudin
    quest::enabletitle(399);
  } 
  if ($client->GetStartZone() == 54){
    # of Kelethin
    quest::enabletitle(396);
  } 
  if ($client->GetStartZone() == 75){
    # of Paineel
    quest::enabletitle(400);
  } 
  if ($client->GetStartZone() == 61 || $client->GetStartZone() == 62){
    # of Felwithe
    quest::enabletitle(395);
  } 
  if ($client->GetStartZone() == 41 || $client->GetStartZone() == 42){
    # of Neriak
    quest::enabletitle(98);
  } 
  if ($client->GetStartZone() == 3){
    # of Surefall Glade
    quest::enabletitle(397);
  } 
  if ($client->GetStartZone() == 60 || $client->GetStartZone() == 67){
    # of Kaladim
    quest::enabletitle(393);
  } 
  if ($client->GetStartZone() == 52){
    # of Grobb
    quest::enabletitle(390);
  } 
  if ($client->GetStartZone() == 49){
    # of Oggok
    quest::enabletitle(389);
  } 
  if ($client->GetStartZone() == 19){
    # of Rivervale
    quest::enabletitle(401);
  } 
  if ($client->GetStartZone() == 55){
    # of Ak`Anon
    quest::enabletitle(103);
  } 
  if ($client->GetStartZone() == 82 || $client->GetStartZone() == 106){
    # of Cabilis
    quest::enabletitle(394);
  } 
  if ($client->GetStartZone() == 155){
    # of Shar Vahl
    quest::enabletitle(402);
  } 
  if ($client->GetStartZone() == 50){
    # of Gukta
    quest::enabletitle(391);
  }
}


sub EVENT_LOOT {
  # When looting VA Re-Launch Token, give the client a message with a hint as to where it goes
  if($looted_id == 150005) {
    $client->Message(15, "There's a collector in The Bazaar that would be very interested in this token...");
  }
}
