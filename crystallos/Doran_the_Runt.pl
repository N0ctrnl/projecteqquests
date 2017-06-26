sub EVENT_SAY {

 my $place = quest::saylink("place",1);
 my $go = quest::saylink("go",1);
 my $group = quest::saylink("group",1); 
 
if ($text =~/Hail/i){
plugin::Whisper ("I hear tell of a [$place] from ancient times, where one can find gems of incredible power."); 
}

if ($text =~/place/i){
plugin::Whisper ("Hidden in this ancient place are components that when combined create augments of incredible power. Would you like to [$go] there? I can also send your [$group] if you wish.");
}

if ($text =~/go/i){
quest::movepc(123,2073,-118,2,199.9)
}

if ($text =~/group/i){
quest::movegrp(123,2073,-118,2)
}

}