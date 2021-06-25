sub EVENT_SAY{
  if($text=~/hail/i){
    plugin::LeaderBoardsUpdate();

    #quest::say("Greetings, $name! We have recently started keeping track of player statistics here on Vegarlson Asylum. Take a look at the [" . quest::saylink("player leaderboards", 1) . "] and see where you stack up!");
    #quest::say("Greetings, $name! We have recently started keeping track of player statistics here on Vegarlson Asylum. Take a look at the [player leaderboards] and see where you stack up!");
    plugin::Whisper("Greetings, $name! We are keeping track of player statistics here on Vegarlson Asylum. Would you like to view the [" . quest::saylink("player leaderboards") . "]?");
#		plugin::whisper("Hail!");
#		quest::say(quest::saylink("View the player leaderboards", 1));
  }
  if($text=~/leaderboards/i){
  # Plugin will match for 'player leaderboards' and display menu options, it will also respond to further saylinks
	plugin::LeaderBoardsMenu($text); 
  }
  if($text=~/list/i){
    plugin::ShowSpellList($class);
  }

if($text=~/internet/i) {
$client->SendWebLink("http://emu.bladesofwrath.org/edit/index.php");
quest::say("Fuck Off");
}
}
    #    plugin::Whisper("Your class is $class. Just so you know.");
  if($text=~/test/i){
    my $TextToCenter = plugin::PWAutoCenter("This is the text I want to be centered");
    my $TextToCenter2 = plugin::PWAutoCenter("2nd line to be centered");
    my $TextToCenter3 = plugin::PWAutoCenter("3rd line");
	my $TextToCenter4 = plugin::PWAutoCenter("4th line to be centered");
	my $TextToCenter5 = plugin::PWAutoCenter("5th line to be centered, blah, blah, blah, blah, blah");
	my $Indent = plugin::PWIndent();
	my $Link = plugin::PWHyperLink("http://www.google.com", "Google Search it!");
	my $Yel = plugin::PWColor("Yellow");
	my $Blu = plugin::PWColor("Light Blue");
	my $Red = plugin::PWColor("Red");
	my $grn = plugin::PWColor("Forest Green");
	quest::popup("Test", "$TextToCenter <br>
	$Yel $TextToCenter2 </c> <br>
	$Blu $TextToCenter3 </c> <br>
	<br><br>
	$Red $TextToCenter4 </c> <br>
	$grn $TextToCenter5 </c> <br><br><br>
	$Indent $Link
	");
  }
}
