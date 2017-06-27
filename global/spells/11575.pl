sub EVENT_SPELL_EFFECT_CLIENT {  
  my $client = $entity_list->GetClientByID($caster_id);
  quest::castspell(13542);
}
