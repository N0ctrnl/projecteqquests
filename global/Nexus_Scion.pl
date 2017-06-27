#REVISED: Abernath
##Zone: dreadlands
sub EVENT_SAY { 
if ($text=~/Hail/i){quest::say("Hello $name. I do not have much time to chat. I must concentrate on the portal that is due to open soon. If you wish to [" . quest::saylink("journey to Luclin") . "], tell me so."); }
if ($text=~/journey to luclin/i){quest::movepc(152, 0, 0, 0, 0); }
}
