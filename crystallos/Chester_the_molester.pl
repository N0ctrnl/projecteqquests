sub EVENT_SAY {

if ($text =~/Hail/i) { 
  quest::say("Hello there little one, would you like some candy? ");
  $client=>SpellFinished(7477);
  
  
}
}






