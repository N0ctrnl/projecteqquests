#Kurt - This seems incomplete
sub EVENT_SAY { 

  if($text=~/i have come to worship/i){
    quest::say("Very well. You worship quietly then. May Brell Serilis bless you.");
  }

  if($text=~/respect/i){
    quest::say("You have. well then! You can pay your respects by bringing me a [" . quest::saylink("What present?",0,"present") . "].");
  } 

  if($text=~/what present/i){
    quest::say("I like necklaces. I wear necklaces made from every kind of beast. The power of the beast is contained within each necklace. The more necklaces I wear. the greater my power! Bring me a Bear Fang Necklace. a Wolf Fang Necklace and a Panther Fang Necklace. This will show your devotion to the temple. Then perhaps I can do you a [" . quest::saylink("What favor?",0,"favor") . "].");
  }
}
#END of FILE Zone:jaggedpine  ID:181124 -- Oracle_Jaarl 

