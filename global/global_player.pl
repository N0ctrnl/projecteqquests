sub EVENT_CLICKDOOR{
    if($status > 200){
        plugin::Doors_Manipulation_EVENT_CLICKDOOR(); # Door Manipulation Plugin
    }
}

sub EVENT_LOOT {
  if($looted_id == 132522) {
    $client->Message(15, "There's a collector in The Bazaar that would be very interested in this token...");
  }
}
 
sub EVENT_SAY {
	@args = split(' ', $text);
	if ($status >= 150) {
		plugin::Doors_Manipulation_EVENT_SAY(); # Door Shit
		#@args = split(' ', $text);
		if ($text=~/#dis/i) {
			$client->Message (15, "Distance from " . $client->GetTarget()->GetCleanName() . " to you.");
			$client->Message (15, "X: " . ($client->GetTarget()->GetX() - $client->GetX())  . " Y: " . ($client->GetTarget()->GetY() - $client->GetY())  . "  Z: " . ($client->GetTarget()->GetZ() - $client->GetZ()));
		}
		elsif ($text=~/#stats/i) {
			$client->Message (15, "MinDMG: ".$client->GetTarget()->CastToNPC()->GetMinDMG()." -- MaxDMG: ".$client->GetTarget()->CastToNPC()->GetMaxDMG()."");
			$client->Message (15, "Beard Color: ".$client->GetTarget()->GetBeardColor()." -- Bodytype: ".$client->GetTarget()->GetBodyType()." -- Eye 1 Color ".$client->GetTarget()->GetEyeColor1()." -- Eye 2 Color: ".$client->GetTarget()->GetEyeColor2()."");
			$client->Message (15, "Luclin Face Type: ".$client->GetTarget()->GetLuclinFace()."");
		}
		elsif ($text=~/#gmcon/i) {
			$client->Message (15, "DEBUG: ".$client->CalcEXP(4)."");
			## $pc->GetLevelCon($npc->GetLevel())
		}
		elsif($args[0]=~/#groundspawn/i){
			if ($args[1]) { 
				my $itemdrop = $args[1];
				my $CX = $client->GetX();
				my $CY = $client->GetY();
				my $CZ = $client->GetZ();
				my $CH = $client->GetHeading();
				$connect = plugin::LoadMysql();
				$sth = $connect->prepare("SELECT idfile FROM items WHERE id = $itemdrop");
				$sth->execute();
				my $graphic = $sth->fetchrow_array();
				$sth = $connect->do("INSERT INTO `ground_spawns` VALUES ('', $zoneid, 0, $CX, $CY, $CZ, $CX, $CY, $CH, '".$graphic."_ACTORDEF', $itemdrop, 1, 'Auto', 300000)");
				$client->Message(315, "Groundspawn added to $zonesn!");
			}
			else { $client->Message(315,"Groundspawn: Item ID required!"); }
		}
		elsif($args[0]=~/#treespawn/i && $status > 150){
			if ($args[1] && $args[2] && $args[3] && $args[4]) {
				plugin::InsertStaticTreeProcedure($text, $client);
				$client->Message(13, "TreeSpawn added to $zonesn at your location!");
			}
			else { $client->Message(13,"Format: #treespawn itemid respawntimer basegrowth addsize"); }
		}
		elsif (($text=~/#gmwho/i) && ($status >= 250)) {
			my %classhash = (
				1 	=> "Warrior",
				2 	=> "Cleric",
				3 	=> "Paladin",
				4 	=> "Ranger",
				5 	=> "Shadow Knight",
				6 	=> "Druid",
				7 	=> "Monk",
				8 	=> "Bard",
				9 	=> "Rogue",
				10	=> "Shaman",
				11	=> "Necromancer",
				12	=> "Wizard",
				13	=> "Magician",
				14	=> "Enchanter",
				15	=> "Beastlord",
				16	=> "Berserker",
			);
			my %racehash = (
				1	=>	"Human",
				2	=>	"Babarian",
				3	=>	"Erudite",
				4	=>	"Wood Elf",
				5	=>	"High Elf",
				6	=>	"Dark Elf",
				7	=>	"Half Elf",
				8	=>	"Dwarf",
				9	=>	"Troll",
				10	=>	"Ogre",
				11	=>	"Halfling",
				12	=>	"Gnome",
				128	=>	"Iksar",
				130	=>	"Vah Shir",
				330	=>	"Froglok",
			);
			my @clientsarray = $entity_list->GetClientList();
			$client->Message (11, "(GM List) Players in Zone:");
			$client->Message (11, "----------------------------------");
			foreach my $singleclient (@clientsarray) {
				my $clientguildname;
				my $longip = $singleclient->GetIP();
				$firstoctet = $longip % 256;
				$longip -= $firstoctet;
				$longip /= 256;
				$secondoctet = $longip % 256;
				$longip -= $secondoctet;
				$longip /= 256;
				$thirdoctet = $longip % 256;
				$longip -= $thirdoctet;
				$longip /= 256;
				if (quest::getguildnamebyid($singleclient->GuildID())) {
					$clientguildname = "".quest::getguildnamebyid($singleclient->GuildID())."";
				} else { $clientguildname = "UNGUILDED"; }
				my $dottedip = "$firstoctet.$secondoctet.$thirdoctet.$longip";
				my $wholist =	"[".$singleclient->GetLevel()." ".plugin::customclass($singleclient->GetClass(),$singleclient->GetDeity()).
								"] ".$singleclient->GetName()." (".$classhash{$singleclient->GetClass()}.") (".
								$racehash{$singleclient->GetRace()}.") <".$clientguildname."> [IP: ".$dottedip."]";
				$client->Message (11, "".$wholist."");
			}
			$client->Message (11, "There are ".scalar (@clientsarray)." players in zone!");
		}
	}
	if ($text=~/^#Update/i && $status < 100) {			
			plugin::GetLeaderboard(%qglobals);
			plugin::ShowLeaderboard("HP");
		}
#	if ($text=~/#linked/i) {
#            if ($client->GetTarget()->IsClient()) {
#                $client->Message(11, "-------------------------------------------------------------------------");
#                $client->Message(11, "[GM:] Showing Linked Accounts for Targetted Player");
#                $client->Message(11, "-------------------------------------------------------------------------");
#                my $dbh = plugin::LoadMysql();
#                my $sth = $dbh->prepare("
#                                            SELECT accid, name
#                                            FROM account_ip
#                                            INNER JOIN character_data
#                                            ON account_ip.accid = character_data.account_id
#                                            WHERE account_ip.ip = ?
#                                        ");
#                $sth->bind_param(1,ConvertIP($client->GetTarget()->CastToClient->GetIP()));
#                $sth->execute();
#                while (my @row = $sth->fetchrow_array()) {
#                    my ($account_id, $playername ) = @row;
#                    quest::gmsay("    Account ID: ".$account_id." --- Name: ".$playername."", 11, 1);
#                }
#                $sth->finish();
#                $dbh->disconnect();
#            }
#            else {
#                $client->Message(15, "[GM:] You MUST target a PLAYER to use this command!");
#            }
#        }
	if ($args[0]=~/#Leaderboard/i) {
		
		if(!defined($args[1]))
		{
			my %hash = plugin::LeaderboardTypeHash();
			foreach my $type (sort {$a cmp $b} keys %hash) {
				$client->Message(315, quest::saylink("#leaderboard $type", 1, "Top 10 Players in $type"));
			}
		}
		elsif($args[1] =~ /update/i && $status < 100)
		{
			plugin::GetLeaderboard(%qglobals);
		}
		plugin::ShowLeaderboard(substr($text, 13));

	}
	
	if($args[0] =~/^#house/i)
	{
		if($args[1] =~ /check/i)
		{
			$client->SetEntityVariable("DoorCommand", "Info");
			quest::signalwith(10, $client->GetID());
		}
		if($args[1] =~ /buy/i)
		{
			$client->SetEntityVariable("DoorCommand", "BuyHouse");
			quest::signalwith(10, $client->GetID());
		}
		if($args[1] =~ /purchase/i)
		{
			$client->SetEntityVariable("DoorCommand", "PurchaseHouse");
			quest::signalwith(10, $client->GetID());
		}
		if($args[1] =~ /sell/i)
		{
			$client->SetEntityVariable("DoorCommand", "SellHouse");
			quest::signalwith(10, $client->GetID());
		}
		if($args[1] =~ /relinquish/i)
		{
			$client->SetEntityVariable("DoorCommand", "RelinquishHouse");
			quest::signalwith(10, $client->GetID());
		}
		if($args[1] =~ /payrent/i)
		{
			$client->SetEntityVariable("DoorCommand", "PayRent");
			quest::signalwith(10, $client->GetID());
		}
		
	}
	
	if($args[0] =~/^#object/i)
	{
		if(defined($args[3]) && defined($args[2]) && defined($args[1]))
		{
			$client->SetEntityVariable("DoorCommand",  $args[0] . " " . $args[1] . " " . $args[2] . " " . $args[3]);
		}
		elsif(defined($args[1]) && defined($args[2]))
		{
			$client->SetEntityVariable("DoorCommand",  $args[0] . " " . $args[1] . " " . $args[2]);
		}
		elsif(defined($args[1]))
		{
			$client->SetEntityVariable("DoorCommand",  $args[0] . " " . $args[1]);
		}
		else
		{
			$client->SetEntityVariable("DoorCommand",  $args[0]);
		}
		quest::signalwith(10, $client->GetID());
	}

#}
  if ($text=~/#www/i || $text=~/#website/i || $text=~/#webpage/i) {
    $client->SendWebLink("http://www.vegarlson-server.org");
  }
  if ($text=~/#forum/i || $text=~/#forums/i || $text=~/#board/i) {
    $client->SendWebLink("http://www.vegarlson-server.org/index.php?action=forum");
  }
  if ($text=~/#alla/i || $text=~/#allaclone/i || $text=~/#clone/i) {
    $client->SendWebLink("http://www.vegarlson-server.org/index.php?action=alla");
  }
  if ($text=~/#char/i || $text=~/#character/i || $text=~/#characters/i) {
    $client->SendWebLink("http://www.vegarlson-server.org/index.php?action=charbrowser");
  }
  if ($text=~/#bug/i || $text=~/#bugs/i) {
    $client->SendWebLink("http://www.vegarlson-server.org/index.php?action=helpdesk;sa=main");
  }
  if ($text=~/#messages/i || $text=~/#pm/i || $text=~/#message/i) {
    $client->SendWebLink("http://www.vegarlson-server.org/index.php?action=pm");
  }
#	if ($text=~/#iteminfo/i) {
#	if ($text=~/#iteminfo/i) {
#	if ($text=~/#iteminfo/i) {
#	if ($text=~/#iteminfo/i) {
#	if ($text=~/#iteminfo/i) {
#		if ($client->GetItemAt(30)) {
#			$client->SendWebLink(""http://everquest.allakhazam.com/db/item.html?item="" . $client->GetItemIDAt(30));
#		}
#	} elsif ($text=~/#npcinfo/i) {
#		if ($client->GetTarget() && $client->GetTarget()->IsNPC()) {
#			$client->SendWebLink("http://everquest.allakhazam.com/db/npc.html?id=" . $client->GetTarget()->GetNPCTypeID());
#		}
#	} elsif ($text=~/#playerinfo/i) {
#		if ($client->GetTarget() && $client->GetTarget()->IsClient()) {
#			$client->SendWebLink("http://va.bladesofwrath.org/magelo-clone/character.php?char=" . $client->GetTarget()->GetCleanName());
#		}
#	}
}
sub EVENT_CONNECT {
    my %vet_aa = (481 => [1, 1, 1]); ## Lesson of the Devote 1 yr
#    482 => [63072000, 1, 1], ## Infusion of the Faithful 2 yr
#    483 => [94608000, 1, 1], ## Chaotic Jester 3 yr
#    484 => [126144000, 1, 1], ## Expedient Recovery 4 yr
#    485 => [157680000, 1, 1], ## Steadfast Servant 5 yr
#    486 => [189216000, 1, 1], ## Staunch Recovery 6 yr
#    487 => [220752000, 1, 1], ## Intensity of the Resolute 7 yr
#    511 => [252288000, 1, 1], ## Throne of Heroes 8 yr
#    2000 => [283824000, 1, 1], ## Armor of Experience 9 yr
#    8081 => [315360000, 1, 1], ## Summon Resupply Agent 10 yr
#    8130 => [346896000, 1, 1], ## Summon Clockwork Banker 11 yr
#    453 => [378432000, 1, 1], ## Summon Permutation Peddler 12 yr
#    182 => [409968000, 1, 1], ## Summon Personal Tribute Master 13 yr
#    600 => [441504000, 1, 1]); ## Blessing of the Devoted 14 yr
    my $age = $client->GetAccountAge();
    foreach my $key (keys %vet_aa) {
        if ($vet_aa{$key}[2] && ($vet_aa{$key}[2] || $age >= $vet_aa{$key}[0])) {
            $client->GrantAlternateAdvancementAbility($key, 1);
        }
    }
    if($ulevel < 2){
        quest::settimer("999",10);
    }
}

sub EVENT_ENTERZONE {
  if ($status < 2) {
    plugin::LeaderBoardsUpdate();
  }
  my %h = (7 => 99,
  8 => 199,
  9 => 249,
  10 => 299);
  foreach my $key (keys %h) {
    if (CheckSkills($client, $h{$key})) {
      quest::enabletitle($key);
    }
  }
#    if ($class = CLERIC && $ulevel >= 56) {
  if($class eq "Cleric" || $class eq "Paladin") {
    quest::settimer("yaulp",2);
  }
  if($ulevel < 2){
    quest::settimer("popup",10);
    quest::settimer("popup2",15);
  }
}

sub CheckSkills {
    my $client = shift;
    my $skill_level = shift;
    foreach my $skill (60, 61, 63, 64, 65, 68, 69) {
        if ($client->GetRawSkill($skill) <= $skill_level) {
            return 0;
        }
    }
    return 1;
}

sub EVENT_TIMER {
  if ($timer eq "999") {
  quest::stoptimer("999");
    if ($ulevel < 11){
          plugin::DiaWind("mysterious Hello there, {g}$name~!(Please resize this window to show all content. It's a little buggy when scrolling)<br>
          Please check out our forums @ {r}http://www.vegarlson-server.org/~ for full server information as well as to report any issues!
          {linebreak}<br>
                <table><tr><td>
                <tr><td>{bullet}</td><td>{g}Current expansion is Luclin~ - Future expansions are planned through PoP, LoY and LDoN.</td>
                <tr><td>{bullet}</td><td>{g}Client Support~ - RoF2 client required. {r}(See Forums)~</td>
                <tr><td>{bullet}</td><td>{g}6-box limit~ - An additional, locked account can be used for a Bazaar trader.</td>
                </td></tr></table>
                <table><tr><td>
                <tr><td>{bullet}</td><td>{y}Many zones have been modified in one way or another. Some information about them:</td>
                <tr><td>{bullet}</td><td>{orange}Classic zone versions:</td>
                </td></tr></table>
                <table><tr><td>
                <tr><td>{in}{bullet}</td><td>{gold}The Arena</td>
                <tr><td>{in}{bullet}</td><td>{gold}The Bazaar</td>
                <tr><td>{in}{bullet}</td><td>{gold}Cazic Thule</td>
                <tr><td>{in}{bullet}</td><td>{gold}Temple of Droga</td>
                <tr><td>{in}{bullet}</td><td>{gold}Mines of Nurga</td>
                <tr><td>{in}{bullet}</td><td>{gold}Lair of the Splitpaw</td>
                <tr><td>{in}{bullet}</td><td>{gold}The Plane of Hate</td>
                <tr><td>{in}{bullet}</td><td>{gold}Sirens Grotto</td>
                <tr><td>{in}{bullet}</td><td>{gold}Skyshrine</td>
                <tr><td>{in}{bullet}</td><td>{gold}The Western Wastes</td>
                </td></tr></table>
                <table><tr><td>
                <tr><td>{bullet}</td><td>{orange}New zone versions:</td>
                </td></tr></table>
                <table><tr><td>
                <tr><td>{in}{bullet}</td><td>{gold}The Commonlands</td>
                <tr><td>{in}{bullet}</td><td>{gold}Highpass Hold</td>
                <tr><td>{in}{bullet}</td><td>{gold}Nektulos Forest</td>
                <tr><td>{in}{bullet}</td><td>{gold}Toxxulia Forest</td>
                </td></tr></table>
");
#          {linebreak}");
    }
  }
  if ($timer eq "yaulp") {
    quest::stoptimer("yaulp");
    if ($client->IsSitting() && ($client->FindBuff(3186) || $client->FindBuff(2326) || $client->FindBuff(1534) || $client->FindBuff(210) || $client->FindBuff(44) || $client->FindBuff(43))) {
      $client->BuffFadeBySpellID(3186);
      $client->BuffFadeBySpellID(2326);
      $client->BuffFadeBySpellID(1534);
      $client->BuffFadeBySpellID(210);
      $client->BuffFadeBySpellID(44);
      $client->BuffFadeBySpellID(43);
    }
    quest::settimer("yaulp",1);
  }
  if ($timer eq "popup") {
    quest::stoptimer("popup");
    plugin::MM("Please go to www.vegarlson-server.org for information about our server! You can find our patcher there to get the correct files (zones,spells,etc.) for the VA Server!");
  }
  if ($timer eq "popup2") {
    quest::stoptimer("popup2");
    plugin::MM("Please go to www.vegarlson-server.org for information about our server! You can find our patcher there to get the correct files (zones,spells,etc.) for the VA Server!");
  }
}

sub EVENT_POPUPRESPONSE{
    #::: quest::say response subroutine
    quest::say_Process_Response();
}
sub EVENT_CAST
{


	if($spell_id == 7651)
	{
	
		if($zonesn eq "neighborhood" && !plugin::HasRadius($client->GetEntityVariable("PlacingItemID")))
		{
			$client->SetEntityVariable("DoorCommand", "PlaceItem");
			quest::signalwith(10, $client->GetID());
		}
		else
		{
			if(plugin::HasRadius($client->GetEntityVariable("PlacingItemID")))
			{
				my $object = $entity_list->GetObjectByID($client->GetEntityVariable("WardID" . $client->GetEntityVariable("PlacingItemID")));
				my $radiusobj = $client->GetEntityVariable("PlacingItemID");
				if(plugin::GetRadiusData($radiusobj, "reqclass") != 0 && plugin::GetRadiusData($radiusobj, "reqclass") != $client->GetClass())
				{
					if(plugin::GetRadiusData($radiusobj, "errmsgclass") && plugin::GetRadiusData($radiusobj, "errmsgclass") ne "")
					{
						$client->Message(15, plugin::GetRadiusData($radiusobj, "errmsgclass"));
					}
				}
				elsif(plugin::GetRadiusData($radiusobj, "reqdeity") != 0 && plugin::GetRadiusData($radiusobj, "reqdeity") != $client->GetDeity())
				{
					if(plugin::GetRadiusData($radiusobj, "errmsgdeity") && plugin::GetRadiusData($radiusobj, "errmsgdeity") ne "")
					{
						$client->Message(15, plugin::GetRadiusData($radiusobj, "errmsgdeity"));
					}
				}
				elsif(plugin::GetRadiusData($radiusobj, "reqlevel") != 0 && $client->GetLevel() < plugin::GetRadiusData($radiusobj, "reqlevel"))
				{
					if(plugin::GetRadiusData($radiusobj, "errmsglevel") && plugin::GetRadiusData($radiusobj, "errmsglevel") ne "")
					{
						$client->Message(15, plugin::GetRadiusData($radiusobj, "errmsglevel"));
					}
				}
				elsif(defined($object))
				{
					if(plugin::GetRadiusData($radiusobj, "errmsgplaced") && plugin::GetRadiusData($radiusobj, "errmsgplaced") ne "")
					{
						$client->Message(15, plugin::GetRadiusData($radiusobj, "errmsgplaced"));
					}
				}
				else
				{
					$slot = plugin::check_hasitem_inslot($client, $client->GetEntityVariable("PlacingItemID"));
					if($slot != 65535)
					{
						$client->DeleteItemInInventory($slot, 1, 1);
						$spawnid = quest::creategroundobject($client->GetEntityVariable("PlacingItemID"), $client->GetTargetRingX(), $client->GetTargetRingY(), $client->GetTargetRingZ(), $client->GetHeading(), plugin::GetRadiusData($radiusobj, "expire"));	#This spawns the ward, which lasts 60 seconds. Stores in $spawnid
						$object = $entity_list->GetObjectByID($spawnid);
						$object->SetEntityVariable("WardOwner", $client->GetID());
						$object->SetSize($client->GetEntityVariable("PlacingSize") ? $client->GetEntityVariable("PlacingSize") : 100);
						quest::settimer("WardTimer" . $client->GetEntityVariable("PlacingItemID"), plugin::GetRadiusData($radiusobj, "timer")); #Starts a timer with string "WardTimer" as $timer
						my $triggered = 0;
						if(plugin::GetRadiusData($radiusobj, "npcflag"))
						{
							#do stuff
							my @npcs = $entity_list->GetNPCList();
							foreach my $singlenpc (@npcs)
							{
								my $rad = plugin::GetRadiusData($radiusobj, "radius");
								if(int($object->GetX()) > int($singlenpc->GetX())-$rad && int($object->GetX()) < int($singlenpc->GetX())+$rad &&
								int($object->GetY()) > int($singlenpc->GetY())-$rad && int($object->GetY()) < int($singlenpc->GetY())+$rad)
							  {					
								if(plugin::GetRadiusData($radiusobj, "remove"))
								{
									$triggered = 1;
								}
								if(plugin::GetRadiusData($radiusobj, "spell_id"))
								{
									$client->SpellFinished(plugin::GetRadiusData($radiusobj, "spell_id"), $singlenpc);
								}
								
								if(plugin::GetRadiusData($radiusobj, "spell_id2"))
								{
									$client->SpellFinished(plugin::GetRadiusData($radiusobj, "spell_id2"), $singlenpc);
								}
								
								if(plugin::GetRadiusData($radiusobj, "spell_id3"))
								{
									$client->SpellFinished(plugin::GetRadiusData($radiusobj, "spell_id3"), $singlenpc);
								}
							  }
							  else
							  {
									#	quest::gmsay("No radius!", 15);
							  }
							}
						}
						else
						{
							my @clients = $entity_list->GetClientList();
							foreach my $singleclient (@clients)
							{
								my $rad = plugin::GetRadiusData($radiusobj, "radius");
								if(int($object->GetX()) > int($singleclient->GetX())-$rad && int($object->GetX()) < int($singleclient->GetX())+$rad &&
								int($object->GetY()) > int($singleclient->GetY())-$rad && int($object->GetY()) < int($singleclient->GetY())+$rad)
							  {
								if(plugin::GetRadiusData($radiusobj, "remove"))
								{
									$triggered = 1;
								}
								
								if(plugin::GetRadiusData($radiusobj, "spell_id"))
								{
									$client->SpellFinished(plugin::GetRadiusData($radiusobj, "spell_id"), $singleclient);
								}
								
								if(plugin::GetRadiusData($radiusobj, "spell_id2"))
								{
									$client->SpellFinished(plugin::GetRadiusData($radiusobj, "spell_id2"), $singleclient);
								}
								
								if(plugin::GetRadiusData($radiusobj, "spell_id3"))
								{
									$client->SpellFinished(plugin::GetRadiusData($radiusobj, "spell_id3"), $singleclient);
								}
								
							  }
							  else
							  {
									#quest::gmsay("No radius!", 15);
							  }
							}
						}
						if($triggered)
						{
							$object->Depop();
							quest::stoptimer("WardTimer" . $client->GetEntityVariable("PlacingItemID"));
						}
						
						$client->SetEntityVariable("WardID" . $client->GetEntityVariable("PlacingItemID"), $spawnid);
					}
					else
					{
					$client->Message(15, "You have run out of " . plugin::GetRadiusData($radiusobj, "name"). "!");
					}
				}
			}
			else
			{
				if(!defined($client->GetEntityVariable("PlacingItemID")))
				{
				$client->Message(15, "Please select an item to use in the world before casting this ability.");
				}
				else
				{
					$slot = plugin::check_hasitem_inslot($client, $client->GetEntityVariable("PlacingItemID"));
					if($slot != 65535)
					{
						$client->DeleteItemInInventory($slot, 1, 1);
						
						$spawnid = quest::creategroundobject($client->GetEntityVariable("PlacingItemID"), $client->GetTargetRingX(), $client->GetTargetRingY(), $client->GetTargetRingZ(), $client->GetHeading(), 0);	#62671 original ID
						#quest::gmsay("SpawnID is $spawnid", 15);
						$object = $entity_list->GetObjectByID($spawnid);
						$object->SetSize(($client->GetEntityVariable("PlacingGrowth") / 5) + $client->GetEntityVariable("PlacingSize"));
						$object->SetSolidType(0);
						$object->SetEntityVariable("TreeGrowth", $client->GetEntityVariable("PlacingGrowth") / 5);
						$object->SetEntityVariable("TreeWater", 0);
						$object->SetEntityVariable("TreeDisease", 0);
						$object->SetEntityVariable("TreeSize", $client->GetEntityVariable("PlacingSize"));
						$object->SetEntityVariable("PlacingEffect", (plugin::HasEffect($object->GetItemID()) ? plugin::GetEffectData($object->GetItemID(), "spell_id") : (defined($object->GetEntityVariable("ClickEffect")) ? $object->GetEntityVariable("ClickEffect") : 0)));
						$object->SetEntityVariable("Owner", $client->AccountID());
						plugin::InsertTreeProcedure($object);
						quest::signalwith(10,$spawnid);
					}
					else
					{
						$client->Message(15, "You need to highlight a useable item!");
					}
				}
			}
		}
	}
}
