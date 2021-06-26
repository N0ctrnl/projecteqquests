#REVISED: Abernath
#Zone: Nexus_Faydwer_Scion
sub EVENT_SAY {
if ($text=~/Hail/i){quest::say("Hello there. The spires are undergoing maintenance. If you need to know more about [" . quest::saylink("travel to Greater Faydark") . "], I can help you with this."); }
if ($text=~/travel to Greater Faydark/i){quest::movepc(54,-427.31,-2008.34,1.05); }
}
#END of FILE Zone:nexus  ID:152005 -- Faydwer_Scion
