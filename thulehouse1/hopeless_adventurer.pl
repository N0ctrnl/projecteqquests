sub EVENT_SAY{

 my $late = quest::saylink("late",1);
 my $bag = quest::saylink("bag",1);
 my $legendary = quest::saylink("legendary",1);
 my $spools = quest::saylink("spools",1);
 

	if ($text =~/Hail/i)
	{
	quest::say ("If you are here to rescue me, its too [late].");
	}

	if ($text =~/late/i)
	{	
	quest::say ("After being down here so long, I lack both the strength and will to try and leave this place. I dare not think what it would be like to try to acclimate myself back into a regular life, following the horrors i have seen here. And all for a silly [bag]!");
	}

	if ($text =~/bag/i)
	{
	quest::say ("A group of us set out a while back in search of great treasure. My eye was set on a mystical pouch, the contents of which could be used by an experienced tailor to craft a [legendary] item.");
	}
	
	if ($text =~/legendary/i)
	{
	quest::say ("After being down here so long I'm afraid that it was all just rumour based on lies and legends. If such an item did exist though, legend has it, two [spools] of amaranthine silk, combined with three hides from these nightmarish beasts and reinforced by 5 precisely measured piles of finely ground living statue could yield something wondrous. I would advise ignoring such rumours and trying to find the exit, while your party is still in tact.")
	}
	
	if ($text =~/spools/i)
	{
	quest::say ("If such a spool is to be made you would have to find something made of sturdy wood to wrap in tact silk from the amaranthine spiders. As much silk as you can get around your makeshift wooden spool would be advisable, in order to ensure a full spool.")
	}
}
	