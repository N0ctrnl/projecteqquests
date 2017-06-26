use Time::Piece;

sub EVENT_SIGNAL{	
	my $client = $entity_list->GetClientByID($signal);
	my $doorid = $client->GetEntityVariable("HouseInteractID");
	my $command = $client->GetEntityVariable("DoorCommand");
	if($command =~ /Info/i)
	{
		my $door = $entity_list->GetDoorsByDBID($doorid);
		if(defined($door) && defined($client))
		{
			my $unix_timestamp = $npc->GetEntityVariable("DUE" . $door->GetDoorDBID());
			my ($Ss,$MM,$Hh,$Dd,$Mm,$Yy) = localtime($unix_timestamp);
			$Mm += 1;
			$Yy += 1900;
			my $dt = sprintf("%04d-%02d-%02d %02d:%02d:%02d", $Yy,$Mm,$Dd, $Hh,$MM,$Ss);
			#plugin::UpdateHouseProcedure($door, $npc);
			$client->Message(15, "This is a house owned by " . $npc->GetEntityVariable("ONAME" . $door->GetDoorDBID()) . ". It has an initial cost of " . $npc->GetEntityVariable("COST" . $door->GetDoorDBID()) . " and it has an upkeep of " . $npc->GetEntityVariable("UPKEEP" . $door->GetDoorDBID()) . " platinum per week, and a due date of " . $dt . ".");
			#$client->Message(15, "DBID: " . $door->GetDoorDBID());
			#$client->Message(15, "X: " . $npc->GetEntityVariable("X" . $door->GetDoorDBID()));
			#$client->Message(15, "Y: " . $npc->GetEntityVariable("Y" . $door->GetDoorDBID()));
			#$client->Message(15, "Z: " . $npc->GetEntityVariable("Z" . $door->GetDoorDBID()));
			#$client->Message(15, "RAD: " . $npc->GetEntityVariable("RAD" . $door->GetDoorDBID()));
		}
	}
	if($command =~ /PlaceItem/i)
	{
		if(!defined ($doorid))
		{
			$client->Message(13, "Please select a building frame that you own by clicking on it to place that object!");
		}
		else
		{
			my $door = $entity_list->GetDoorsByDBID($doorid);
			if(defined($door) && defined($client))
			{
				if(!defined($client->GetEntityVariable("PlacingItemID")))
				{
					$client->Message(15, "Please select an item to use in the world before casting this ability.");
				}
				else
				{
					my $doorx = $npc->GetEntityVariable("X" . $door->GetDoorDBID());
					my $doory = $npc->GetEntityVariable("Y" . $door->GetDoorDBID());
					my $doorz = $npc->GetEntityVariable("Z" . $door->GetDoorDBID());
					my $rad = $npc->GetEntityVariable("RAD" . $door->GetDoorDBID());
					my $ownerid = $npc->GetEntityVariable("Owner" . $door->GetDoorDBID());
					#quest::gmsay($doorx, 15);
					if(int($client->GetTargetRingX()) > $doorx-$rad && int($client->GetTargetRingX()) < $doorx+$rad &&
					   int($client->GetTargetRingY()) > $doory-$rad && int($client->GetTargetRingY()) < $doory+$rad &&
					   $ownerid == $client->AccountID())
					{
					my $slot = plugin::check_hasitem_inslot($client, $client->GetEntityVariable("PlacingItemID"));
						if($slot != 65535)
						{
							$client->DeleteItemInInventory($slot, 1, 1);
							
							$spawnid = quest::creategroundobject($client->GetEntityVariable("PlacingItemID"), $client->GetTargetRingX(), $client->GetTargetRingY(), $client->GetTargetRingZ(), $client->GetHeading(), 0);	#62671 original ID
							#quest::gmsay("SpawnID is $spawnid", 15);
							$object = $entity_list->GetObjectByID($spawnid);
							$object->SetSize(($client->GetEntityVariable("PlacingGrowth") / 5) + $client->GetEntityVariable("PlacingSize"));
							$object->SetSolidType(0);
							$object->SetEntityVariable("TreeGrowth", $client->GetEntityVariable("PlacingGrowth"));
							$object->SetEntityVariable("TreeWater", 0);
							$object->SetEntityVariable("TreeDisease", 0);
							$object->SetEntityVariable("TreeSize", $client->GetEntityVariable("PlacingSize"));
							$object->SetEntityVariable("PlacingEffect", (plugin::HasEffect($object->GetItemID()) ? plugin::GetEffectData($object->GetItemID(), "spell_id") : (defined($object->GetEntityVariable("ClickEffect")) ? $object->GetEntityVariable("ClickEffect") : 0)));
							$object->SetEntityVariable("Owner", $client->AccountID());
							plugin::InsertTreeProcedure($object);
							quest::signalwith(1000503,$spawnid);
						}
					}
					else
					{
						$client->Message(13, "You do not have permission to place that item here. If this is your house, click on the outside lines to activate build mode.");
					}
				}
			}
			else
			{
				$client->Message(13, "Please select a building frame that you own by clicking on it to place that object!");
			}
		}
	}
	
	elsif($command =~ /HarvestItem/i)
	{
		if(defined $doorid)
		{
			my $door = $entity_list->GetDoorsByDBID($doorid);
			my $object = $entity_list->GetObjectByID($client->GetEntityVariable("TreeID"));
			if(defined($object) && defined($door) && defined($client))
			{
				my $doorx = $npc->GetEntityVariable("X" . $door->GetDoorDBID());
				my $doory = $npc->GetEntityVariable("Y" . $door->GetDoorDBID());
				my $doorz = $npc->GetEntityVariable("Z" . $door->GetDoorDBID());
				my $rad = $npc->GetEntityVariable("RAD" . $door->GetDoorDBID());
				my $ownerid = $npc->GetEntityVariable("Owner" . $door->GetDoorDBID());
			
				if((int($object->GetX()) > $doorx-$rad && int($object->GetX()) < $doorx+$rad &&
				   int($object->GetY()) > $doory-$rad && int($object->GetY()) < $doory+$rad &&
				   $ownerid == $client->AccountID() && $npc->GetEntityVariable("DUE" . $door->GetDoorDBID()) >= time() && $npc->GetEntityVariable("DUE" . $door->GetDoorDBID()) != 0))
				{
					if(plugin::IsTree($object->GetItemID()))
					{
						$randomroll = plugin::RandomRange($object->GetEntityVariable("TreeGrowth") / 20, $object->GetEntityVariable("TreeGrowth") / 5);
						$randomreturn = plugin::RandomRange(0, 200);
						if($randomroll < 1)
						{
							$client->Message(15, "You feel like you're a poor excuse for a gardener. You get your seed back.");
							$client->SummonItem($object->GetItemID(), 1);
						}
						else
						{
							my $rare = 0;
							if(plugin::GetTreeData($object->GetItemID(), "rareresult"))
							{
								if($randomreturn < plugin::GetTreeData($object->GetItemID(), "rarechance") * 2)
								{	
									$client->Message(15, "[RARE] You find $randomroll " . plugin::GetTreeData($object->GetItemID(), "raretext") . " in your yield!");
									$client->SummonItem(plugin::GetTreeData($object->GetItemID(), "rareresult"), $randomroll);
									$rare = 1;
								}
							}
							if(plugin::GetTreeData($object->GetItemID(), "uncommonresult") && $rare == 0)
							{
								if($randomreturn < plugin::GetTreeData($object->GetItemID(), "uncommonchance") * 2)
								{	
									$client->Message(15, "[UNCOMMON] You find $randomroll " . plugin::GetTreeData($object->GetItemID(), "uncommontext") . " in your yield!");
									$client->SummonItem(plugin::GetTreeData($object->GetItemID(), "uncommonresult"), $randomroll);
									$rare = 1;
								}
							}
							
							if($rare == 0)
							{
								$client->Message(15, "[COMMON] You harvest the " . plugin::GetTreeData($object->GetItemID(), "plant") .". You gain $randomroll " . plugin::GetTreeData($object->GetItemID(), "text") . " from your yield.");
								$client->SummonItem(plugin::GetTreeData($object->GetItemID(), "result"), $randomroll);
							}
							
							if($object->GetEntityVariable("TreeGrowth") >= $randomreturn)
							{
								$client->Message(15, "You dig amongst the dirt and find an " . plugin::GetTreeData($object->GetItemID(), "plant") .  " Seed! It's a miracle of growth!");
								$client->SummonItem($object->GetItemID(), 1);
							}
						}
						plugin::DeleteTreeProcedure($object);
					}
					else
					{
						$client->Message(13, "That's not a plant, doofus.");
					}
				}
				else
				{
					$client->Message(13, "Hmm, you think it'd be wise to not mess with another person's plant..");
				}
			}
			else
			{
					$client->Message(13, "Please select a plant to harvest that is on your property. Remember to activate build mode if it's your plant by clicking on the frame!");
			}
		}
		else
		{
			$client->Message(13, "Please select a building frame that you own by clicking on it to harvest that object!");
		}
	}
	
	elsif($command =~ /PickupItem/i)
	{
		if(defined ($doorid))
		{
			my $door = $entity_list->GetDoorsByDBID($doorid);
			my $object = $entity_list->GetObjectByID($client->GetEntityVariable("TreeID"));
			if(defined($object) && defined($door) && defined($client))
			{
				my $doorx = $npc->GetEntityVariable("X" . $door->GetDoorDBID());
				my $doory = $npc->GetEntityVariable("Y" . $door->GetDoorDBID());
				my $doorz = $npc->GetEntityVariable("Z" . $door->GetDoorDBID());
				my $rad = $npc->GetEntityVariable("RAD" . $door->GetDoorDBID());
				my $ownerid = $npc->GetEntityVariable("Owner" . $door->GetDoorDBID());
				if((int($object->GetX()) > $doorx-$rad && int($object->GetX()) < $doorx+$rad &&
				   int($object->GetY()) > $doory-$rad && int($object->GetY()) < $doory+$rad &&
				   $ownerid == $client->AccountID() && $npc->GetEntityVariable("DUE" . $door->GetDoorDBID()) >= time() && $npc->GetEntityVariable("DUE" . $door->GetDoorDBID()) != 0))
				{
						if(!plugin::IsTree($object->GetItemID()))
						{
							$client->Message(15, "You pick up the house item laying on the ground. " . $object->GetItemID());
							$client->SummonItem($object->GetItemID(), 1);
							plugin::DeleteTreeProcedure($object);
						}
						else
						{
							$client->Message(13, "That's a plant. Try harvesting it.");
						}
				}
				else
				{
				
						$client->Message(13, "Hmm, you think it'd be wise to not mess with another person's property..");
				}
			}
			else
			{
					$client->Message(13, "Please select an object to pick up that is on your property. Remember to activate build mode if it's your plant by clicking on the frame!");
			}
		}
		else
		{
			$client->Message(13, "Please select a building frame that you own by clicking on it to pick up that object!");
		}
	}
	
	elsif($command =~ /BuyHouse/i)
	{
		if(defined $doorid)
		{
			my $door = $entity_list->GetDoorsByDBID($doorid);
			if(defined($door) && defined($client))
			{
				if($npc->GetEntityVariable("DUE" . $door->GetDoorDBID()) >= time() && $npc->GetEntityVariable("DUE" . $door->GetDoorDBID()) != 0 && $npc->GetEntityVariable("Owner" . $door->GetDoorDBID()) > 0)
				{
					$client->Message(13, "You can't buy a house that belongs to someone else and isn't past due!");
				}
				else
				{
					my $unix_timestamp = $npc->GetEntityVariable("DUE" . $door->GetDoorDBID());
					my ($Ss,$MM,$Hh,$Dd,$Mm,$Yy) = localtime($unix_timestamp);
					$Mm += 1;
					$Yy += 1900;
					my $dt = sprintf("%04d-%02d-%02d %02d:%02d:%02d", $Yy,$Mm,$Dd, $Hh,$MM,$Ss);
					#plugin::UpdateHouseProcedure($door, $npc);
					$client->Message(15, "This is a house owned by " . $npc->GetEntityVariable("ONAME" . $door->GetDoorDBID()) . ". It has an initial cost of " . $npc->GetEntityVariable("COST" . $door->GetDoorDBID()) . " and it has an upkeep of " . $npc->GetEntityVariable("UPKEEP" . $door->GetDoorDBID()) . " platinum per week, and a due date of " . $dt . ".");
					$client->Message(15, "Once you buy a house, you MUST pay upkeep on it or else risk other players looting your belongings from your plot. Are you SURE you wish to buy a house?");
					$client->Message(15, quest::saylink("#house purchase", 1, "::YES, I am sure. Sign the lease"));
				}
			}
		}
		else
		{
			$client->Message(13, "Please select a building frame by clicking on it to buy a house!");
		}
	}
	elsif($command =~ /PurchaseHouse/i)
	{
		if(defined($doorid))
		{
			my $door = $entity_list->GetDoorsByDBID($doorid);
			if(defined($door) && defined($client))
			{
			
				#quest::gmsay($npc->GetEntityVariable("COST" . $door->GetDoorDBID()) * 10000, 15);
				if($npc->GetEntityVariable("DUE" . $door->GetDoorDBID()) >= time() && $npc->GetEntityVariable("DUE" . $door->GetDoorDBID()) != 0 && $npc->GetEntityVariable("Owner" . $door->GetDoorDBID()) > 0)
				{
					$client->Message(13, "You can't buy a house that belongs to someone else and isn't past due!");
				}
				elsif($client->TakeMoneyFromPP($npc->GetEntityVariable("COST" . $door->GetDoorDBID()) * 1000, 1))
				{
					$npc->SetEntityVariable("Owner" . $door->GetDoorDBID(), $client->AccountID());
					$npc->SetEntityVariable("ONAME" . $door->GetDoorDBID(), $client->GetCleanName());
					$npc->SetEntityVariable("DUE" . $door->GetDoorDBID(), time() + 604800);
					
					#Floating name
					my $tmpid = $npc->GetEntityVariable("MOBID" . $door->GetDoorDBID());
					my $tmpmob = $entity_list->GetMobByID($tmpid);
					if(defined($tmpmob))
					{
						$tmpmob->Depop();
					}
					$tmpid = quest::spawn2(1000509, 0, 0, 
					$npc->GetEntityVariable("X" . $door->GetDoorDBID()),
					$npc->GetEntityVariable("Y" . $door->GetDoorDBID()),
					$npc->GetEntityVariable("Z" . $door->GetDoorDBID()),
					$npc->GetEntityVariable("H" . $door->GetDoorDBID()));
					$npc->SetEntityVariable("MOBID" . $door->GetDoorDBID(), $tmpid);
					$tmpmob = $entity_list->GetMobByID($tmpid);
					$tmpmob->TempName($npc->GetEntityVariable("ONAME" . $door->GetDoorDBID()) . "'s_House"); 
					plugin::UpdateHouseProcedure($door, $npc);
					$client->Message(15, "You are now the brand new owner of a fine house!");
				}
				else
				{
					$client->Message(13, "You cannot afford this house!");
				}
			}
		}
		else
		{
			$client->Message(13, "Please select a building frame by clicking on it to purchase a house!");
		}
	}
	
	elsif($command =~ /SellHouse/i)
	{
		if(defined($doorid))
		{
			my $door = $entity_list->GetDoorsByDBID($doorid);
			if(defined($door) && defined($client))
			{
				if($npc->GetEntityVariable("Owner" . $door->GetDoorDBID()) != $client->AccountID())
				{
					$client->Message(13, "You can't sell a house that belongs to someone else!");
				}
				else
				{
					my $unix_timestamp = $npc->GetEntityVariable("DUE" . $door->GetDoorDBID());
					my ($Ss,$MM,$Hh,$Dd,$Mm,$Yy) = localtime($unix_timestamp);
					$Mm += 1;
					$Yy += 1900;
					my $dt = sprintf("%04d-%02d-%02d %02d:%02d:%02d", $Yy,$Mm,$Dd, $Hh,$MM,$Ss);
					#plugin::UpdateHouseProcedure($door, $npc);
					$client->Message(15, "This is a house owned by " . $npc->GetEntityVariable("ONAME" . $door->GetDoorDBID()) . ". It has an initial cost of " . $npc->GetEntityVariable("COST" . $door->GetDoorDBID()) . " and it has an upkeep of " . $npc->GetEntityVariable("UPKEEP" . $door->GetDoorDBID()) . " platinum per week, and a due date of " . $dt . ".");
					$client->Message(15, "Once you sell a house, all property on it at the time of salebecomes free-for-all. You must be sure you have rid your house of all belongings. You will only keep 10\%% of the sale price in platinum. Are you SURE you wish to do this?");
					$client->Message(15, quest::saylink("#house relinquish", 1, "::YES, I am sure. Sign the contract to sell my house."));
				}
			}
		}
		else
		{
			$client->Message(13, "Please select a building frame that you own by clicking on it to sell a house!");
		}
	}
	elsif($command =~ /RelinquishHouse/i)
	{
		if(defined $doorid)
		{
			my $door = $entity_list->GetDoorsByDBID($doorid);
			if(defined($door) && defined($client))
			{
			
				#quest::gmsay($npc->GetEntityVariable("COST" . $door->GetDoorDBID()) * 10000, 15);
				if($npc->GetEntityVariable("Owner" . $door->GetDoorDBID()) != $client->AccountID())
				{
					$client->Message(13, "You can't sell a house that belongs to someone else!");
				}
				else
				{
					$client->AddMoneyToPP(0, 0, 0, int($npc->GetEntityVariable("COST" . $door->GetDoorDBID()) / 90), 1);
					$npc->SetEntityVariable("Owner" . $door->GetDoorDBID(), 0);
					$npc->SetEntityVariable("ONAME" . $door->GetDoorDBID(), "No One");
					$npc->SetEntityVariable("DUE" . $door->GetDoorDBID(), 0);
					#Floating name
					my $tmpid = $npc->GetEntityVariable("MOBID" . $door->GetDoorDBID());
					my $tmpmob = $entity_list->GetMobByID($tmpid);
					if(defined($tmpmob))
					{
						$tmpmob->Depop();
					}
					$tmpid = quest::spawn2(1000509, 0, 0, 
					$npc->GetEntityVariable("X" . $door->GetDoorDBID()),
					$npc->GetEntityVariable("Y" . $door->GetDoorDBID()),
					$npc->GetEntityVariable("Z" . $door->GetDoorDBID()),
					$npc->GetEntityVariable("H" . $door->GetDoorDBID()));
					$npc->SetEntityVariable("MOBID" . $door->GetDoorDBID(), $tmpid);
					$tmpmob = $entity_list->GetMobByID($tmpid);
					$tmpmob->TempName($npc->GetEntityVariable("ONAME" . $door->GetDoorDBID()) . "'s_House"); 
					
					plugin::UpdateHouseProcedure($door, $npc);
					$client->Message(15, "You relinquish your house and get " . int($npc->GetEntityVariable("COST" . $door->GetDoorDBID()) / 90) . " platinum pieces back from the process.");
				}
			}
		}
		else
		{
			$client->Message(13, "Please select a building frame that you own by clicking on it to sell a house!");
		}
	}
	elsif($command =~ /PayRent/i)
	{
		if(defined($doorid))
		{
			my $door = $entity_list->GetDoorsByDBID($doorid);
			if(defined($door) && defined($client))
			{
				my $oid = $npc->GetEntityVariable("Owner" . $door->GetDoorDBID());
				if($oid)
				{
					$oname = $npc->GetEntityVariable("ONAME" . $door->GetDoorDBID());
					if($client->TakeMoneyFromPP($npc->GetEntityVariable("UPKEEP" . $door->GetDoorDBID()) * 1000, 1))
					{
						$npc->SetEntityVariable("DUE" . $door->GetDoorDBID(), time() + ($npc->GetEntityVariable("DUE" . $door->GetDoorDBID()) - time()) + 604800);
						$client->Message(15, "You have paid the house rent for $oname. It has cost " . $npc->GetEntityVariable("UPKEEP" . $door->GetDoorDBID()) . " platinum.");
						plugin::UpdateHouseProcedure($door, $npc);
					}
					else
					{
					   $client->Message(15, "You have insufficient platinum pieces to pay for " . $oname . "'s house rent!");
					}
				}
				else
				{
					$client->Message(15, "This house is vacant and has no past due rent amount.");
				}
			}
		}
		else
		{
			$client->Message(13, "Please select a building frame to pay someone's rent!");
		}
	}
	elsif($command =~ /#Object/i)
	{
		if(defined($doorid))
		{
			my $door = $entity_list->GetDoorsByDBID($doorid);
			if(defined($door) && defined($client) && defined($door))
			{
					plugin::Objects_Manipulation_EVENT_SAY($command, $door, $client); #Objects!
			}
			else
			{
					$client->Message(13, "Please select an object to pick up that is on your property. Remember to activate build mode if it's your plant by clicking on the frame!");
			}
		}
		else
		{
			$client->Message(13, "Please select an object to pick up that is on your property. Remember to activate build mode if it's your plant by clicking on the frame!");
		}
	}
	
}


sub EVENT_SPAWN{
	$npc->TempName("");
	quest::gmsay("[HouseController] [ALIVE] Zone: $zonesn Instance Version: $instanceversion InstID $instanceversion", 15);
	my $val = LoadHouses(); # House Vars Empty, reload them from DB
	for my $x (0 .. @TD - 1) {
		$npc->SetEntityVariable("Owner" . $TD[$x][0], $TD[$x][1]);
		$npc->SetEntityVariable("X" . $TD[$x][0], $TD[$x][2]);
		$npc->SetEntityVariable("Y" . $TD[$x][0], $TD[$x][3]);
		$npc->SetEntityVariable("Z" . $TD[$x][0], $TD[$x][4]);
		$npc->SetEntityVariable("H" . $TD[$x][0], $TD[$x][5]);
		$npc->SetEntityVariable("RAD" . $TD[$x][0], $TD[$x][6]);
		$npc->SetEntityVariable("COST" . $TD[$x][0], $TD[$x][7]);
		$npc->SetEntityVariable("UPKEEP" . $TD[$x][0], $TD[$x][8]);
		$npc->SetEntityVariable("DUE" . $TD[$x][0], $TD[$x][9]);
		$npc->SetEntityVariable("ONAME" . $TD[$x][0], $TD[$x][10]);
		$npc->SetEntityVariable("SAV" . $TD[$x][0], $TD[$x][11]);
		$tmpid = quest::spawn2(1000509, 0, 0, 
		$npc->GetEntityVariable("X" . $TD[$x][0]),
		$npc->GetEntityVariable("Y" . $TD[$x][0]),
		$npc->GetEntityVariable("Z" . $TD[$x][0]),
		$npc->GetEntityVariable("H" . $TD[$x][0]));
		$npc->SetEntityVariable("MOBID" . $TD[$x][0], $tmpid);
		$tmpmob = $entity_list->GetMobByID($tmpid);
		$tmpmob->TempName($npc->GetEntityVariable("ONAME" . $TD[$x][0]) . "'s_House"); 
	}
}
@TD = undef;


sub LoadHouses{
	$connect = plugin::LoadMysql();
	$query = "SELECT
		cust_house.id,
		cust_house.owner,
		cust_house.x,
		cust_house.y,
		cust_house.z,
		cust_house.h,
		cust_house.radius,
		cust_house.cost,
		cust_house.upkeep,
		cust_house.datedue,
		cust_house.ownername,
		cust_house.savings
		FROM
		cust_house
		WHERE cust_house.zonesn = '$zonesn'";
		#quest::gmsay($query, 0);
	$query_handle = $connect->prepare($query);
	$query_handle->execute();
	$i = 0;
	while (@row = $query_handle->fetchrow_array()) { $TD[$i] = [@row]; $i++; }
	return $i;
}
