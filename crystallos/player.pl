sub EVENT_ENTERZONE {

	quest::me("Friggid winds envelope you as you find yourself encased in ice.");
	#plugin::Doors_Manip();
	plugin::Debug("DOORS FFS!");
	}
	
sub EVENT_CLICKDOOR {
    if($status > 200)
	{
    plugin::Doors_Manipulation_EVENT_CLICKDOOR(); # Door Manipulation Plugin$door = ($doorid % 256);
    $client->Message(13, "This is door number $door.");
	}
}


 
sub EVENT_SAY{
    if($status > 200)
	{
    plugin::Doors_Manipulation_EVENT_SAY(); # Door Manipulation Plugin
	plugin::GM_EVENT_SAY();
	plugin::Debug("it works");
    }
}