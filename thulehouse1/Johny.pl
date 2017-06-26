sub EVENT_SAY { 
 if($text=~/hail/i) {
    quest::AssignToInstance(11);
    $client->Message(15,"Hey homie! Wanna [" . quest::saylink("go") . "] to the Nexus?");
  }
#if ($text=~/return/i){quest::movepc(152, 0, 0, 0, 0); }
if ($text=~/go/i){quest::selfcast("2945"); }
# }
}
