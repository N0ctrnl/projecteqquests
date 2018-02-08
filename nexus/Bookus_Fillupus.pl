sub EVENT_SAY {
  if($text=~/hail/i){
    plugin::Whisper("Hello there, $name! If you didn't get your spells and disciplines auto-scribed for you as you leveled up - this feature was added in January 2018 - then you could be missing some spells! Just tell me to [" . quest::saylink("fix") . "] it, and I'll set you right up!");
  } elsif($text=~/Fix/i){
    if ($ulevel <= 46){
      $client->Message(15,"Your experiences across the realm have infused you with increased power and knowledge...");

      # set all available skills to maximum for race/class at current level
      foreach my $skill (0 .. 42, 48 .. 54, 70 .. 74){
        next unless $client->CanHaveSkill($skill);
        my $maxSkill = $client->MaxSkill($skill, $client->GetClass(), $ulevel);
#        next unless $maxSkill < $client->GetRawSkill($skill);
        next unless $client->MaxSkill( $skill, $client->GetClass(), $ulevel ) > 0 & $client->GetRawSkill($skill) < 1;
        $client->SetSkill($skill, 1);
      }
      # scribe all spells for current level
      quest::scribespells($ulevel, $ulevel - 1);
      # train all discs for current level
      quest::traindiscs($ulevel, $ulevel - 1);
    } else {
      quest::scribespells(46, 1);
      quest::traindiscs(46, 1);
      plugin::Whisper("There you go!");
    }
  }
}
