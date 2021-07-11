sub EVENT_SAY {
  my @groupMembers;
  if($text =~ /hail/i ){
    if($client->IsGrouped()){
      for($count = 0; $count < 6; $count++){
      my $cur = $client->GetGroup()->GetMember($count);
      if($cur){
        if($cur->IsClient()){
          push @groupMembers, $cur;
        }
      }
    }
  } else {
    push @groupMembers, $client;
  }
  BuffMembers(\@groupMembers);
  $npc->Say("Use them wisely " . $client->GetCleanName());
  }
}

sub BuffMembers{
  my $members = shift;
  my %buffBot;

  # Levels 1 to 35
  $buffBot{"tier1"}{Cleric}{HP} = 312;			#Valor / 32
  $buffBot{"tier1"}{Cleric}{SpellHaste} = 3576;		#Blessing of Faith / 35
  $buffBot{"tier1"}{Druid}{HPRegen} = 144;		#Regeneration / 34
  $buffBot{"tier1"}{Druid}{RunSpeed} = 11545;		#Spirit of Wolf / 10
  $buffBot{"tier1"}{Enchanter}{ManaRegen} = 174;		#Clarity / 26
  $buffBot{"tier1"}{Enchanter}{MeleeHaste} = 10;		#Augmentation / 28
  $buffBot{"tier1"}{Magician}{DamageShield} = 479;	#Inferno Shield / 28
  $buffBot{"tier1"}{Shaman}{HP} = 167;			#Talisman of Tnarg / 32
	
  # Levels 36 to 65
  $buffBot{"tier2"}{Cleric}{HP} = 1533;			#Heroism / 52
  $buffBot{"tier2"}{Cleric}{SpellHaste} = 3576;		#Blessing of Faith / 35
  $buffBot{"tier2"}{Druid}{HPRegen} = 1568;		#Regrowth / 54
  $buffBot{"tier2"}{Druid}{RunSpeed} = 11545;		#Spirit of Wolf / 10
  $buffBot{"tier2"}{Enchanter}{ManaRegen} = 1693;		#Clarity II / 52
  $buffBot{"tier2"}{Enchanter}{MeleeHaste} = 1708;	#Aanya's Quickening / 53
  $buffBot{"tier2"}{Magician}{DamageShield} = 412;	#Shield of Lava / 45
  $buffBot{"tier2"}{Shaman}{HP} = 1585;			#Talisman of Kragg / 55
	
  # Levels 65 to 70
  $buffBot{"tier3"}{Cleric}{HP} = 5257;			#Conviction / 67
  $buffBot{"tier3"}{Cleric}{SpellHaste} = 5258;		#Blessing of Devotion / 67
  $buffBot{"tier3"}{Druid}{HPRegen} = 5342;		#Oaken Vigor / 66
  $buffBot{"tier3"}{Druid}{RunSpeed} = 11545;		#Spirit of Wolf / 10
  $buffBot{"tier3"}{Enchanter}{ManaRegen} = 5513;		#Clairvoyance / 68
  $buffBot{"tier3"}{Enchanter}{MeleeHaste} = 5507;	#Speed of Salik / 67
  $buffBot{"tier3"}{Magician}{DamageShield} = 5466;	#Fireskin / 66
  $buffBot{"tier3"}{Shaman}{HP} = 5396;			#Wunshi's Focusing / 68
  $buffBot{"tier3"}{Shaman}{MeleeDodge} = 5390;		#Spirit of Sense / 66
  $buffBot{"tier3"}{Shaman}{MeleeProc} = 6667;		#Spirit of the Panther / 69
	
  foreach my $member (@{$members}){
  my $clientLevel = $member->GetLevel();
    if($clientLevel >= 1 && $clientLevel <= 35){
      my $tier = "tier1";
      $npc->SpellFinished($buffBot{$tier}{Cleric}{HP}, $member, 0); 
      $npc->SpellFinished($buffBot{$tier}{Cleric}{SpellHaste}, $member, 0); 
      $npc->SpellFinished($buffBot{$tier}{Druid}{HPRegen}, $member, 0); 
      $npc->SpellFinished($buffBot{$tier}{Druid}{RunSpeed}, $member, 0); 
      $npc->SpellFinished($buffBot{$tier}{Enchanter}{MeleeHaste}, $member, 0); 
      $npc->SpellFinished($buffBot{$tier}{Enchanter}{ManaRegen}, $member, 0); 
      $npc->SpellFinished($buffBot{$tier}{Magician}{DamageShield}, $member, 0); 
      $npc->SpellFinished($buffBot{$tier}{Shaman}{HP}, $member, 0); 
    } elsif($clientLevel >= 36 && $clientLevel <= 65) {
      my $tier = "tier2";
      $npc->SpellFinished($buffBot{$tier}{Cleric}{HP}, $member, 0); 
      $npc->SpellFinished($buffBot{$tier}{Cleric}{SpellHaste}, $member, 0); 
      $npc->SpellFinished($buffBot{$tier}{Druid}{HPRegen}, $member, 0); 
      $npc->SpellFinished($buffBot{$tier}{Druid}{RunSpeed}, $member, 0); 
      $npc->SpellFinished($buffBot{$tier}{Enchanter}{ManaRegen}, $member, 0); 
      $npc->SpellFinished($buffBot{$tier}{Enchanter}{MeleeHaste}, $member, 0); 
      $npc->SpellFinished($buffBot{$tier}{Magician}{DamageShield}, $member, 0); 
      $npc->SpellFinished($buffBot{$tier}{Shaman}{HP}, $member, 0); 
    } elsif($clientLevel >= 65 && $clientLevel <= 70) {
      my $tier = "tier3";
      $npc->SpellFinished($buffBot{$tier}{Cleric}{HP}, $member, 0); 
      $npc->SpellFinished($buffBot{$tier}{Cleric}{SpellHaste}, $member, 0);
      $npc->SpellFinished($buffBot{$tier}{Druid}{HPRegen}, $member, 0); 
      $npc->SpellFinished($buffBot{$tier}{Druid}{RunSpeed}, $member, 0); 
      $npc->SpellFinished($buffBot{$tier}{Enchanter}{ManaRegen}, $member, 0); 
      $npc->SpellFinished($buffBot{$tier}{Enchanter}{MeleeHaste}, $member, 0); 
      $npc->SpellFinished($buffBot{$tier}{Magician}{DamageShield}, $member, 0); 
      $npc->SpellFinished($buffBot{$tier}{Shaman}{HP}, $member, 0); 
      $npc->SpellFinished($buffBot{$tier}{Shaman}{MeleeDodge}, $member, 0);
      $npc->SpellFinished($buffBot{$tier}{Shaman}{MeleeProc}, $member, 0);
    }
  }
}
