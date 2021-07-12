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
  if($text=~/test/i){
    quest::debug($client->GetStartZone());
  }

  if ($text=~/augme/i && defined($qglobals{tomb_aug}) && !plugin::check_hasitem($client, 150001)) {
    plugin::Whisper("It seems you have lost your augment! Lucky for you I have had very good success of late and happen to be in a generous mood. Please be more careful with this one!");
    quest::summonitem(150001);#Essence of the Tomb
  }
}
