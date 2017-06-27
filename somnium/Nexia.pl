##Nexia.pl
#Zone: somnium

my $nexus = quest::saylink ("The Nexus",1);

sub EVENT_SAY{
  if ($text=~/Hail/i){
  quest::say ("Hello there, $name.  I can send you to [$nexus] when you are ready to leave this place.");
  }
  if($text=~/nexus/i)
  {   
  quest::selfcast(2734);
  }
}