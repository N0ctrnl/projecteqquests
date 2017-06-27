#BEGIN File: sebilis\zone_controller.pl

my $UndeadBardTimer = int(rand(14400)) + 43200; #Respawn time for Emp after success (Current setting: 3-5 days)

sub EVENT_TIMER {
  if ($timer eq "UDB") {
    quest::stoptimer("UDB");
    # Timer is up. Let's spawn the Undead Bard
    quest::spawn2(89168,0,0,-700.0,-2080.0,-140.13,64.0); ## An_Undead_Bard
  }
}

sub EVENT_SIGNAL {
  if ($signal == 1) { #Trakanon is dead
    quest::settimer("UDB", $UndeadBardTimer); #Start the timer - 16-20 hours
  }
}
