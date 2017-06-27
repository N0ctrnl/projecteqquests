sub EVENT_ITEM {
  if(plugin::check_handin(\%itemcount, 10092 => 1)){
# Plane of Hate
    quest::movegrp(76,-353,-374.8,3.75);
  } elsif(plugin::check_handin(\%itemcount, 10094 => 1)){
# Plane of Sky
    quest::movegrp(71,539,1384,-664);
  } elsif(plugin::check_handin(\%itemcount, 76000 => 1)){
# North Karana
    quest::movegrp(13,1209,-3685,-5);
  } elsif(plugin::check_handin(\%itemcount, 76001 => 1)){
# Commonlands
    quest::movegrp(408,1592,678,-40.72);
  } elsif(plugin::check_handin(\%itemcount, 76002 => 1)){
# Lavastorm
    quest::movegrp(27,460,460,-86);
  } elsif(plugin::check_handin(\%itemcount, 76003 => 1)){
# Toxxulia
    quest::movegrp(414,-1172,1025,26.81);
  } elsif(plugin::check_handin(\%itemcount, 76004 => 1)){
# Greater Faydark
    quest::movegrp(54,-441,-2023,4);
  } elsif(plugin::check_handin(\%itemcount, 76005 => 1)){
# Dreadlands
    quest::movegrp(86,9658,3047,1052);
  } elsif(plugin::check_handin(\%itemcount, 76006 => 1)){
# Iceclad
    quest::movegrp(110,385,5321,-17);
  } elsif(plugin::check_handin(\%itemcount, 76007 => 1)){
# Cobalt Scar
    quest::movegrp(117,-1634,-1065,299);
  } elsif(plugin::check_handin(\%itemcount, 76009 => 1)){
# Twilight Sea
    quest::movegrp(170,-1028,1338,39);
  } elsif(plugin::check_handin(\%itemcount, 76010 => 1)){
# Stonebrunt Mountaints
    quest::movegrp(100,673,-4531,0);
  } elsif(plugin::check_handin(\%itemcount, 132519 => 1)){
#    if (defined($qglobals{"gh$char"})) {
#      $ghinstance = $qglobals{"gh$char"};
#      quest::AssignToInstance($ghinstance);
#      quest::MovePCInstance(345, $ghinstance, -1.00, -1.00, 3.34);
#      #$client->MovePCInstance(345, $ghinstance, -1.00, -1.00, 3.34, 0);
#    } else {
#      $ghinstance = quest::CreateInstance("guildhall", 1, 1200);
#      quest::AssignToInstance($ghinstance);
#      quest::setglobal("gh$char",$ghinstance,7,"H2");
#      quest::MovePCInstance(345, $ghinstance, -1.00, -1.00, 3.34)
#      #$client->MovePCInstance(345, $ghinstance, -1.00, -1.00, 3.34, 0);
#    }
    if (defined($qglobals{$charid})) {
      $guildinstance = $qglobals{$charid};
      quest::AssignToInstance($guildinstance);
      quest::MovePCInstance(345, $guildinstance, -1.00, -1.00, 3.34);
    } else {
      $guildinstance = quest::CreateInstance("guildhall", 1, 3600);
      quest::AssignToInstance($guildinstance);
      quest::setglobal("$charid",$guildinstance,7,"H1");
      quest::MovePCInstance(345, $guildinstance, -1.00, -1.00, 3.34);
    }
  }
  plugin::return_items(\%itemcount);
}
