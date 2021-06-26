#REVISED: Abernath
#Zone: Nexus_Odus_Scion
sub EVENT_SAY {
  if ($text=~/Hail/i){quest::say("Hello there. The spires are undergoing maintenance. If you need to know more about [" . quest::saylink("travel to Toxxulia Forest") . "], I can help you with this."); }
  # Old Tox - Ender
  if ($text=~/travel to Tox/i){quest::movepc(38,-872.35,-1514.85,-34.51); }
  # New Toxxulia - Ender
  #if ($text=~/travel to Toxxulia Forest/i){quest::movepc(414,-1657,-1501,69.54); }
}
