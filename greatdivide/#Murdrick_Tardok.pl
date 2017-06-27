sub EVENT_SPAWN {
#  if ($text=~/hail/i) {
  quest::settimer("0",300);
#    $npc->Say("Good day my friends, it is good to see you all are alive and well.");
#    $entity_list->GetNPCByNPCTypeID(118077)->Say("Well, we are alive, but I'd hardly say we're well... We have heard of the death of Rodrick, and the Dain is calling on all citizens of Thurgadin to flush out any opposition to the throne. If we're tied to your dealings with the Kromrif we'll be sent to the bottom of the well for sure.");
#    $npc->Say("The Dain knows nothing, and I have a plan to keep it that way. I have given the matter much thought, and I have gathered you all here to ask for your help.");
#    $entity_list->GetNPCByNPCTypeID(118076)->Say("We all saw what happened when Rodrick agreed to help you. I, for one, am none too eager to take on these new friends of the Dain.");
#    $npc->Say("Rodrick knew what he was getting into, and so did you. It's a bit too late for second thoughts. I don't recall seeing any hesitation when the loot was being passed around.");
#    $entity_list->GetNPCByNPCTypeID(118075)->Say("Go ahead Mudrick, what's this plan of yours?");
#    $npc->Say("As I said I've thought long and hard of our situation and I feel we are indeed in danger. My cousin Berradin is a captain in the Dain's army. I've always been uneasy about him, but now more than ever. He could easily betray many of us and take credit for destroying the rebellion.");
#    $npc->Say("My plan is to poison him and plant a suicide note on the body, a note in which he would take full responsibility for the actions of the rebels. This would both ensure that he could never betray us and would give the Dain closure. We will be free to continue working with our Kromrif friends without fear of discovery.");
#    $entity_list->GetNPCByNPCTypeID(118077)->Say("Sounds good boss, but how do you plan on poisoning him?");
#    $npc->Say("Berradin has a weakness for drink, one drink in particular... Avalanche Ale. I have had the recipe altered slightly to include a deadly poison. I have much to do, I need one of you to brew the drink and bring it to me. I'll handle the rest.");
#    $entity_list->GetNPCByNPCTypeID(118076)->Say("Once again, Murdrick, you've put us at ease in the middle of a treacherous predicament. I will volunteer to brew the drink.");
#    $npc->Say("Very well, take this recipe and follow it exactly. It won't be easy, but you'll be richly rewarded for your efforts I assure you. Send word to meet me back here when you are finished.");
#    $entity_list->GetNPCByNPCTypeID(118076)->Say("Consider it done. Be sure to watch yourself Murd, the Dain's gotta be suspicious of ya, being Rodrick's brother and all. And those outlander friends of his are dangerous, chopped down the Ry`Gorr chief like he was nothin!");
}
 
sub EVENT_TIMER {

 if ($timer eq "0") {
   quest::stoptimer("0");
    $npc->Say("Good day my friends, it is good to see you all are alive and well.");
  quest::settimer("1",10);
}

 if ($timer eq "1") {
   quest::stoptimer("1");
    $entity_list->GetNPCByNPCTypeID(118077)->Say("Well, we are alive, but I'd hardly say we're well... We have heard of the death of Rodrick, and the Dain is calling on all citizens of Thurgadin to flush out any opposition to the throne. If we're tied to your dealings with the Kromrif we'll be sent to the bottom of the well for sure.");
  quest::settimer("2",10);
 }

 if ($timer eq "2") {
   quest::stoptimer("2");
  quest::settimer("3",10);
    $npc->Say("The Dain knows nothing, and I have a plan to keep it that way. I have given the matter much thought, and I have gathered you all here to ask for your help.");
}
 if ($timer eq "3") {
   quest::stoptimer("3");
  quest::settimer("4",10);
    $entity_list->GetNPCByNPCTypeID(118076)->Say("We all saw what happened when Rodrick agreed to help you. I, for one, am none too eager to take on these new friends of the Dain.");
}
 if ($timer eq "4") {
   quest::stoptimer("4");
  quest::settimer("5",10);
    $npc->Say("Rodrick knew what he was getting into, and so did you. It's a bit too late for second thoughts. I don't recall seeing any hesitation when the loot was being passed around.");
}
 if ($timer eq "5") {
   quest::stoptimer("5");
  quest::settimer("6",10);
    $entity_list->GetNPCByNPCTypeID(118075)->Say("Go ahead Mudrick, what's this plan of yours?");
}
 if ($timer eq "6") {
   quest::stoptimer("6");
  quest::settimer("7",10);
    $npc->Say("As I said I've thought long and hard of our situation and I feel we are indeed in danger. My cousin Berradin is a captain in the Dain's army. I've always been uneasy about him, but now more than ever. He could easily betray many of us and take credit for destroying the rebellion.");
}
 if ($timer eq "7") {
   quest::stoptimer("7");
  quest::settimer("8",10);
    $npc->Say("My plan is to poison him and plant a suicide note on the body, a note in which he would take full responsibility for the actions of the rebels. This would both ensure that he could never betray us and would give the Dain closure. We will be free to continue working with our Kromrif friends without fear of discovery.");
}
 if ($timer eq "8") {
   quest::stoptimer("8");
  quest::settimer("9",10);
    $entity_list->GetNPCByNPCTypeID(118077)->Say("Sounds good boss, but how do you plan on poisoning him?");
}
 if ($timer eq "9") {
   quest::stoptimer("9");
  quest::settimer("10",10);
    $npc->Say("Berradin has a weakness for drink, one drink in particular... Avalanche Ale. I have had the recipe altered slightly to include a deadly poison. I have much to do, I need one of you to brew the drink and bring it to me. I'll handle the rest.");
}
 if ($timer eq "10") {
   quest::stoptimer("10");
  quest::settimer("11",10);
    $entity_list->GetNPCByNPCTypeID(118076)->Say("Once again, Murdrick, you've put us at ease in the middle of a treacherous predicament. I will volunteer to brew the drink.");
}
 if ($timer eq "11") {
   quest::stoptimer("11");
  quest::settimer("12",10);
    $npc->Say("Very well, take this recipe and follow it exactly. It won't be easy, but you'll be richly rewarded for your efforts I assure you. Send word to meet me back here when you are finished.");
}
 if ($timer eq "12") {
   quest::stoptimer("12");
  quest::settimer("0",300);
    $entity_list->GetNPCByNPCTypeID(118076)->Say("Consider it done. Be sure to watch yourself Murd, the Dain's gotta be suspicious of ya, being Rodrick's brother and all. And those outlander friends of his are dangerous, chopped down the Ry`Gorr chief like he was nothin!");
}
}
