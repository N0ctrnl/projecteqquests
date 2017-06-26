sub EVENT_SPAWN {
  $roll = int(rand(1000)) + 1;
  $roll2 = int(rand(1000)) + 1;

  if($roll >= 995 && $mlevel >= 46) {
    my $itemid=(132522);
    $npc->AddItem($itemid);
  }

  if($roll >= 989 && $roll <= 994 && $mlevel >= 46) {
    my $itemid=(132530);
    $npc->AddItem($itemid);
  }

  if($roll >= 910 && $roll <= 920) {
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
