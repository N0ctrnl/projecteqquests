sub EVENT_SAY {
  if($text=~/hail/i) {
    quest::me("The Warden looks down, his dark eyes burrowing into yours. 'My prison is not one for casual visits, $race. What is your business here? Do you seek an [" . quest::saylink("audience") . "] with the Tribunal?''");
  }
  if($text=~/audience/i) {
    quest::emote("nods slightly. 'You shall find them through this gateway. I trust you shall find their knowledge vast, and their justice. . . ' his lips curl into a sneer, 'quite fitting.'");
  }
}
