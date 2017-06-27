# HP
sub EVENT_TIMER {
  if ($timer eq "CheckNAdd") {
    quest::stoptimer("CheckNAdd");
    my $guard1 = $entity_list->GetNPCByNPCTypeID(162116); #Heriz
    my $guard2 = $entity_list->GetNPCByNPCTypeID(162111); #Yasiz
    my $guard3 = $entity_list->GetNPCByNPCTypeID(162117); #Zlakas
    my $guard4 = $entity_list->GetNPCByNPCTypeID(162118); #Nilasz
    quest::startimer("CheckNAdd",5);
  }
}

sub EVENT_AGGRO {
  quest::startimer("CheckNAdd",1);
}
