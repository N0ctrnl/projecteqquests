sub EVENT_SAY {
  if ($text=~/Hail/i){
    quest::emote("looks around curiously. 'Well, well, well. Look what the wyvern dragged in. I dun get visitors all that often, but usually when I do, it's a bad omen. Ye know, ye look a lot like some of the buggers that came 'round here not too long ago. Well, heh, not long ago for me could have been years and years ago. But, by the looks of ye, ye wouldn't know [" . quest::saylink("Tell me why that is",0,"why that is") . "].");
  }
  if ($text=~/why that is/i){
    quest::say("'If'n ye looked around ye at all, ye'd see that there was a bunch of wyverns 'round here. Now how is it that a little gnome like meself could survive in this place with all them runnin' 'round? Exactly, I couldn't, and I didn't. I came here a long time go, searchin' for treasures and [" . quest::saylink("What information?",0,"information") . "] the likes of which I never thought possible. I tried to get a couple of my [" . quest::saylink("What old friends?",0,"old friends") . "] along too, but they thought it was goin' to be too dangerous. I guess they were right, and I shouldn't have ever come here, but I did.'");
  }
  if ($text=~/information/i){
    quest::say("'Well, long time ago there was this story 'bout a [" . quest::saylink("What sleeping critter?",0,"sleeping critter") . "] who was a mean ol' guy that no one really liked all that much. Some of his brothers an' sisters decided that they were goin' to put him to bed for being so mean, and so they locked him up deep down inside this tomb. They chose four of the most strongest an' had them keep him under wraps so he wouldn't get loose an' go on a killing spree again. Anyway, I caught wind of this and decided that this was the greatest achievement a gnome like meself could ever make, and I began a [" . quest::saylink("What trek?",0,"trek") . "] for it.'");
  }
  if ($text=~/old friends/i){
    quest::say("'Paldar and Ulessa Bladesoul. A couple of the most enjoyable people I've ever known. They tried to convince me that coming here so long ago was a bad idea, but being the foolish explorer that I was, I made my way here anyway. They tried to tell me that there were bad things brewin' down here, and that any attempt to find or somehow wake that dragon up was a bad idea. It turned out they were right. Not only that, but not too long ago, some more 'daring explorers' came here and woke him up. When they did that, there was a whole lot of [" . quest::saylink("What trouble?",0,"trouble") . "] for everyone.'");
  }
  if ($text=~/sleeping critter/i){
    quest::say("'To this day, I have never seen the thing, but I do know that it was one of the most powerful dragons ever to exist. Not only that, but this thing was huge and was real shiny and see through-like. They called him the prismatic lord, and some called him Kerafyrm, which I think translated into somethin' like Prophetic One, or somethin' like that.'");
  }
  if ($text=~/trouble/i){
    quest::say("'The kind of trouble that happens when someone does somethin' they shouldn't. They woke Kerafyrm up and they paid for it, believe me. This place has changed too, seemingly because there are these new Ancient dragons who control it. They're awaiting the return of Kerafyrm from wherever he is, and they don't want anyone to disturb them. So it comes to bear, are you here to find the ancients?'");
  }
  if ($text=~/trek/i){
    quest::say("'It took me years to find this tomb, searchin' all over Norrath for hints as to where it might be. No one I talked to really had any idea of its whereabouts though. I kept on searchin' though, and then one day I found this shrine sitting out in the middle of the frostbitten ice caps. It looked like a sleepin' dragon, so I figured it had to be related. I walked up to it and looked over it, and what did my eyes spy, but an inscription telling the way to this very tomb! I knew that I would have to keep going, despite my tired legs, my hungry belly, and my aching body. When I finally found the entrance to the tomb, I couldn't believe [" . quest::saylink("What did you see?",0,"what I saw") . "].'");
  }
  if ($text=~/here to find the ancients/i) {quest::say("'It figures you'd be here to go and foul up what doesn't need fouling up! It's reckless adventurers like you that caused the sleeper to be awakened in the first place, and for all I know, it could have been you that caused the death of my friends, Paldar and Ulessa. How careless do you think you can be?! RAWW! I've had enough, and I'll not let you go further and muck anything else up!'");
    quest::depop_withtimer();
    quest::spawn2(128139,0,0,$x,$y,$z,$h); # NPC: Milas_An`Rev
  }
}
