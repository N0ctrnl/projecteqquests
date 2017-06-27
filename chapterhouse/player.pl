sub EVENT_SAY {
	my $EnterInst = quest::saylink("Enter the Instance", 2);
	my $Destroy = quest::saylink("destroy", 2);
    my $worse = quest::saylink("worse", 2);
	my $evil = quest::saylink("evil", 2);
	my $InstId = quest::GetInstanceID("crushbone", $version);

	if($text=~/hail/i){
	quest::say("Thank Tunare you're here, $name!  Something dreadful is taking place inside Castle Crushbone.  Yes, yes, I realize that the whole place is dreadful to begin with.  But it's much [$worse] now.");
	}
	if($text=~/worse/i){
	quest::say("Some new evil has moved in and set up shop, destroying everything inside.  Where the Crushbone Orcs were destructive and chaotic, this new [$evil] is much more of a threat to all of Tunare's creatures.");
	}
	if($text=~/evil/i){
	quest::say("if you are willing to assist us, I will need to ensure your safe passage.  The new evil inside Crushbone has not yet reached our dimension.  However, he has infilftrated alternate diminsions.  If we can defeat him in these other planes of existence, perhaps we can prevent him from finding our current diminsion.  Just say when you are ready and I can open a portal enabling you to [$EnterInst].  Also, if you are done fighting, or wish to start over, I can [$Destroy] any old instances that may be lingering. ");
	}
	if ($text =~/Enter the Instance/i) {
		my $j;
		for($j=1; $j<=6; $j++) {
			my $version = $j;
			my $InstId = quest::GetInstanceID("crushbone", $version);
		if ($InstId > 0) {
		quest::MovePCInstance(58, $InstId, 166, -586, 3.13);
		}
		elsif ((quest::GetInstanceID("crushbone", $ulevel + 1)) > 0) {
		quest::MovePCInstance(58, quest::GetInstanceID("crushbone", $ulevel + 1), 166, -586, 3.13);
		}
		elsif ((quest::GetInstanceID("crushbone", $ulevel - 1)) > 0) {
		quest::MovePCInstance(58, quest::GetInstanceID("crushbone", $ulevel - 1), 166, -586, 3.13);
		}
		elsif (($ulevel >= (($version * 10) - 9)) && ($ulevel <= ($version * 10))) {
		my $i_id = quest::CreateInstance("crushbone", $version, 21600);
        quest::AssignGroupToInstance($i_id);
		quest::AssignToInstance($i_id);
		quest::MovePCInstance(58, $i_id, 166, -586, 3.13);
		}
		else {
		}
		}
	}
	if($text=~/destroy/i){
		my $i;
		for($i=0; $i<=6; $i++) {
			quest::DestroyInstance(quest::GetInstanceID("crushbone", $i));
		}
	}
}
