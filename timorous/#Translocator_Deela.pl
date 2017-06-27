#REVISED: Angelox
#Zone: timorous
sub EVENT_SAY { 
if ($text=~/Hail/i){quest::say("Hello there. We have most the ships working again. If you need to [" . quest::saylink("travel to butcherblock") . "]  or [" . quest::saylink("travel to firiona") . "] I can help you with this."); }
if ($text=~/travel to butcherblock/i){quest::movepc(68,3168.92,851.92,11.66); }
if ($text=~/travel to firiona/i){quest::movepc(84,1408.58,-4392.81,-102.31); }
}
