sub EVENT_SPAWN {
  $roll = int(rand(1000)) + 1;

  if($roll >= 995 && $mlevel >= 46) {
    # Was VA 1-year token
    # Now VA re-launch token
    my $itemid=(150005);
    $npc->AddItem($itemid);
  }

  if($roll >= 989 && $roll <= 994 && $mlevel >= 46) {
    # Was VA 2-year token
    # Now just re-launch token same as above
    my $itemid=(150005);
    $npc->AddItem($itemid);
  }

  if($roll >= 910 && $roll <= 920) {
    # Potion of Adventure
    my $itemid=(40605);
    $npc->AddItem($itemid);
  }
}

sub EVENT_HATE_LIST {
  if ($hate_state == 1 && $client && $client->GetLevel() > ($mlevel + 10) && $npc->GetEntityVariable("removed") != 1) {
    $npc->RemoveItem(132522);
    $npc->RemoveItem(40605);
    $npc->SetEntityVariable("removed", 1); #so it stops trying to remove the item when more people aggro it
  }
}

#sub EVENT_DEATH_COMPLETE {
#  if ($ulevel > ($mlevel + 15)) {
#    $npc->RemoveItem(40605);
#  }
#}
