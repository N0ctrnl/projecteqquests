# Recordkeeper_Trader.pl
# Written by N0ctrnl (2016)
# This is the VA custom Leaderboards NPC.

sub EVENT_SAY {
  if($text=~/hail/i){
    plugin::Whisper("Greetings, $name! We are keeping track of player statistics here on Vegarlson Asylum. Would you like to view the [" . quest::saylink("player leaderboards") . "]?");
  }
  if($text=~/leaderboards/i){
    plugin::LeaderBoardsMenu($text); 
  }
}
