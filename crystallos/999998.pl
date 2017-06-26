sub EVENT_SIGNAL {

if ($signal == "walk"){

quest::moveto(439.9,666.6,-46.9,0,1); #golem ring move to crumble.
quest::settimer("attack",4);
}
}






