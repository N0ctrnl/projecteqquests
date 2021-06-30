sub EVENT_SAY {
  if($text=~/Hail/i) {
    quest::say("You there! Had enough yet? . . . Aah, never mind, just tell me when you want to [" . quest::saylink("I want to leave",0,"leave") . "].");
  }
  if($text=~/leave/i) {
    quest::movepc(206,221,555,-50,102); # Zone: poinnovation
  }
}
