# Lorekeeper Xivan - Nexus (Spell Lists)
# npcID 152101
sub EVENT_SAY {
  if($class eq "Warrior" || $class eq "Rogue" || $class eq "Monk"){
    $client->Message(315, "I have no information to share with melee classes.");
  } elsif($text=~/hail/i){
    my $low_spells = quest::saylink("spells low", 1, "1-20 Spells");
    my $medium_spells = quest::saylink("spells medium", 1, "21-40 Spells");
    my $high_spells = quest::saylink("spells high", 1, "41-60 Spells");
    my $max_spells = quest::saylink("spells max", 1, "61-65 Spells");
    my $all_spells = quest::saylink("spells all", 1, "All Spells");

    $client->Message(315, 'Spell Lists');
    $client->Message(315, '-----------------------------------------------------');
    $client->Message(315, " --- " . $low_spells . " - " . $medium_spells . " - " . $high_spells);
    $client->Message(315, " --- " . $max_spells . " - " . $all_spells);
    $client->Message(315, '-----------------------------------------------------');

  } elsif($text=~/spells/i){
    if($text=~/low/i){
      plugin::ShowSpellList($class,"low");
    } elsif($text=~/medium/i){
      plugin::ShowSpellList($class,"medium");
    } elsif($text=~/high/i){
      plugin::ShowSpellList($class,"high");
    } elsif($text=~/max/i){
      plugin::ShowSpellList($class,"max");
    } else {
      plugin::ShowSpellList($class,"all");
    }
  }
}
