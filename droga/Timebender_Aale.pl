#Created: Ender
##Zone: Droga Instance Porter
#sub EVENT_SAY {
#if ($text=~/Hail/i){quest::say("Greetings! I am Timebender Aale. Through years of research into the temporal rifts in this area, I am able to create a portal to the past. Would you like to see the [" . quest::saylink("past version") . "] of this zone?"); }
#if ($text=~/past version/i){
#quest::AssignToInstance(36);
#quest::MovePCInstance(97, 36, 350.08, 1385.17, 3.75);
#}
##END of FILE
#
sub EVENT_SAY {
  $InstanceDroga = quest::GetInstanceID("droga",99);
  $group = $client->GetGroup();

  if ($text=~/hail/i) {
      quest::say("Greetings! I am Timebender Aale. Through years of research into the temporal rifts in this area, I am able to create a portal to the past. Would you like to see the [" . quest::saylink("past version") . "] of this zone?");
  }
  if ($text=~/past version/i) {
#          if($group) {
#           quest::AssignGroupToInstance($InstanceDroga);
#          } elsif {
#            quest::AssignToInstance($InstanceDroga);
            quest::AssignToInstance(36);
            quest::MovePCInstance(97, 36, 350.08, 1385.17, 3.75);
          }
}
