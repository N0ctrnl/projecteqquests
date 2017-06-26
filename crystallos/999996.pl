sub EVENT_SPAWN {

	my $hatetarget = $entity_list->GetRandomClient($x, $y, $z,30);
	
		if ($hatetarget)
		{
		$npc->AddToHateList($hatetarget,0);
		quest::gmsay("AGGRO SET",13,0);
		}
}

sub EVENT_DEATH {

my $ADD_AMOUNT = int(rand(6)+1); #choose how many adds to spawn
quest::gmsay("add count $ADD_AMOUNT",13,0);
	if ($ADD_AMOUNT == 1){
	quest::spawn2(999993,0,0,$x + 5,$y,$z,$h); #spawn water droplet
	quest::spawn2(999993,0,0,$x - 5,$y,$z,$h);
	}


	if ($ADD_AMOUNT == 2){
	quest::spawn2(999993,0,0,$x + 5,$y,$z,$h);
	quest::spawn2(999993,0,0,$x - 5,$y,$z,$h);
	}

	if ($ADD_AMOUNT == 3){
	quest::spawn2(999993,0,0,$x+5,$y,$z,$h);
	quest::spawn2(999993,0,0,$x-5,$y,$z,$h);
	quest::spawn2(999993,0,0,$x,$y+5,$z,$h);
	}

	if ($ADD_AMOUNT == 4){
	quest::spawn2(999993,0,0,$x+5,$y,$z,$h);
	quest::spawn2(999993,0,0,$x-5,$y,$z,$h);
	quest::spawn2(999993,0,0,$x,$y+5,$z,$h);
	quest::spawn2(999993,0,0,$x,$y-5,$z,$h);
	}

	if ($ADD_AMOUNT == 5){
	quest::spawn2(999993,0,0,$x+5,$y,$z,$h);
	quest::spawn2(999993,0,0,$x-5,$y,$z,$h);
	quest::spawn2(999993,0,0,$x,$y+5,$z,$h);
	quest::spawn2(999993,0,0,$x,$y-5,$z,$h);
	quest::spawn2(999993,0,0,$x+2.5,$y+2.5,$z,$h);
	}

	if ($ADD_AMOUNT == 6){
	quest::spawn2(999993,0,0,$x+5,$y,$z,$h);
	quest::spawn2(999993,0,0,$x-5,$y,$z,$h);
	quest::spawn2(999993,0,0,$x,$y+5,$z,$h);
	quest::spawn2(999993,0,0,$x,$y-5,$z,$h);
	quest::spawn2(999993,0,0,$x+2.5,$y+2.5,$z,$h);
	quest::spawn2(999993,0,0,$x-2.5,$y-2.5,$z,$h);
	}
}





