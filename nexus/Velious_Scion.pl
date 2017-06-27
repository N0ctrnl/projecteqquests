#REVISED: Abernath
#Zone: Nexus_Velious_Scion
sub EVENT_SAY { 
if ($text=~/Hail/i){quest::say("Hello there. The spires are undergoing maintenance. If you need to know more about [" . quest::saylink("travel to Velious") . "], I can help you with this."); }
if ($text=~/travel to Velious/i){quest::movepc(118,-2683.82,-1892.07,-45.08); }
}