sub EVENT_SAY { 
 if($text=~/hail/i) {
    $client->Message(15,"Greetings! I am Johny. My charge is to transport weary travelers such as yourself to the place they came from. Would you like to  [" . quest::saylink("return") . "] to where you came from?");
  }
if ($text=~/return/i){quest::movepc(152, 0, 0, 0, 0); }
#} if($text=~/return/i && defined $qglobals{"SR_zone"}) {
# if ($qglobals{"SR_zone"} == nexus) {
#  quest::delglobal("SR_zone");
# } 
#} elseif ($qglobals{"SR_zone"} == butcher) {
#  quest::delglobal("SR_zone");
#  quest::movepc(68,2553,1254,.4,180);
# }
}
