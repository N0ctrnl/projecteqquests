# Gargoyle Illusion Click

#sub EVENT_ITEM_CLICK_CAST {
sub EVENT_SPELL_EFFECT_CLIENT {
# Acumen first, then the good ones. This keeps MGB from working with the first spell (FoE).
    quest::castspell(2886, $client->GetID());
    quest::castspell(3185, $client->GetID());
    quest::castspell(2510, $client->GetID());
    quest::castspell(2590, $client->GetID());
    quest::castspell(1464, $client->GetID());
    quest::castspell(2629, $client->GetID());
    quest::castspell(2570, $client->GetID());
    quest::castspell(2895, $client->GetID());
    quest::castspell(2530, $client->GetID());
    quest::castspell(1580, $client->GetID());
}
