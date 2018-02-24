sub EVENT_SPAWN
{
quest::settimer(2,3600); #depop timer
}

sub EVENT_TIMER
{
if($timer == 2)
	{
        quest::depopall(200100);
	quest::depop();
	}
}

sub EVENT_SLAY
{
quest::spawn2(200100,0,0,($x + 7),$y,$z,$h);
quest::spawn2(200100,0,0,($x - 7),$y,$z,$h);
quest::spawn2(200100,0,0,$x,($y + 7),$z,$h);
quest::spawn2(200100,0,0,$x,($y - 7),$z,$h);
}

sub EVENT_DEATH_COMPLETE
{
quest::depopall(200100);
quest::spawn2(200039,0,0,180,230,-71.5,254);
}
