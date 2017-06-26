sub EVENT_SAY {

 my $send = quest::saylink("send");
  
 
if ($text =~/Hail/i){
plugin::Whisper ("Would you like me to [$send] you to the other side?"); 
}

if ($text =~/send/i){
$client->MovePC($zone,2141.5,1135,189.3,204.9);
}

}