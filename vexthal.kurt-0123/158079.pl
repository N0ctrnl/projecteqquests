# Spawn shade when Zun Va Liako dies
sub EVENT_DEATH_COMPLETE {
  quest::spawn2(158020,0,0,$x,$y,$z,$h)
}
