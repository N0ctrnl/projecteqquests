sub EVENT_SAY { 
 if($text=~/hail/i) {
    quest::AssignToInstance(11);
    $client->Message(15,"Hey homie! Wanna [" . quest::saylink("go") . "] see a a dead body?");
  }
#if ($text=~/return/i){quest::movepc(152, 0, 0, 0, 0); }
if ($text=~/go/i){quest::MovePCInstance(701, 11, 3, -344.84, 6.29); }
#} if($text=~/return/i && defined $qglobals{"SR_zone"}) {
# if ($qglobals{"SR_zone"} == nexus) {
#  quest::delglobal("SR_zone");
# } 
#} elseif ($qglobals{"SR_zone"} == butcher) {
#  quest::delglobal("SR_zone");
#  quest::movepc(68,2553,1254,.4,180);
# }
}
