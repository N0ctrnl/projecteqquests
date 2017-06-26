# Halloween skeleton costume

sub EVENT_ITEM_CLICK_CAST {
	if($itemid == 50606 && $spell_id == 7653 && ($questitem->IsAttuned() == 1)){
		quest::playerrace(668);
	} 
}
