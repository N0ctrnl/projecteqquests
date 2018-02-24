#my $fly1 = $entity_list->GetNPCByNPCTypeID(209056); #Leistr
#my $fly2 = $entity_list->GetNPCByNPCTypeID(209057); #Iri
#my $fly3 = $entity_list->GetNPCByNPCTypeID(209058); #Hrani

sub EVENT_SPAWN {
  quest::settimer(1,2);
}

sub EVENT_AGGRO {
my $fly1 = $entity_list->GetNPCByNPCTypeID(209061); #Kuanbyr
my $fly2 = $entity_list->GetNPCByNPCTypeID(209057); #Iri
my $fly3 = $entity_list->GetNPCByNPCTypeID(209058); #Hrani

  if ($fly1) {
    $fly1->AddToHateList($client, 1);
  }
  if ($fly2) {
    $fly2->AddToHateList($client, 1);
  }
  if ($fly3) {
    $fly3->AddToHateList($client, 1);
  }
}

sub EVENT_TIMER {
my $fly1 = $entity_list->GetNPCByNPCTypeID(209061); #Kuanbyr
my $fly2 = $entity_list->GetNPCByNPCTypeID(209057); #Iri
my $fly3 = $entity_list->GetNPCByNPCTypeID(209058); #Hrani
  {
    quest::stoptimer(1);
    quest::settimer(1,2);
  }
  if($timer == 1 && $npc->IsEngaged()) {
    if ($fly1) {
      $fly1->AddToHateList($client, 1);
    }
    if ($fly2) {
      $fly2->AddToHateList($client, 1);
    }
    if ($fly3) {
      $fly3->AddToHateList($client, 1);
    }
  }
}

