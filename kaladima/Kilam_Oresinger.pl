#############
#Quest Name: Bard Mail Quest
#Author: RealityIncarnate
#NPCs Involved: Tralyn Marsinger, Eve Marsinger, Lislia Goldtune, Felisity Starbright, Jakum Webdancer, Ton Twostring, Idia, Sivina Lutewhisper, Ticar Lorestring, Marton Stringsinger, Drizda Tunesinger, Travis Two Tone, Silna Songsmith, Siltria Marwind, Tacar Tissleplay, Kilam Oresinger, Lyra Lyrestringer 
#Items Involved: Bardic letters: 18150-18167
#################
# items: 18162

sub EVENT_SAY { 
  if($text=~/Hail/i){
    quest::say("Hail. $name - Are you [" . quest::saylink("I am interested",0,"interested") . "] in helping the League of Antonican Bards by delivering some [" . quest::saylink("What mail?",0,"mail") . "]?");
  }
  if($text=~/what mail/i){
    quest::say("The League of Antonican Bards has a courier system made up of travelers and adventurers.  We pay good gold to anyone who will take messages from bards such as myself to one of our more central offices.  Are you [" . quest::saylink("I am interested",0,"interested") . "]?");
  }
  if($text=~/i am interested/i){
    quest::say("I have messages that need to go to - well. right now I have one that needs to go to Kelethin.  Will you [" . quest::saylink("I will deliver to Kelethin",0,"deliver mail to Kelethin") . "] for me?");
  }
  if($text=~/deliver to Kelethin/i){
    quest::say("Take this letter to Jakum Webdancer in Kelethin.  You can find him at the bard guild hall.  I am sure he will compensate you for your troubles.");
    quest::summonitem(18162);
  }
}
#END of FILE Zone:kaladima
