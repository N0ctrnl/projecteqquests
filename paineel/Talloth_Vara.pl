sub EVENT_SAY { 
  if($text=~/Hail/i){
    quest::say("Greetings. $name.  You have come to the Anthenaeum Necromanita.  This place serves as the stores of knowledge for the Seekers of the [" . quest::saylink("What dark truth?",0,"Dark Truth") . "].");
  }
  if($text=~/what dark truth/i){
    quest::say("The Dark Truth is what all the [" . quest::saylink("What necromancers?",0,"necromancers") . "] in Paineel seek to learn.  The [" . quest::saylink("What real truth?",0,"real truth") . "] is far more interesting.");
  }
  if($text=~/what necromancers/i){
    quest::say("The necromancers here are called the Seekers of the Dark Truth.  The leader of the Seekers is known as the Speaker of the Dark Truth.  The current Speaker is Coriante Verisue.  She does, however, have many [" . quest::saylink("What rivals?",0,"many rivals") . "].");
  }
  if($text=~/what rivals/i){
    quest::say("I support Coriante due to my respect for her.  Many have no such respect and covet her power and position.  One such individual is Darton. the Seeker's Chief Researcher.  He is a direct descendant of [" . quest::saylink("Who was Dartain?",0,"Dartain") . "]. a hero to our people.");
  }
  if($text=~/who is dartain/i){
    quest::say("That is a long story indeed. $name.  Many years ago. the heretics and the people of Erudin had a grand battle.  During the conflicts. great magics were performed and many catastrophic effects plagued these lands. a good example of which would be the Hole.");
  }
  if($text=~/what real truth/i){
    quest::say("The real truth is actually a theory of mine which I believe to be true.  You see. the Seekers believe that necromancy is all that can be gained from the Dark Truth. whereas I believe it is merely a by-product."); 
  }
}
#END of FILE Zone:paineel  ID:75077 -- Talloth_Vara 
