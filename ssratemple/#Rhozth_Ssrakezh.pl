#my $depop1
sub EVENT_SPAWN {
  #check for our event global and see if we should even be up
#$depop1 = $entity_list->GetMobByNpcTypeID(162258);
  if(defined $qglobals{cursed_dead}) {
    $npc->Depop(7200);
#    quest::depop_withtimer();
  }
}

sub EVENT_DEATH_COMPLETE {
#  quest::signalwith(162279,1,0); #cursed_ten
  quest::depop_withtimer(162279); #cursed_ten
  quest::signalwith(10,0,0);
}
