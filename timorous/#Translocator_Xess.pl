#REVISED: Angelox
#Zone: timorous
sub EVENT_SAY { 
if ($text=~/Hail/i){quest::say("Hello there. We have most the ships working again. If you need to know more about [" . quest::saylink("travel to overthere") . "],  [" . quest::saylink("travel to oasis") . "]  I can help you with this."); }
if ($text=~/travel to overthere/i){quest::movepc(93,2734.35,3444.37,-157.34); }
if ($text=~/travel to oasis/i){quest::movepc(37,-839.50,884.03,0.70); }
}
