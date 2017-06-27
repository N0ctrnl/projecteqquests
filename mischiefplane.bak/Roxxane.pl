sub EVENT_SAY {
    if ($text=~/hail/i) {
        quest::say("Well hello! We are great dancers. Would you like to see us dance? Or maybe you would like us to teach you to dance?");
    } 
	
	elsif($text=~/see you dance/i) {
        quest::settimer("do_the_marinara", 1);     
    } 
	
	elsif($text=~/teach me dance/i) {
        quest::say("Look at you! You can dance! Go, go, go! That's the spirit, you got it! Keep up the good work! Don't get too tired now, you are looking a little pale!");
        quest::selfcast(1246);
    }    
}

sub EVENT_TIMER{
    if($timer eq "do_the_marinara"){
        my @nlist = $entity_list->GetNPCList();
        foreach my $n (@nlist){
            if($n->GetCleanName()=~/Roxxanne/i){
                $n->DoAnim(33);
            }
			
			if($n->GetCleanName()=~/Ashley/i){
                $n->Say("Hey! Yeah! Do the Marinara!");
                $n->DoAnim(33);
            }
            
            if($n->GetCleanName()=~/Brittina/i){
                $n->Say("Hey! Yeah! Do the Marinara!");
                $n->DoAnim(33);
            }
            
            if($n->GetCleanName()=~/Diana/i){
                $n->Say("Hey! Yeah! Do the Marinara!");
                $n->DoAnim(33);
            }
        }
        quest::stoptimer("do_the_marinara");
    }
}
