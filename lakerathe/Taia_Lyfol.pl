sub EVENT_SAY { 
if($text=~/Hail/i){
  quest::say("Hello. $name. What brings you to the watery lands of Rathtear? Do you seek [" . quest::saylink("I seek enlightenment",0,"enlightenment") . "]?'"); }
}
#END of FILE Zone:lakerathe  ID:51095 -- Taia_Lyfol 

