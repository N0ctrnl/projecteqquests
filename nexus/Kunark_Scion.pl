#REVISED: Abernath
#Zone: Nexus_Kunark_Scion
sub EVENT_SAY {
if ($text=~/Hail/i){quest::say("Hello there. The spires are undergoing maintenance. If you need to know more about [" . quest::saylink("travel to Dreadlands") . "], I can help you with this."); }
if ($text=~/travel to dreadlands/i){quest::movepc(86,9660.55,3019.32,1049.85); }
}
