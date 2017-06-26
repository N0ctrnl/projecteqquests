sub EVENT_SAY{
	if($text=~/hail/i){
		quest::say("What do you want?");
		quest::say(quest::saylink("I want to check my player leaderboards man!", 1));
	}
	if($text=~/leaderboards/i){
		quest::say("Fine!");
	}
	# Plugin will match for 'player leaderboards' and display menu options, it will also respond to further saylinks
	plugin::LeaderBoardsMenu($text);
}