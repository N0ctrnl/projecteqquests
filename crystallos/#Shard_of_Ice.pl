sub EVENT_SPAWN
{
	quest::settimer("addspawn",10);

}

sub EVENT_TIMER{

	if ($timer eq "addspawn"){
	quest::emote("summons healing waters of the elementals to Crumble's aid.");
	quest::spawn2(999994,0,0,$x,$y,$z,$h);
	}
}