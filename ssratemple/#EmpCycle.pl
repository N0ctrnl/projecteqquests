#BEGIN File: ssratemple\#EmpCycle.pl

my $BloodCoolDownTime = int(rand(60)) + 180; #Waiting time to reattempt Emp after failure (Current setting: 3-4 hours)
my $EmpRepopTime = int(rand(2880)) + 4320; #Respawn time for Emp after success (Current setting: 3-5 days)
my $EmpPrepTime = 150; #Seconds before Emp becomes targetable after killing Blood/Golem (Current setting: 2min 30sec)
my $EmpPrep;

sub EVENT_SPAWN {
  $EmpPrep = 0;
  quest::settimer("EmpCycle",10); #Cyclical Timer
}

sub EVENT_TIMER {
  if ($timer eq "EmpCycle") {
    quest::stoptimer("EmpCycle");
    # The Emperor flag has expired. Let's start this up.
    if (!defined($qglobals{Emperor}) && !defined($qglobals{BloodCoolDown})) { #Emperor is ready to spawn
      quest::setglobal("Emperor",1,0,"F"); #Normal Cycle Start
    }
    # The Blood lockout has passed, spawn him.
    if (($qglobals{Emperor} == 1) && !$entity_list->GetNPCByNPCTypeID(162064) && !defined $qglobals{BloodDead} && !$entity_list->GetNPCByNPCTypeID(162189) && ($EmpPrep == 0)) {
      quest::spawn2(162189,0,0,877.0,-325.0,400.5,192.0); ##Blood_of_Ssraeshza
    }
    # Blood is still locked out, spawn the Blood Golem.
    if (!defined($qglobals{BloodCoolDown}) && ($qglobals{Emperor} == 1) && !$entity_list->GetNPCByNPCTypeID(162064) && !$entity_list->GetNPCByNPCTypeID(162189) && !$entity_list->GetNPCByNPCTypeID(162227) && ($EmpPrep == 0)) {
      quest::spawn2(162064,0,0,877.0,-325.0,400.5,192.0); #Ssraeshzian_Blood_Golem
    }
    # Emperor timer is expired, go ahead and spawn him.
    if (!$entity_list->GetNPCByNPCTypeID(162065) && ($qglobals{Emperor} != 3)) {
      quest::spawn2(162065,0,0,990.0,-325.0,415.0,192.0); ##Emperor_Ssraeshza (No Target)
    }
    # The Blood Golem is up, but Blood timer is expired. Let's get rid of the Golem and spawn the Blood, but only if the real Emperor isn't up.
    if ($entity_list->GetNPCByNPCTypeID(162064) && !$entity_list->GetNPCByNPCTypeID(162227) && !defined $qglobals{BloodDead} && !defined($qglobals{BloodCoolDown})) {
      quest::depop(162064);
      quest::spawn2(162189,0,0,877.0,-325.0,400.5,192.0); ##Blood_of_Ssraeshza
    }
    else {
      quest::spawn2(162189,0,0,877.0,-325.0,400.5,192.0); ##Blood_of_Ssraeshza
    }
  }

  if ($timer eq "EmpPrep") {
    quest::stoptimer("EmpPrep");
    quest::depop(162065); ##Emperor_Ssraeshza (No Target)
    quest::spawn2(162227,0,0,990.0,-325.0,415.0,192.0); ##Emperor_Ssraeshza_ (Real)
    quest::setglobal("Emperor",2,0,"F");
    $EmpPrep = 0;
  }
}

sub EVENT_SIGNAL {
  if ($signal == 1) { #Blood Golem is dead
    quest::setglobal("BloodCoolDown",0,0,"M$BloodCoolDownTime"); #Cooldown timer
    quest::settimer("EmpPrep", $EmpPrepTime);
    $EmpPrep = 1;
  }
  if ($signal == 2) { #Emperor is dead
    quest::delglobal("Emperor");
    quest::setglobal("Emperor",3,0,"M$EmpRepopTime"); #Emp respawn timer
  }
  if ($signal == 3) { #Blood is dead
    quest::setglobal("BloodDead",1,3,"S216000"); #Cooldown timer
    quest::setglobal("BloodCoolDown",0,0,"M$BloodCoolDownTime"); #Cooldown timer
    quest::settimer("EmpPrep", $EmpPrepTime);
    $EmpPrep = 1;
  }
}

#END File: ssratemple\#EmpCycle.pl (162260)
