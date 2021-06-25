#Belath_the_Trader.pl

sub EVENT_SAY {
  if ($text=~/hail/i && defined($qglobals{tomb_aug}) && !plugin::check_hasitem($client, 150001)) {
    plugin::Whisper("It seems you have lost your augment! Lucky for you I have had very good success of late and happen to be in a generous mood. Please be more careful with this one!");
    quest::summonitem(150001);#Essence of the Tomb
  }
  elsif ($text=~/hail/i && !plugin::check_hasitem($client, 150001)) {
    quest::say("Good day to you, friend! Have you  [" . quest::saylink("I have braved the depths",0,"braved the depths") . "] of the Sleeper's Tomb?");
  }
  if($text=~/braved the depths/i){
    quest::say("Ahh, then we are members of the same brotherhood! I trust you found some [" . quest::saylink("I found some interesting weapons",0,"interesting weapons") . "]?");
  }
  if($text=~/interesting weapons/i){
    quest::emote("nods.");#text made up
    quest::say("Aye. I speak, of course, of the Ancient Primal and Prismatic weapons guarded so fiercely by all within the Tomb. As I am sure you now know, these weapons possess immense power. Using ancient methods, the master smiths of Thurgadin have found a way to harness this power. With their help, I too have learned to distill the pure [" . quest::saylink("What essence?",0,"essence") . "] of these powerful artifacts.");
  }
  if($text=~/essence/i){
    quest::say("Aye! A most beautiful and immensely powerful stone! Though I am still mastering this skill, if you were to provide me with any four of the weapons to practice with, I would almost certainly be able to create one for you. I could use the practice!");
  }
}

sub EVENT_ITEM {
  if ($item1 ~~ [5835, 27320, 27321, 27322, 27323, 27324, 27325, 27326, 27327, 27328, 29440, 29438, 29433, 29437, 29436, 29441, 29434, 29444, 29435, 29442, 29443, 29439] && $item2 ~~ [5835, 27320, 27321, 27322, 27323, 27324, 27325, 27326, 27327, 27328, 29440, 29438, 29433, 29437, 29436, 29441, 29434, 29444, 29435, 29442, 29443, 29439] && $item3 ~~ [5835, 27320, 27321, 27322, 27323, 27324, 27325, 27326, 27327, 27328, 29440, 29438, 29433, 29437, 29436, 29441, 29434, 29444, 29435, 29442, 29443, 29439] && $item4 ~~ [5835, 27320, 27321, 27322, 27323, 27324, 27325, 27326, 27327, 27328, 29440, 29438, 29433, 29437, 29436, 29441, 29434, 29444, 29435, 29442, 29443, 29439]) {
    quest::emote("smiles 'These should improve my skills nicely! Please tell your friends!'");
    quest::summonitem(150001);#Essence of the Tomb
    quest::setglobal("tomb_aug",1,5,"F");
  }
}#END of FILE Zone:eastwastes  ID:116608 -- Belath_the_Trader 
