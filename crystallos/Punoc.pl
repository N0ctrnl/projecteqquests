sub EVENT_SPAWN {

	quest::settimer("spawn_constants",1);
	plugin::Debug("Spawn $mobid");
}

sub EVENT_SAY {

 my $transcended = quest::saylink("transcended",1);
 my $unnoticed = quest::saylink("unnoticed",1);
 
	if ($text =~/Hail/i){
	quest::say ("Just ahead lies the Ancient titans of something all earthy and muddy in nature for lore purposes. They were once the pets of a great elementalist, Ponz Tredare, who long ago [$transcended] the mortal planes leaving behind only his legendary shovel.
	");
	}

	if ($text =~/transcended/i){

	quest::say ("Centuries ago, Ponz was Chief Elementalist at the Academy of Arcane Sciences in West Freeport.  Ponz was responsible for unlocking many of the early secrets of the Earth. He took these secrets and imbedded them in enchanted runes and scrolls to be passed down to later generations. As decades passed, he became more and more familiar with he mortal plane, and he developed the ability to move and shake the very earth itself. Magic of this magnitude rarely goes [$unnoticed].");
	}

	if ($text =~/unnoticed/i){
	
	quest::say("Foolish mortal! You've come this far and you don't realize greater powers are at work! The realm of Norrath owes an unpayable debt to the great Terralox, and sadly, his identity remains a mystery to those outside of the realm of Crystallos. Terralox is the creation lord of the earth, and reports directly to Aunopia. He noticed early on, the abilities of this great magician. With knowledge passed down to Ponz From the might Terralox himself, the great magician now has the ability to command several pets at once to gaurd the realm beyond.");
	quest::settimer("Start",5);
	}
	
}

sub EVENT_TIMER {

	if ($timer eq "spawn_constants")
	{
	quest::spawn2(1000006,0,0,60.6,2790.7,-526.3,190.1);
	quest::spawn2(1000005,0,0,-3.7,2784.2,-527,60);
	quest::stoptimer("spawn_constants");
	}
	
	if ($timer eq "Start")
	{
	quest::stoptimer("Start");
	quest::shout("'Quickly $name , there isn't much time. The ancient titans  battle each other to keep their powers strong in this isolated realm, and have weakened themselves in a recent quarrel. Now is your only chance to defeat them!");
	quest::settimer("elementals",5);
	}

	if ($timer eq "elementals")
	{
	quest::stoptimer("elementals");
	quest::signalwith(1000005,1,1);
	quest::signalwith(1000006,1,1);
	quest::settimer("attack",6);
	}
	
	if ($timer eq "attack")
	{
	quest::stopalltimers();
	quest::emote("vanishes");
	quest::shout("GO NOW!");
	quest::depop();
	}
}