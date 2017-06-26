#Belath_the_Trader.pl

sub EVENT_SAY {
	if ($text=~/hail/i && defined($qglobals{tomb_aug}) && !plugin::check_hasitem($client, 132524)) {
		plugin::Whisper("It seems you have lost your augment! Lucky for you I have had very good success of late and happen to be in a generous mood. Please be more careful with this one!");
  		quest::summonitem(132524);#Essence of the Tomb
	}
	else {
		quest::say("Good day to you, friend! Have you [braved the depths] of the Sleeper's Tomb?");
	}
	if($text=~/braved the depths/i){
		quest::say("Ahh, then we are members of the same brotherhood! I trust you found some [interesting weapons]?");
	}
	if($text=~/interesting weapons/i){
  		quest::emote("nods.");#text made up
		quest::say("Aye. I speak, of course, of the Primal weapons guarded so fiercely by all within the Tomb. As I am sure you know, these weapons possess immense power. Using ancient methods, the master smiths of Thurgadin have found a way to harness this power. With their help, I too have learned to condense it into a [gem] that can be affixed to any weapon.");
	}
	if($text=~/gem/i){
		quest::say("Aye! A most beautiful and immensely powerful one. Though I am still mastering this skill, if you were to provide me with any four of the weapons to practice with, I would trade you one of these gems.");
	}
}

sub EVENT_ITEM {
#  if ((plugin::check_handin(\%itemcount, 5835 => 1) || plugin::check_handin(\%itemcount, 27320 => 1) || plugin::check_handin(\%itemcount, 27321 => 1) || plugin::check_handin(\%itemcount, 27322 =>1) || plugin::check_handin(\%itemcount, 27323 =>1) || plugin::check_handin(\%itemcount, 27324 =>1) || plugin::check_handin(\%itemcount, 27325 =>1) || plugin::check_handin(\%itemcount, 27326 =>1) || plugin::check_handin(\%itemcount, 27327 =>1) || plugin::check_handin(\%itemcount, 27328 =>1)) && (plugin::check_handin(\%itemcount, 5835 => 1) || plugin::check_handin(\%itemcount, 27320 => 1) || plugin::check_handin(\%itemcount, 27321 => 1) || plugin::check_handin(\%itemcount, 27322 =>1) || plugin::check_handin(\%itemcount, 27323 =>1) || plugin::check_handin(\%itemcount, 27324 =>1) || plugin::check_handin(\%itemcount, 27325 =>1) || plugin::check_handin(\%itemcount, 27326 =>1) || plugin::check_handin(\%itemcount, 27327 =>1) || plugin::check_handin(\%itemcount, 27328 =>1)) && (plugin::check_handin(\%itemcount, 5835 => 1) || plugin::check_handin(\%itemcount, 27320 => 1) || plugin::check_handin(\%itemcount, 27321 => 1) || plugin::check_handin(\%itemcount, 27322 =>1) || plugin::check_handin(\%itemcount, 27323 =>1) || plugin::check_handin(\%itemcount, 27324 =>1) || plugin::check_handin(\%itemcount, 27325 =>1) || plugin::check_handin(\%itemcount, 27326 =>1) || plugin::check_handin(\%itemcount, 27327 =>1) || plugin::check_handin(\%itemcount, 27328 =>1)) && (plugin::check_handin(\%itemcount, 5835 => 1) || plugin::check_handin(\%itemcount, 27320 => 1) || plugin::check_handin(\%itemcount, 27321 => 1) || plugin::check_handin(\%itemcount, 27322 =>1) || plugin::check_handin(\%itemcount, 27323 =>1) || plugin::check_handin(\%itemcount, 27324 =>1) || plugin::check_handin(\%itemcount, 27325 =>1) || plugin::check_handin(\%itemcount, 27326 =>1) || plugin::check_handin(\%itemcount, 27327 =>1) || plugin::check_handin(\%itemcount, 27328 =>1))) {
if ($item1 ~~ [5835, 27320, 27321, 27322, 27323, 27324, 27325, 27326, 27327, 27328] && $item2 ~~ [5835, 27320, 27321, 27322, 27323, 27324, 27325, 27326, 27327, 27328] && $item3 ~~ [5835, 27320, 27321, 27322, 27323, 27324, 27325, 27326, 27327, 27328] && $item4 ~~ [5835, 27320, 27321, 27322, 27323, 27324, 27325, 27326, 27327, 27328]) {
  	quest::emote("smiles 'These should improve my skills nicely! Please tell your friends!'");
  	quest::summonitem(132524);#Essence of the Tomb
	quest::setglobal("tomb_aug",1,5,"F");

  }
}#END of FILE Zone:eastwastes  ID:116608 -- Belath_the_Trader 
