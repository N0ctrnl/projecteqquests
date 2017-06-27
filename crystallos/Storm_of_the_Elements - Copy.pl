sub EVENT_SAY {

 my $lifeforce = quest::saylink("lifeforce",1);
 my $powers = quest::saylink("powers",1);
 my $Broodmother = quest::saylink("broodmother",1);
 my $risk = quest::saylink("risk",1);
 my $menace = quest::saylink("menace",1);
 my $act = quest::saylink("act",1);
 my $Four = quest::saylink("four",1);
 
if ($text =~/Hail/i){
plugin::Whisper ("'I'm afraid I've no time for pleasantries traveler; you being here is no mistake.  The Keepers of our realm have long been the [$lifeforce] of Norrath. Lately; however, there have been new [$powers] at work.
"); 
}

if ($text =~/lifeforce/i){
plugin::Whisper ("I have no time for that, Speak with Chronographer Xess. She has my permission to enlighten you on our rich history.");
}

if ($text =~/powers/i){
plugin::Whisper ("I'm afraid to say our Ancestors no longer control this realm. You see, for as long as there was life on Norrath, there was Aunopia, the Avatar of Creation. Aunopia is the sole survivor of the legendary first brood; the ancient wyrms that were deposited deep into Norrath's crust by the [$Broodmother] herself.");
}

if ($text =~/broodmother/i){
plugin::Whisper ("Thats right! Our mother, was hatched by Veeshan herself!  And her charge in this realm has been to ensure that life could continue for aeons to come. Everything you see around you, from the fire beetles to the great treants, is attributed to her work on this plane.  But I'm afraid the very plane we speak of is at [$risk] of having all life obliterated.");
}

if ($text =~/risk/i){
quest::me ("All activity in the room you are in comes to a halt, and silence washes over you as Storm of the Elements lowers his voice");
plugin::Whisper ("'Aunopia, the great creator, has been forced into exile by a faceless [$menace].");
}

if ($text =~/menace/i){
quest::me ("Storm of the Elements continues, in a low voice.");
plugin::Whisper ("We don't know much, only that a long battle was endured at the core of our realm. Many lives were lost, in the battle, and a time came where a decision had to be made. Opak, the Ancient; one of our oldest and most powerful wyrms , sacrificed himself in the great hall to contain this evil, giving Aunopia the slightest moment to retreat. She survives in exile, but badly wounded. And the time to [$act] is short.");
}

if ($text =~/act/i){
plugin::Whisper ("in a somber tone, 'As I said before, your arrivial here is no mere coincidence. All that you have endured up until this point have been mere trials to prepare you for the true battle ahead. You must gain the trust of The [$Four] and with their aid, infiltrate and destroy this faceless menace.
");
}

if ($text =~/four/i){
plugin::Whisper ("Very good then, you must hury! Speak with Chronographer Xess, she will give you the details you need from here.");
}

}



