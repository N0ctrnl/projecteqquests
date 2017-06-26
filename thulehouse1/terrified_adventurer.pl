sub EVENT_SAY{

 my $failure = quest::saylink("failure",1);
 my $greed = quest::saylink("greed",1);
 my $cask = quest::saylink("cask",1);
 my $ale = quest::saylink("ale",1);
 my $yeast = quest::saylink("yeast",1);
 my $malt = quest::saylink("malt",1);
 

	if ($text =~/Hail/i)
	{
	quest::say ("They haunt me! They come to me in my dreams! Feasting on the flesh of my comrades! Why can I not be stronger? Why am I such a miserable [failure]?  ");
	}

	if ($text =~/failure/i)
	{	
	quest::say ("My allies! They are all dead! And it is all my fault! I abandoned them, in my [greed], and left them all for dead! And now they torture me, as my punishment!");
	}

	if ($text =~/greed/i)
	{
	quest::say ("I saw the barrels, and like a fool I went after them thinking they were the mystical [cask] of legend. I was lured down here by my greed, and my brothers are all dead as a result!");
	}
	
	if ($text =~/cask/i)
	{
	quest::say ("An enchanted cask. Capable of making an [ale] so fine, that even a giant with the mightiest fortitude, would slur his speech after a single bottle! And the the finest most masterfully crafted flavour! All of my comrades for a bottle of ale. I deserve this torturous fate!")
	}
	
	if ($text =~/ale/i)
	{
	quest::say ("Have you not listened to a word I have said friend!?! Suit yourself.  Though I know not the exact product of the successful creation, I do know that mixing one full pumpkin, along with two portions of [yeast] and three portions of [malt], two flasks of clean water, and two receptacles for holding it when finished, should yield a legendary brew. That is to say, if you have the skill.")
	}
	
	if ($text =~/yeast/i)
	{
	quest::say ("Not just any yeast, a special yeast found only on the premises here in hotel hell.")
	}
	
	if ($text=~/malt/i)
	{
	quest::say ("Of course you didn't think you could just throw some yeast from the western planes of Karana! Find them here, or the recipe will fail.")
	}
}
	