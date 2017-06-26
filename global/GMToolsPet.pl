#GM Utility Script

$EffectType = 0;

sub EVENT_SPAWN {
	$x = $npc->GetX();
	$y = $npc->GetY();
	$z = $npc->GetZ();
	quest::set_proximity($x - 100, $x + 100, $y - 100, $y + 100, $z - 50, $z + 50);
	quest::settimer("setprox", 2);
	$EffectType = "Spell";
}

sub EVENT_TIMER {

	if ($timer eq "setprox") {
		my $x = $npc->GetX();
		my $y = $npc->GetY();
		my $z = $npc->GetZ();
		quest::clear_proximity();
		quest::set_proximity($x - 100, $x + 100, $y - 100, $y + 100, $z - 50, $z + 50);
	}

}

sub EVENT_SAY {


	if ($text =~/Hail/i) {
		#quest::emote("$qglobals{Dranik_exp}");
	}


	$refresh = quest::saylink("refresh");
	
	if ($status > 20) {
		if($text=~/hail/i) {
			plugin::Whisper("Do you want to [$refresh] my proximity?");
		}

		if($text=~/refresh/i) {
			plugin::Whisper("Proxity should begin auto-refreshing again.");
			quest::settimer("setprox", 2);
		}
	}
}

#Hash of arrays to use for setting up GM location lists to easily get around a zone quickly
# Line Number => [ "<zoneshortname#>", "<loc name>", X, Y, Z ],
%CoordNames = (
	1 => [ "lopingplains1", "Steamfont Zone In", -3514, -1275, 720 ],
	2 => [ "lopingplains2", "Undead Area", 3230, 1310, 400 ],
	3 => [ "lopingplains3", "Goblin Camp", -3115, 975, 705 ],
	4 => [ "lopingplains4", "Bloodmoon Zone In", 96, -1700, 212 ],
	5 => [ "lopingplains5", "Beach Area", -1970, -2890, 39 ],
	6 => [ "lopingplains6", "Beach Cliff Camp", -2980, -1975, 268 ],
	7 => [ "lopingplains7", "Steed Camp", -2410, 2140, 320 ],
	8 => [ "lopingplains8", "Vampire Festival", 1660, 1020, 15 ],
	9 => [ "lopingplains9", "Frost Cave", 275, 485, -35 ],
	10 => [ "lopingplains10", "Secret Treehouse", 2785, 2340, 340 ],
	11 => [ "lopingplains11", "Old Mine", 2990, 275, 335 ],
	12 => [ "lopingplains12", "Gem Mine Top", -2835, -45, 558 ],
	13 => [ "lopingplains13", "Gem Mine Middle", -2685, 145, 375 ],
	14 => [ "lopingplains14", "Gem Mine Bottom", -2690, -720, 195 ],
	15 => [ "hillsofshade1", "Base Camp", -444, 470, 54 ],
	16 => [ "hillsofshade2", "Grave Yard", -1015, 865, 59 ],
	17 => [ "hillsofshade3", "Pirate Camp", -350, 1330, 27 ],
	18 => [ "hillsofshade4", "Docks", -515, 1730, 22 ],
	19 => [ "hillsofshade5", "Pirate Ship", 85, 2770, 36 ],
	20 => [ "hillsofshade6", "Takish Camp", 930, 1385, 44 ],
	21 => [ "hillsofshade7", "Spiroc Island", 820, 2111, 14 ],
	22 => [ "hillsofshade8", "Raviak Camp", 1910, 1210, 90 ],
	23 => [ "hillsofshade9", "Undead Camp", 2000, -30, 8 ],
	24 => [ "hillsofshade10", "Outside Undead Goblins", 1135, -295, 6 ],
	25 => [ "hillsofshade11", "Undead Goblin Boss", 550, -275, -105 ],
	26 => [ "hillsofshade12", "Mushrooms", -1590, -505, -580 ],
	27 => [ "stonehive1", "Zone In", -1282, 0, 43 ],
	28 => [ "stonehive2", "Maze Left", -925, -640, 45 ],
	29 => [ "stonehive3", "Maze Right", -803, 580, 39 ],
	30 => [ "stonehive4", "Balcony", 400, 0, 58 ],
	31 => [ "stonehive5", "Hive Floor 1", -128, 0, 40 ],
	32 => [ "stonehive6", "Hive Floor 2", -77, 0, 287 ],
	33 => [ "stonehive7", "Hive Floor 3", 92, 0, 392 ],
	34 => [ "stonehive8", "Hive Basement", -23, 29, -54 ],
	35 => [ "buriedsea1", "Main Quest Island", 2984, 17, 310 ],
	36 => [ "buriedsea2", "Suncrest (Valcano) Island", -4372, -21, 308 ],
	37 => [ "buriedsea3", "Monkey Rock Island", -2721, -3704, 335 ],
	38 => [ "buriedsea4", "Spiroc Island", 2269, -3315, 309 ],
	39 => [ "buriedsea5", "Center Portal Island", 1202, -200, 305 ],
	40 => [ "buriedsea6", "Siren Island", 3006, 3282, 309 ],
	41 => [ "buriedsea7", "Pirate Fort Island", 1282, 4174, 309 ],
	42 => [ "buriedsea8", "Shipwreck Reef Island", -4349, 3234, 307 ],
	43 => [ "arcstone1", "Zone In", 1606, -224, 137.2 ],
	44 => [ "arcstone2", "Broken Stump", 1113, 1167, 194 ],
	45 => [ "arcstone3", "Knight Rider", 598, 737, 303 ],
	46 => [ "arcstone4", "Tangle", 1402, 328, 96 ],
	47 => [ "arcstone5", "Crimson", 896, -631, 187 ],
	48 => [ "arcstone6", "Center Goat Path", 348, -778, 202 ],
	49 => [ "arcstone7", "Bones", -55, 456, 402 ],
	50 => [ "arcstone8", "Instance zone in", -994, 220, 408 ],
	51 => [ "arcstone9", "New Relic Zone In", -1025, -913, 492 ],
	52 => [ "arcstone10", "Fever Dog Valley", -749, 919, 209 ],
	53 => [ "arcstone11", "Demons", 316, -117, 400 ],
	
);

# The $n below is the number currently being checked in the while loop
# $CoordNames{$n}[0]; is Coordinate name for the array and what the saylink will make you say.
# $CoordNames{$n}[1]; is whatever you want the location name to show as in the actual saylink.
# $CoordNames{$n}[2]; is the X coordinate
# $CoordNames{$n}[3]; is the Y coordinate
# $CoordNames{$n}[4]; is the Z coordinate

%Animlist = (
	1 => ["kick", 1],
	2 => ["pierce", 2],
	3 => ["2h slash", 3],
	4 => ["2h blunt", 4],
	5 => ["2h pierce", 4],
	6 => ["throw", 5],
	7 => ["offhand", 6],
	8 => ["bash", 7],
	9 => ["mainhand", 8],
	10 => ["bow", 9],
	11 => ["swim", 10],
	12 => ["round kick", 11],
	13 => ["get hit", 12],
	14 => ["get hit2", 13],
	15 => ["falling", 14],
	16 => ["drowning", 15],
	17 => ["death", 16],
	18 => ["standby", 17],
	19 => ["standby2", 18],
	20 => ["lunge", 19],
	21 => ["jump", 20],
	22 => ["falling2", 21],
	23 => ["duck walk", 22],
	24 => ["ladder climb", 23],
	25 => ["crouch", 24],
	26 => ["swim2", 25],
	27 => ["idle", 26],
	28 => ["cheer", 27],
	29 => ["disgusted", 28],
	30 => ["wave", 29],
	31 => ["rude", 30],
	32 => ["yawn", 31],
	33 => ["move to side", 33],
	34 => ["ice slide", 35],
	35 => ["kneel", 36],
	36 => ["swim3", 37],
	37 => ["sit", 38],
	38 => ["drumming", 39],
	39 => ["guitar", 40],
	40 => ["blow horn", 41],
	41 => ["cast", 42],
	42 => ["cast2", 43],
	43 => ["cast3", 44],
	44 => ["fly kick", 45],
	45 => ["tiger claw", 46],
	46 => ["eagle strike", 47],
	47 => ["nod yes", 48],
	48 => ["shake no", 49],
	49 => ["plead", 50],
	50 => ["clap", 51],
	51 => ["blush", 52],
	52 => ["chuckle", 54],
	53 => ["cough", 55],
	54 => ["scared", 56],
	55 => ["head tilt", 57],
	56 => ["dance", 58],
	57 => ["disagree", 59],
	58 => ["glare", 60],
	59 => ["peer", 61],
	60 => ["kneel", 62],
	61 => ["laugh", 63],
	62 => ["point", 64],
	63 => ["shrug", 65],
	64 => ["hand raise", 66],
	65 => ["salute", 67],
	66 => ["shiver", 68],
	67 => ["tap foot", 69],
	68 => ["small bow", 70],
	69 => ["smile", 77],
	70 => ["sec pierce", 85],
	71 => ["2h slash2", 87],
	72 => ["combat stance", 112],
	73 => ["ashamed", 129],
	74 => ["cast4", 136],
);

%StanceList = (
	1 => ["stand", "standstance", 0],
	2 => ["sit", "sitstance", 1],
	3 => ["duck", "duckstance", 2],
	4 => ["dead", "deadstance", 3],
	5 => ["kneel", "kneelstance", 4],
);
			
sub EVENT_PROXIMITY_SAY {
	
	$move = quest::saylink("move", 0, "move");
	$animlist = quest::saylink("animation list");
	$stancelist = quest::saylink("stance list");
	$object = quest::saylink("object");
	$seffect = quest::saylink("seffect");
	$aeffect = quest::saylink("aeffect");
	$tint = quest::saylink("tint");
	$objectdepopall = quest::saylink("object depopall");
	$ListObject = quest::saylink("object list");
	$door = quest::saylink("door");
	$ListDoor = quest::saylink("door list");
	$doordepopall = quest::saylink("door depopall");
	
	#$ClientTarget = $client->GetTarget();
	#if (!$ClientTarget || $ClientTarget->IsClient()) {
		#If no npc target yet, set client target to self for saylinks
	#	$client->SetTarget($npc);
	#}
	
	if ($status > 20) {

		@arguments = split(' ',$text);
		if ($arguments[0] ne "object" && $arguments[0] ne "door")
		{

			#Counts each row for the while
			my $count = 0;
			#Counts each element in the Array for the while
			my $n = 1;

			if($text=~/hail/i)
			{
				plugin::Whisper("Options: [$move] [$animlist] [$stancelist] [$object] [$door] [$seffect] [$aeffect]  [$tint]");
			}

			if(!$arguments[1] && $text > 0 && $text < 1000)
			{
				if ($EffectType eq "Appearance")
				{
					my $CurTarget = $client->GetTarget();
					my $EffectTarget = $client;
					if ($CurTarget)
					{
						$EffectTarget = $CurTarget;
					}
					
					plugin::Whisper("Appearance Effect: $text");
					$EffectTarget->SendAppearanceEffect($text);
				}
				if ($EffectType eq "Spell")
				{
					my $CurTarget = $client->GetTarget();
					my $EffectTarget = $client;
					if ($CurTarget)
					{
						$EffectTarget = $CurTarget;
					}
					plugin::Whisper("Spell Effect: $text");
					$EffectTarget->SpellEffect($text);
				}
			}

			if($text=~/move/i)
			{
				#Check each line in the hash
				while ($CoordNames{$n}[0])
				{
					#If the first field of the hash array contains the zone short name
					if ($CoordNames{$n}[0] =~ lc($zonesn) && $CoordNames{$n}[0] ne lc($text))
					{
						$count++;	#Add to the counter for displaying line numbers in the whisper
						#Create the silent saylink
						$CoordNameLink = quest::saylink($CoordNames{$n}[0], 0, $CoordNames{$n}[1]);
						#List each of the possible options for the current zone
						plugin::Whisper("Move Option $count: $zoneln [$CoordNameLink]");
					}
					$n++;	
				}
			}

			if($text=~/animation list/i)
			{
				#Check each line in the hash
				while ($Animlist{$n}[0])
				{
					#Create the silent saylink
					$SkillName = quest::saylink($Animlist{$n}[0]);
					$SkillID = $Animlist{$n}[1];
					#List all animations
					plugin::Whisper("Animation: [$SkillName] ID: $SkillID");
					$n++;	
				}
			}
			
			if($text=~/stance list/i)
			{
				#Check each line in the hash
				while ($StanceList{$n}[0])
				{
					#Create the silent saylink
					$SkillName = quest::saylink($StanceList{$n}[1], 0, $StanceList{$n}[0]);
					$SkillID = $StanceList{$n}[2];
					#List all Stances
					plugin::Whisper("Stance: [$SkillName] ID: $SkillID");
					$n++;	
				}
			}
			
			if ($arguments[0] eq "seffect")
			{
				my $Effect = $arguments[1];
				if ($Effect)
				{
					my $CurTarget = $client->GetTarget();
					my $EffectTarget = $client;
					if ($CurTarget)
					{
						$EffectTarget = $CurTarget;
					}
					plugin::Whisper("Spell Effect: $Effect");
					$EffectTarget->SpellEffect($Effect);
				}
				else
				{
					plugin::Whisper("Default Numeric imput set to display Spell Effects.  Saying 'seffect' followed by the number of the appearance effect you want to display will override default.");
					$EffectType = "Spell";
				}
			}

			if ($arguments[0] eq "aeffect")
			{
				my $Effect = $arguments[1];
				if ($Effect)
				{
					my $CurTarget = $client->GetTarget();
					my $EffectTarget = $client;
					if ($CurTarget)
					{
						$EffectTarget = $CurTarget;
					}
					plugin::Whisper("Appearance Effect: $Effect");
					$EffectTarget->SendAppearanceEffect($Effect);
				}
				else
				{
					plugin::Whisper("Default Numeric imput set to display Appearance Effects.  Saying 'aeffect' followed by the number of the appearance effect you want to display will override default.");
					$EffectType = "Appearance";
				}
			}

			if ($arguments[0] eq "tint")
			{
				my $Red = $arguments[1];
				my $Green = $arguments[2];
				my $Blue = $arguments[3];

				if (defined($Red) && defined($Green) && defined($Blue))
				{
					my $CurTarget = $client->GetTarget();
					my $EffectTarget = $client;
					if ($CurTarget)
					{
						$EffectTarget = $CurTarget;
					}
					plugin::Whisper("Tint: $Red Red, $Green Green, $Blue Blue");
					
					my $Material = $EffectTarget->GetTexture();
					my $Color = 0;
					$Color = ($Red & 0xFF) << 16;
					$Color |= ($Green & 0xFF) << 8;
					$Color |= ($Blue & 0xFF);
					$Color |= 0xFF << 24;
					
					for (my $slot = 0; $slot < 7; $slot++)
					{
						$EffectTarget->WearChange($slot, $Material, $Color);
						#$EffectTarget->SetSlotTint($slot, $Red, $Green, $Blue);
					}
				}
				else
				{
					plugin::Whisper("Command usage is: tint <red> <green> <blue>");
				}
			}
			
			#### Spawn Zone ####
			if ($arguments[0] eq "spawnzone")
			{
				
				# Mir Caves
				#	242123,	# a_Frostmoon_brawler
				#	242126,	# a_Frostmoon_deathpaw
				#	242108,	# a_Frostmoon_handler
				#	242122,	# a_Frostmoon_hunter
				#	242124,	# a_Frostmoon_mystic
				#	242116,	# a_Frostmoon_sentinel
				#	242102,	# a_Frostmoon_sentry
				#	242125,	# a_Frostmoon_spiritcaller
				#	242111,	# a_direwolf_pup
				#	242118,	# a_ferocious_ice_bear
				#	237005,	# a_savage_ice_bear
				#	242103,	# a_trained_direwolf
				#	242117,	# a_vicious_direwolf
				#	242100,	# an_arctic_icespinner
				#	242113,	# an_ice_bear_cub
				#	242106,	# an_icespinner_hatchling
				#	237030,	# an_outcast_E`cian_alchemist
				#	242101,	# snow_rat
			
				plugin::Whisper("Starting Plugin");
				#Usage: plugin::SpawnZone(X, Y, Z, Distance, Variance, Columns, Rows);
				plugin::SpawnZone($x, $y, $z, 50, 20, 40, 40, 400,
					# Guk
					264200,	# A_Blighted_Jin_Master
					264228,	# A_Cursed_Guktan
					264202,	# A_Cursed_Korta_Researcher
					264223,	# A_Dazzling_Oculus
					264220,	# A_Decaying_Yunta_Witchdoctor
					264221,	# A_Doomed_Yunta_Witchdoctor
					264217,	# A_Ghoulish_Dar_Warrior
					264212,	# A_Ghoulish_Darta_Knight
					264219,	# A_Miserable_Jinta_Phantasm
					264213,	# A_Witness_of_Hate_Bonecollector
					264216,	# A_Witness_of_Hate_Seer
					264226,	# A_Witness_of_Hate_assassin
					264214,	# A_Witness_of_Hate_knave
					264207,	# a_cursed_burrower
					264215,	# a_forlorn_Darta_soldier
					264218	# an_unsanctified_Korta_priest	
				);
				plugin::Whisper("Zone Spawned (Update 1)");
			}

			if($text !~ /Hail/i && $text !~ /move/i && $text !~ /animtion list/i && $text !~ /stance list/i && $text !~ /effect/i && $text !~ /tint/i)
			{
				my $ClientTarget = $client->GetTarget();
				$n = 1;			
				while ($StanceList{$n}[0])
				{
					if ($StanceList{$n}[1] eq lc($text))
					{
						if ($ClientTarget && $ClientTarget->IsNPC()) {
							#Create the silent saylink
							$SkillName = quest::saylink($StanceList{$n}[1], 0, $StanceList{$n}[0]);
							$SkillID = $StanceList{$n}[2];
							$ClientTarget->SetAppearance($SkillID);
							#List all animations
							plugin::Whisper("Stance: [$SkillName] ID: $SkillID");
							return;
						}
						else {
							plugin::Whisper("You must target have a Client or NPC target for the Stance.");
							return;
						}
					}
					$n++;
				}
				
				$n = 1;
				#Check each line in the hash
				while ($CoordNames{$n}[0])
				{
					#If the text said is an exact match to the first field of the hash array
					if ($CoordNames{$n}[0] eq lc($text))
					{
						#Set variables for X, Y, Z and location name
						my $NewX = $CoordNames{$n}[2];
						my $NewY = $CoordNames{$n}[3];
						my $NewZ = $CoordNames{$n}[4];
						my $LocName = $CoordNames{$n}[1];
						plugin::Whisper("Moving us to $zoneln $NewX, $NewY, $NewZ - $LocName");
						#Move the Client and NPC to the new requested location
						quest::movepc($zoneid, $NewX, $NewY, $NewZ);
						$npc->GMMove($NewX, $NewY, $NewZ);
						quest::clear_proximity();
						quest::set_proximity($NewX - 100, $NewX + 100, $NewY - 100, $NewY + 100, $NewZ - 50, $NewZ + 50);
						return;
					}
					$n++;
				}

				#Check the animation list for matching results as well
				$n = 1;
				while ($Animlist{$n}[0])
				{
					if ($Animlist{$n}[0] eq lc($text))
					{
						if ($ClientTarget && ($ClientTarget->IsNPC() || $ClientTarget->IsClient())) {
							#Create the silent saylink
							$SkillName = quest::saylink($Animlist{$n}[0]);
							$SkillID = $Animlist{$n}[1];
							#Note that the first field that is hard set to 10 here is actually the speed that the animation will use.
							$ClientTarget->DoAnim(10, $SkillID);
							#List all animations
							plugin::Whisper("Animation: [$SkillName] ID: $SkillID");
							return;
						}
						else {
							plugin::Whisper("You must target have a Client or NPC target for the animation.");
							return;
						}
					}
					$n++;
				}
			}
		}
		else
		{
			if ($arguments[0] eq "object")
			{
				if (!$arguments[1])
				{
					$client->Message(15, "Object Creation Commandlist");
					$client->Message(15, "=============");
					$client->Message(15, "$ListObject");
					$client->Message(15, "object dbdel [object_id]");
					$client->Message(15, "object dbsave [object_id]");
					$client->Message(15, "object create fromitem [itemid]");
					$client->Message(15, "object create frommodel [model] [bool exactname = 0]");
					$client->Message(15, "object set [object_id] location [x] [y] [z]");
					$client->Message(15, "object set [object_id] model [model]");
					$client->Message(15, "object set [object_id] type [0-255]");
					$client->Message(15, "object view [object_id]");
					$client->Message(15, "$objectdepopall");
					$client->Message(15, "=============");
					$client->Message(15, "End of list");
					return;
				}
			
				if ($arguments[1] eq "list")
				{
					my @objectList = $entity_list->GetObjectList();
					$client->Message(15, "Object list: ");
					$client->Message(15, "=============");
					foreach my $object (@objectList)
					{
						$client->Message(15, GetObjectInfo($object));
					}
					$client->Message(15, "=============");
					$client->Message(15, "End of list");
				}
				
				if ($arguments[1] eq "view")
				{
					$obj = $entity_list->GetObjectByID($arguments[2]);
					if (!$obj)
					{
						$client->Message(15, "Object with ID ".$arguments[2]." does not exist!");
					}
					else {
						$client->Message(15, GetObjectInfo($obj));
					}
				}
				
				if ($arguments[1] eq "create")
				{
					if ($arguments[2] eq "frommodel")
					{
						if ($arguments[4])
						{
							$model = $arguments[3];
						}
						else
						{
							$model = BuildObjectModel($arguments[3]);
						}
						$entityId = quest::creategroundobjectfrommodel($model, $x, $y, $z, $h);
						$client->Message(15, "Object created.");
						$obj = $entity_list->GetObjectByID($entityId);
						$client->Message(15, GetObjectInfo($obj));
					}
					if ($arguments[2] eq "fromitem")
					{
						$itemid = $arguments[3];
						$entityId = quest::creategroundobject($itemid, $x, $y, $z, $h);
						$client->Message(15, "Object created.");
						$obj = $entity_list->GetObjectByID($entityId);
						$client->Message(15, GetObjectInfo($obj));
					}
				}
				
				if ($arguments[1] eq "set")
				{
					$entityId = $arguments[2];
					$obj = $entity_list->GetObjectByID($arguments[2]);
					if (!$obj)
					{
						$client->Message(15, "Object with ID ".$arguments[2]." does not exist!");
					}
					else
					{
						my $updated = 0;
						if ($arguments[3] eq "location")
						{
							if ($arguments[6] eq "")
							{
								$client->Message(15, "Usage: set [ObjectID] location x y z");
							}
							else
							{
								$obj->SetX($arguments[4]);
								$obj->SetY($arguments[5]);
								$obj->SetZ($arguments[6]);
								$updated = 1;
							}
						}
						if ($arguments[3] == "model")
						{
							if ($arguments[4] eq "")
							{
								$client->Message(15, "Usage: set [ObjectID] model modelname");
							}
							else
							{
								$obj->SetModelName(BuildObjectModel($arguments[4]));
								$updated = 1;
							}
						}
						if ($arguments[3] == "type")
						{
							if ($arguments[4] eq "")
							{
								$client->Message(15, "Usage: set [ObjectID] type [0-255]");
							}
							else
							{
								$obj->SetType($arguments[4]);
								$updated = 1;
							}
						}
						
						
						if ($updated)
						{
							$client->Message(15, "Object Updated.");
							$client->Message(15, GetObjectInfo($obj));
						}
					}
				}
				
				if ($arguments[1] eq "dbsave")
				{
					$entityId = $arguments[2];
					$obj = $entity_list->GetObjectByID($entityId);
					if (!$obj)
					{
						$client->Message(15, "Object with ID ".$entityId." does not exist!");
					}
					else
					{
						$newid = $obj->VarSave();
						$client->Message(15, "Object saved to database: ID $newid");
						$client->Message(15, GetObjectInfo($obj));
					}
				}	
				if ($arguments[1] eq "dbdel")
				{
					$entityId = $arguments[2];
					$obj = $entity_list->GetObjectByID($arguments[2]);
					if (!$obj)
					{
						$client->Message(15, "Object with ID ".$arguments[2]." does not exist!");
					}
					else
					{
						$newid = $obj->Delete();
						$client->Message(15, "Object deleted from database");
						$client->Message(15, GetObjectInfo($obj));
					}
				}
				if ($arguments[1] eq "depoptest")
				{
					my @ObjDepop = $entity_list->GetObjectList();
					foreach $ent (@ObjDepop)
					{
						my $ModelName = $ent->GetModelName();
						if ($ModelName eq "IT66_ACTORDEF")
						{
							$ent->Depop();
						}
					}
				}
				if ($arguments[1] eq "depopall")
				{
					my @ObjDepop = $entity_list->GetObjectList();
					foreach $ent (@ObjDepop)
					{
						$ent->Depop();
					}
				}
				if ($arguments[1] eq "test")
				{
					# quest::creategroundobject(itemid, x, y, z, heading) now returns object ID
					# quest::creategroundobjectfrommodel(modelname, x, y, z, heading, [type])
					#
					# GetObjectByDBID(id)
					# GetObjectByID(id)
					# GetObjectList()
					#
					# IsGroundSpawn()
					# Close()
					# Delete(reset_state=0)
					# StartDecay()
					# DeleteItem(index)
					# IsObject()
					# Save()
					# SetID(set_id)
					# ClearUser()
					# DBID()
					# GetID()
					# GetX()
					# GetY()
					# GetZ()
					# GetHeading()
					# VarSave()
					# GetType()
					# SetType(type)
					# GetIcon()
					# SetIcon(icon)
					# GetItemID()
					# SetItemID(itemid)
					# SetLocation(x, y, z)
					# SetX(XPos)
					# SetY(YPos)
					# SetZ(ZPos)
					# SetHeading(heading)
					# SetModelName(name)
					# GetModelName()
					# Repop()
					# Depop()
					
					my @ObjDepop = $entity_list->GetObjectList();
					foreach $ent (@ObjDepop)
					{
						my $ModelName = $ent->GetModelName();
						if ($ModelName eq "IT66_ACTORDEF")
						{
							$ent->Depop();
						}
					}
					
					# Create all of the temporary objects
					for ($i = 0; $i < 28; $i++)
					{
						quest::creategroundobjectfrommodel("IT66_ACTORDEF", 0, 0, 0, 0, 17);
					}

					#plugin::Debug("Object $CreateObjID ");

					my $ClientH = $client->GetHeading();
					my $NewH = $ClientH;
					
					my @ObjList = $entity_list->GetObjectList();
					foreach $ent (@ObjList)
					{
						my $ModelName = $ent->GetModelName();
						if ($ModelName eq "IT66_ACTORDEF")
						{
							my $ObjectID = $ent->GetID();
							$ent->Close();
							$ent->SetType(17);
							$ent->SetIcon(1115);
							my $ObjX = $ent->GetX();
							my $ObjY = $ent->GetY();
							#my $ObjZ = $ent->GetZ();
							my $ObjH = $ent->GetHeading();
							$NewH = $NewH + 9;
							my $ObjZ = $client->FindGroundZ($ObjX + 5, $ObjY + 5, 10);
							my @DestArray = plugin::CalcDestFromHeading($NewH, 20, $client, 25);
							$ent->SetLocation($DestArray[0], $DestArray[1], $DestArray[2]);
							
							#$ent->SetLocation($ObjX + 5, $ObjY + 5, $ObjZ);
							#$ent->SetHeading($ObjH);
							$ent->SetHeading($NewH);
							$ent->Repop();
							if ($client)
							{
								#my $ClientH = $client->GetHeading();
								#$ent->SetHeading($ClientH);
							}
							#my $ModelName = $ent->GetModelName();
							#my $ModelName = $ent->SetModelName("IT66");
							#plugin::Whisper("Object ID: $ObjectID [ $ModelName ]");
						}
					}
				}
			}
			
			# ============================================ #
		
			if ($arguments[0] eq "door")
			{
				if (!$arguments[1])
				{
					$client->Message(15, "Door Creation Commandlist");
					$client->Message(15, "=============");
					$client->Message(15, "$ListDoor");
					$client->Message(15, "door create [model] [bool exactname = 0]");
					$client->Message(15, "door dbdel [door_id]");
					$client->Message(15, "door dbsave [door_id]");
					$client->Message(15, "door set [door_id] location [x] [y] [z]");
					$client->Message(15, "door set [door_id] model [model] [bool exactname = 0]");
					$client->Message(15, "door set [door_id] type [0-255]");
					$client->Message(15, "door view [door_id]");
					$client->Message(15, "$doordepopall");
					$client->Message(15, "=============");
					$client->Message(15, "End of list");
					return;
				}
			
				if ($arguments[1] eq "list")
				{
					my @DoorList = $entity_list->GetDoorsList();
					$client->Message(15, "Door list: ");
					$client->Message(15, "=============");
					foreach my $door (@DoorList)
					{
						$client->Message(15, GetDoorInfo($door));
					}
					$client->Message(15, "=============");
					$client->Message(15, "End of list");
				}
				
				if ($arguments[1] eq "view")
				{
					$door = $entity_list->GetDoorsByID($arguments[2]);
					if (!$door)
					{
						$client->Message(15, "Door with ID ".$arguments[2]." does not exist!");
					}
					else {
						$client->Message(15, GetDoorInfo($door));
					}
				}
				
				if ($arguments[1] eq "create")
				{
					#createdoor(modelname, x, y, z, heading, [type], [size])
					if ($arguments[3])
					{
						$model = $arguments[2];
					}
					else
					{
						$model = BuildObjectModel($arguments[2]);
					}
					$entityId = quest::createdoor($model, $x, $y, $z, $h);
					$client->Message(15, "Door $entityId created.");
					$door = $entity_list->GetDoorsByID($entityId);
					$client->Message(15, GetDoorInfo($door));
				}
				
				if ($arguments[1] eq "set")
				{
					$entityId = $arguments[2];
					$door = $entity_list->GetDoorsList($arguments[2]);
					if (!$door)
					{
						$client->Message(15, "Door with ID ".$arguments[2]." does not exist!");
					}
					else
					{
						my $updated = 0;
						if ($arguments[3] eq "location")
						{
							if ($arguments[6] eq "")
							{
								$client->Message(15, "Usage: set [DoorID] location x y z");
							}
							else
							{
								$door->SetX($arguments[4]);
								$door->SetY($arguments[5]);
								$door->SetZ($arguments[6]);
								$updated = 1;
							}
						}
						if ($arguments[3] == "model")
						{
							if ($arguments[4] eq "")
							{
								$client->Message(15, "Usage: set [DoorID] model modelname [bool exactname = 0]");
							}
							else
							{
								if ($arguments[5])
								{
									$door->SetModelName($arguments[4]);
									$updated = 1;
								}
								else
								{
									$door->SetModelName(BuildObjectModel($arguments[4]));
									$updated = 1;
								}

							}
						}
						if ($arguments[3] == "opentype")
						{
							if ($arguments[4] eq "")
							{
								$client->Message(15, "Usage: set [DoorID] opentype [0-255]");
							}
							else
							{
								$door->SetOpenType($arguments[4]);
								$updated = 1;
							}
						}
						
						
						if ($updated)
						{
							$client->Message(15, "Door Updated.");
							$client->Message(15, GetDoorInfo($door));
						}
					}
				}
				
				if ($arguments[1] eq "dbsave")
				{
					$entityId = $arguments[2];
					#$door = $entity_list->GetObjectByID($entityId);
					$door = 0;
					my @DoorList = $entity_list->GetDoorsList();
					foreach $ent (@DoorList)
					{
						if ($ent->GetID() == $entityId)
						{
							$door = $ent;
						}
					}
					if (!$door)
					{
						$client->Message(15, "Door with ID ".$entityId." does not exist!");
					}
					else
					{
						$newid = $door->CreateDatabaseEntry();
						$client->Message(15, "Door saved to database: ID $newid");
						$client->Message(15, GetDoorInfo($door));
					}
				}	
				if ($arguments[1] eq "dbdel")
				{
					$entityId = $arguments[2];
					#$door = $entity_list->GetObjectByID($arguments[2]);
					$door = 0;
					if (!$door)
					{
						$client->Message(15, "Door with ID ".$arguments[2]." does not exist!");
					}
					else
					{
						#$newid = $door->Delete();
						#$client->Message(15, "Door deleted from database");
						#$client->Message(15, GetDoorInfo($door));
						$client->Message(15, "This function does not work for doors yet.");
					}
				}
				if ($arguments[1] eq "depopall")
				{
					my @DoorList = $entity_list->GetDoorsList();
					foreach $ent (@DoorList)
					{
						$ent->Depop();
					}
					$client->Message(15, "Depopped all doors.");
				}
				if ($arguments[1] eq "test")
				{
					$model = $arguments[2];
					quest::createdoor($model, 0, 0, $z, 0);
					quest::createdoor($model, 0, 0, $z, 64);
					quest::createdoor($model, 0, 0, $z, 128);
					quest::createdoor($model, 0, 0, $z, 192);
					$client->Message(15, "Test Doors Created.");
				}
			}
		}
	}
	
}

sub GetObjectInfo {
	my $object = $_[0];
	my $seperator = " || ";
	return "Object: ".
	"id: ".$object->GetID()
	.$seperator.
	 ($object->GetDBID() == 0 ? "not in db" : "dbid: ".$object->GetDBID())
	.$seperator.
	"type: ".$object->GetType()
	.$seperator.
	"model: ".$object->GetModelName()
	.$seperator.
	"location x,y,z, heading: ".int($object->GetX()).', '.int($object->GetY()).', '.int($object->GetZ()).", ".int($object->GetHeading())
	.$seperator.
	"icon: ".$object->GetIcon()
	.$seperator.
	"groundspawn: ".($object->IsGroundSpawn() ? "yes" : "no")
	;
}

sub GetDoorInfo {
	my $Door = $_[0];
	my $seperator = " || ";
	return "Door: ".
	"ID: ".$Door->GetID()
	.$seperator.
	 ($Door->GetDoorDBID() == 0 ? "Not in DB" : "DBID: ".$Door->GetDoorDBID())
	.$seperator.
	"Model: ".$Door->GetModelName()
	.$seperator.
	"Location x,y,z, heading: ".int($Door->GetX()).', '.int($Door->GetY()).', '.int($Door->GetZ()).", ".int($Door->GetHeading())
	.$seperator.
	"KeyID: ".$Door->GetKeyItem()
	.$seperator.
	"Incline: ".$Door->GetIncline()
	.$seperator.
	"size: ".$Door->GetSize()
	;
}

# For doors or objects
sub BuildObjectModel {
	my $model = $_[0];
	if (substr($model,length($model)-9,9) ne "_ACTORDEF")
	{
		$model = $model . "_ACTORDEF";
	}
	return $model;
}
