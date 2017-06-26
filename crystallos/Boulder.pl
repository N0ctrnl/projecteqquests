##Boulder spawns and chooses a random target within 200 units.  hurls towards target, does 1 round for 45k 
##after the single 45k hit it kills itself (which gives a visual effect of it shattering
##

sub EVENT_SPAWN {
	$npc->NPCSpecialAttacks(Z,1);
	quest::modifynpcstat(runspeed, 2.0);
	$npc->SendAppearanceEffect(93); 
	$entity_list->MessageClose($npc, 1, 20000, 5, "Terralox digs his claws deep into the earth and hurls a boulder towards his enemies.");
	quest::settimerMS("hurl",1);
	plugin::Debug("$timer Started");
}

sub EVENT_TIMER {

my $Boulder_Target = $entity_list->GetRandomClient($x, $y, $z, 200);
my $HateTargetID = $Boulder_Target->GetID();
my $ClientX = $Boulder_Target->GetX();
my $ClientY = $Boulder_Target->GetY();
my $ClientZ = $Boulder_Target->GetZ();
my $ClientDist = $npc->CalculateDistance($ClientX, $ClientY, $ClientZ);
	
	if ($timer eq "hurl")
	{
	quest::follow($HateTargetID,5);
	quest::stoptimer("hurl");
	plugin::Debug("$timer DONE");
	quest::settimerMS("moveto",1);
	}
	
	if ($timer eq "depop")
	{
	$npc->Damage($npc,1000000, 1, 1, -1, 0);
	quest::stoptimer("depop");
	}
	
	if ($timer eq "moveto")
	{
		if (($ClientDist > 8) && ($Boulder_Target))
		{
		#$Boulder_Target->Damage($npc,45000, 1, 1, -1, 0);
		#quest::stoptimer("moveto");
		#quest::settimer("hurl",1);
		plugin::Debug("TO FAR!");
		}
			elsif (($ClientDist <= 8) && ($Boulder_Target))
		    {
		    quest::stoptimer("moveto");
		    $Boulder_Target->Damage($npc,45000, 1, 0, -1, 0);
		    quest::settimerMS("depop",1);
			plugin::Debug("BOOM!");
		    }
				else 
				{ 
				quest:settimerMS("moveto",1); 
				plugin::Debug("NO TARGET, NOT CLOSE");
				}
	}
}

