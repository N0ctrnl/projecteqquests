sub EVENT_SAY{
	if($text=~/hail/i){
#		quest::say("Greetings, $name! We have recently started keeping track of player statistics here on Vegarlson Asylum. Take a look at the [" . quest::saylink("player leaderboards", 1) . "] and see where you stack up!");
#		quest::say("Greetings, $name! We have recently started keeping track of player statistics here on Vegarlson Asylum. Take a look at the [player leaderboards] and see where you stack up!");
		plugin::Whisper("Greetings, $name! We are keeping track of player statistics here on Vegarlson Asylum. Would you like to view the [" . quest::saylink("player leaderboards") . "]?");
#		plugin::whisper("Hail!");
#		quest::say(quest::saylink("View the player leaderboards", 1));
	}
	if($text=~/leaderboards/i){
	# Plugin will match for 'player leaderboards' and display menu options, it will also respond to further saylinks
	}
	plugin::LeaderBoardsMenu($text); 
}
