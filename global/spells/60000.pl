# VA Buff Crystal
# Written by N0ctrnl (2016)

# Old Buff Crystals - Only worked for level 44+
#sub EVENT_ITEM_CLICK_CAST {
##sub EVENT_SPELL_EFFECT_CLIENT {
	#  $Zone = $client->GetZoneID();
	#  if($Zone < 187 || $Zone == 202 || $Zone == 203 || $Zone == 408 || $Zone == 226 || $Zone == 411) {
  # Acumen first, then the good ones. This keeps MGB from working with the first spell (FoE).
  ##  if($client->GetLevel() > 44){
  ##    # Acumen
  ##    quest::castspell(2886, $client->GetID());
  ##    # Flight of Eagles
  ##    quest::castspell(3185, $client->GetID());
  ##    # Blessing of Aegolism
  ##    quest::castspell(2510, $client->GetID());
  ##    # Brell's Mountainous Barrier
  ##    quest::castspell(2590, $client->GetID());
  ##    # Call of the Predator
  ##    quest::castspell(1464, $client->GetID());
  ##    # Spiritual Purity
  ##    quest::castspell(2629, $client->GetID());
  ##    # Koadic's Endless Intellest
  ##    quest::castspell(2570, $client->GetID());
  ##    # Speed of the Brood
  ##    quest::castspell(2895, $client->GetID());
  ##    # Khura's Focusing
  ##    quest::castspell(2530, $client->GetID());
  ##    # Talisman of the Brute
  ##    quest::castspell(1580, $client->GetID());
  ##  }
  ##}


sub EVENT_SPELL_EFFECT_CLIENT {
  my @groupMembers;
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
  $buffBot{"tier1"}{Magician}{Levitation} = 970;	#Levitation 
  $buffBot{"tier1"}{Shaman}{HP} = 167;			#Talisman of Tnarg / 32
	
  # Levels 36 to 65
  $buffBot{"tier2"}{Cleric}{HP} = 1533;			#Heroism / 52
  $buffBot{"tier2"}{Cleric}{SpellHaste} = 3576;		#Blessing of Faith / 35
  $buffBot{"tier2"}{Druid}{HPRegen} = 1568;		#Regrowth / 54
  $buffBot{"tier2"}{Druid}{RunSpeed} = 11545;		#Spirit of Wolf / 10
  $buffBot{"tier2"}{Enchanter}{ManaRegen} = 1693;		#Clarity II / 52
  $buffBot{"tier2"}{Enchanter}{MeleeHaste} = 1708;	#Aanya's Quickening / 53
  $buffBot{"tier2"}{Magician}{DamageShield} = 412;	#Shield of Lava / 45
  $buffBot{"tier2"}{Magician}{Levitation} = 970;	#Levitation 
  $buffBot{"tier2"}{Shaman}{HP} = 1585;			#Talisman of Kragg / 55

  # Levels 60 to 65
  $buffBot{"tier3"}{Cleric}{HP} = 1447;			#Aegolism / 60
  $buffBot{"tier3"}{Cleric}{SpellHaste} = 3472;		#Blessing of Reverence / 62
  $buffBot{"tier3"}{Druid}{HPRegen} = 1568;		#Regrowth
  $buffBot{"tier3"}{Druid}{RunSpeed} = 7617;		#Spirit of Eagle
  $buffBot{"tier3"}{Enchanter}{ManaRegen} = 2570;	#Koadic's Endless Intellect / 60
  $buffBot{"tier3"}{Enchanter}{MeleeHaste} = 3240;	#Speed of Vallon / 62
  $buffBot{"tier3"}{Magician}{DamageShield} = 3448;	#Shield of Bracken / 63
  $buffBot{"tier3"}{Shaman}{HP} = 3235;			#Focus of Soul / 62

  # Levels 71 to 90
  $buffBot{"tier4"}{Cleric}{HP} = 5257;			#Conviction / 67
  $buffBot{"tier4"}{Cleric}{SpellHaste} = 5258;		#Blessing of Devotion / 67
  $buffBot{"tier4"}{Druid}{HPRegen} = 5342;		#Oaken Vigor / 66
  $buffBot{"tier4"}{Druid}{RunSpeed} = 11545;		#Spirit of Wolf / 10
  $buffBot{"tier4"}{Enchanter}{ManaRegen} = 5513;		#Clairvoyance / 68
  $buffBot{"tier4"}{Enchanter}{MeleeHaste} = 5507;	#Speed of Salik / 67
  $buffBot{"tier4"}{Magician}{DamageShield} = 5466;	#Fireskin / 66
  $buffBot{"tier4"}{Shaman}{HP} = 5396;			#Wunshi's Focusing / 68
  $buffBot{"tier4"}{Shaman}{MeleeDodge} = 5390;		#Spirit of Sense / 66
  $buffBot{"tier4"}{Shaman}{MeleeProc} = 6667;		#Spirit of the Panther / 69
	
  foreach my $member (@{$members}){
  my $clientLevel = $member->GetLevel();
    if($clientLevel >= 1 && $clientLevel <= 35){
      my $tier = "tier1";
      $client->SpellFinished($buffBot{$tier}{Cleric}{HP}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Cleric}{SpellHaste}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Druid}{HPRegen}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Druid}{RunSpeed}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Enchanter}{MeleeHaste}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Enchanter}{ManaRegen}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Magician}{DamageShield}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Magician}{Levitation}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Shaman}{HP}, $member, 0); 
    } elsif($clientLevel >= 36 && $clientLevel <= 59) {
      my $tier = "tier2";
      $client->SpellFinished($buffBot{$tier}{Cleric}{HP}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Cleric}{SpellHaste}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Druid}{HPRegen}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Druid}{RunSpeed}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Enchanter}{ManaRegen}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Enchanter}{MeleeHaste}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Magician}{DamageShield}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Magician}{Levitation}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Shaman}{HP}, $member, 0); 
    } elsif($clientLevel >= 60 && $clientLevel <= 70) {
      my $tier = "tier3";
      $client->SpellFinished($buffBot{$tier}{Cleric}{HP}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Cleric}{SpellHaste}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Druid}{HPRegen}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Druid}{RunSpeed}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Enchanter}{ManaRegen}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Enchanter}{MeleeHaste}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Magician}{DamageShield}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Shaman}{HP}, $member, 0); 
    } elsif($clientLevel >= 71 && $clientLevel <= 90) {
      my $tier = "tier4";
      $client->SpellFinished($buffBot{$tier}{Cleric}{HP}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Cleric}{SpellHaste}, $member, 0);
      $client->SpellFinished($buffBot{$tier}{Druid}{HPRegen}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Druid}{RunSpeed}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Enchanter}{ManaRegen}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Enchanter}{MeleeHaste}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Magician}{DamageShield}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Shaman}{HP}, $member, 0); 
      $client->SpellFinished($buffBot{$tier}{Shaman}{MeleeDodge}, $member, 0);
      $client->SpellFinished($buffBot{$tier}{Shaman}{MeleeProc}, $member, 0);
    }
  }
}
