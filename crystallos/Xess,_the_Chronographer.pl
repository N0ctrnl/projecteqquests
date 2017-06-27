sub EVENT_SAY{

 my $Four = quest::saylink("Four",1);
 my $earning = quest::saylink("earning",1);
 my $trustworthy = quest::saylink("trustworthy",1);
 my $proof = quest::saylink("proof",1);
 
if ($text =~/Hail/i){
quest::ze(15, "is this working");
quest::emote("looks up from her work, and nods");
plugin::Whisper ("So, I see you have been charged with the task of [$earning] the trust of the [$Four]. That will be no easy task."); 
}

if ($text =~/Four/i){
plugin::Whisper ("I'll tell you about that when Beau's Lazy ass actually writes it.");
}

if ($text =~/earning/i){
plugin::Whisper ("'If I'm being completely honest, I'm not even sure it can be done. And you should also know, if I am to help you, I want to know that you are [$trustworthy].");
}

if ($text =~/trustworthy/i){
quest::me("In a clearly dissapointed tone, Xess begins to explain.");
plugin::Whisper ("'You see, we used to live peacefully in this realm. So peacefully, in fact, that most of us did not even understand the concept or need for a word such as trustworthy. We paid dearly for our foolishness, however. Before the Faceless occupied our peaceful home, it sent in it's spies to recruit within our walls. We know that two of our younger Wyrmkind, brothers in fact, turned to his cause, for their own selfish petty wants, and opened the gates to Aunopia's ancient lair. Bring me [$proof] of their demise, and I will help you with gaining the trust of the Four. However; I can't guarantee they will be as willing to help you.");
}

if ($text =~/proof/i){
plugin::Whisper ("Maybe we can help each other. I need a few rare relics for some of my own research. Collect them for me and I might just reward you myself. Xy and Yx, the wretched traitors patrol the great hall just ahead. They are no longer worthy to share an audience with the great Opak.  Bring a single scale from each of them, and we can speak further. I will open this door for you, after that you are on your own.");
}

}


