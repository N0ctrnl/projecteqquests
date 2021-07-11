# items: 67704
sub EVENT_ENTERZONE { #message only appears in Cities / Pok and wherever the Wayfarer Camps (LDON) is in.  This message won't appear in the player's home city.
  my @start_zones = (1,2,3,8,9,10,19,22,23,24,29,30,34,35,40,41,42,45,49,52,54,55,60,61,62,67,68,75,82,106,155,202,382,383,392,393,408);
  my @indoor_zones = (18,31,32,36,39,40,41,42,44,64,65,66,73,80,81,88,89,97,101,103,104,105,107,108,109,111,112,113,121,123,124,125,128,150,151,153,154,156,157,158,161,162,164,179,200,212,214,216,226,227,228,229,230,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278);
  my @no_levitate_zones = (39,71,109,112,124,125,158,159,160,163,164,179,223,227,231,239,242,251,273);

  if($ulevel >= 15 && !defined($qglobals{Wayfarer})) {
	  #    if($client->GetStartZone()!=$zoneid && ($zoneid ~~ ['1','2','3','8','9','10','19','22','23','24','29','30','34','35','40','41','42','45','49','52','54','55','60','61','62','67','68','75','82','106','155','202','382','383','392','393','408'])){

	  #    if($client->GetStartZone()!=$zoneid && ($zoneid == 1 || $zoneid == 2 || $zoneid == 3 || $zoneid == 8 || $zoneid == 9 || $zoneid == 10 || $zoneid == 19 || $zoneid == 22 || $zoneid == 23 || $zoneid == 24 || $zoneid == 29 || $zoneid == 30 || $zoneid == 34 || $zoneid == 35 || $zoneid == 40 || $zoneid == 41 || $zoneid == 42 || $zoneid == 45 || $zoneid == 49 || $zoneid == 52 || $zoneid == 54 || $zoneid == 55 || $zoneid == 60 || $zoneid == 61 || $zoneid == 62 || $zoneid == 67 || $zoneid == 68 || $zoneid == 75 || $zoneid == 82 || $zoneid == 106 || $zoneid == 155 || $zoneid == 202 || $zoneid == 382 || $zoneid == 383 || $zoneid == 392 || $zoneid == 393 || $zoneid == 408)) {
    if($client->GetStartZone()!=$zoneid && ($zoneid ~~ @start_zones)){
	    #	    == 1 || $zoneid == 2 || $zoneid == 3 || $zoneid == 8 || $zoneid == 9 || $zoneid == 10 || $zoneid == 19 || $zoneid == 22 || $zoneid == 23 || $zoneid == 24 || $zoneid == 29 || $zoneid == 30 || $zoneid == 34 || $zoneid == 35 || $zoneid == 40 || $zoneid == 41 || $zoneid == 42 || $zoneid == 45 || $zoneid == 49 || $zoneid == 52 || $zoneid == 54 || $zoneid == 55 || $zoneid == 60 || $zoneid == 61 || $zoneid == 62 || $zoneid == 67 || $zoneid == 68 || $zoneid == 75 || $zoneid == 82 || $zoneid == 106 || $zoneid == 155 || $zoneid == 202 || $zoneid == 382 || $zoneid == 383 || $zoneid == 392 || $zoneid == 393 || $zoneid == 408)) {
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
  # the main key is the ID of the AA
  # the first set is the age required in seconds
  # the second is if to ignore the age and grant anyways live test server style
  # the third is enabled
  #  my %vet_aa = (
  #    481 => [31536000, 1, 1], ## Lesson of the Devote 1 yr
    #482 => [63072000, 1, 1], ## Infusion of the Faithful 2 yr
    #483 => [94608000, 1, 1], ## Chaotic Jester 3 yr
    #    484 => [126144000, 1, 1], ## Expedient Recovery 4 yr
    #485 => [157680000, 1, 1], ## Steadfast Servant 5 yr
    #486 => [189216000, 1, 1], ## Staunch Recovery 6 yr
    #487 => [220752000, 1, 1], ## Intensity of the Resolute 7 yr
    #511 => [252288000, 1, 1], ## Throne of Heroes 8 yr
    #2000 => [283824000, 1, 1], ## Armor of Experience 9 yr
    #    8081 => [315360000, 1, 1], ## Summon Resupply Agent 10 yr
    #    8130 => [346896000, 1, 1], ## Summon Clockwork Banker 11 yr
    #    453 => [378432000, 1, 1] ## Summon Permutation Peddler 12 yr
    #182 => [409968000, 1, 1], ## Summon Personal Tribute Master 13 yr
    #600 => [441504000, 1, 1] ## Blessing of the Devoted 14 yr
    #  );
    #  my $age = $client->GetAccountAge();
    #  for (my ($aa, $v) = each %vet_aa) {
    #    if ($v[2] && ($v[1] || $age >= $v[0])) {
    #      $client->GrantAlternateAdvancementAbility($aa, 1);
    #    }
    #  }
  $client->GrantAlternateAdvancementAbility(481, 1, 1);
  $client->GrantAlternateAdvancementAbility(484, 1, 1);
  $client->GrantAlternateAdvancementAbility(8081, 1, 1);
  $client->GrantAlternateAdvancementAbility(8130, 1, 1);
  $client->GrantAlternateAdvancementAbility(453, 1, 1);
  $client->GrantAlternateAdvancementAbility(334, 5, 1);
  $client->GrantAlternateAdvancementAbility(347, 1, 1);
}


sub EVENT_LOOT {
  if($looted_id == 150005) {
    $client->Message(15, "There's a collector in The Bazaar that would be very interested in this token...");
  }
}
