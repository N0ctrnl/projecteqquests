
sub EVENT_SPAWN {
	quest::settimer("Shout",600);
	$CazicTouchTimer = 0;
	my $LuckyGuy;
}

sub EVENT_AGGRO {
	if ($CazicTouchTimer eq 0) {
		$CazicTouchTimer = 1;
		quest::settimer("1",60);
		quest::settimer("2",900);
		$LuckyGuy = ($npc->GetHateTop());
		$LuckyGuy = $LuckyGuy->GetID();
		quest::castspell(982,$LuckyGuy );
	}
}

sub EVENT_TIMER {
	if ($timer eq "1") {
		if ($CazicTouchTimer eq 1) {
			$LuckyGuy = ($npc->GetHateTop());
			$LuckyGuy = $LuckyGuy->GetID();
			quest::castspell(982,$LuckyGuy );
			quest::settimer("1",45);
		}
	}
	if ($timer eq "2") {
		quest::stoptimer("1");
		quest::stoptimer("2");
		$CazicTouchTimer = 0;
	}
}
        
sub EVENT_DEATH {
	quest::stoptimer("1");
}

# EOF zone: fearplane ID: 72003 NPC: Cazic_Thule