sub EVENT_SAY {
	
	if (!$client->GetGM()) {
		$client->Message(15, "You have no access to object creation!");
		return;
	}
	
	if ($text =~ /Hail/) {
		$client->Message(15, "Object Creation Commandlist");
		$client->Message(15, "=============");
		$client->Message(15, "object dbdel [object_id]");
		$client->Message(15, "object dbsave [object_id]");
		$client->Message(15, "object create fromitem [itemid]");
		$client->Message(15, "object create frommodel [model]");
		$client->Message(15, "object list");
		$client->Message(15, "object set [object_id] location [x] [y] [z]");
		$client->Message(15, "object set [object_id] model [model]");
		$client->Message(15, "object set [object_id] type [0-255]");
		$client->Message(15, "object view [object_id]");
		$client->Message(15, "=============");
		$client->Message(15, "End of list");
		return;
	}
	
	@arguments = split(' ',$text);
	if ($arguments[0] ne "object") {
		return;
	}

	
	if ($arguments[1] eq "list") {
		my @objectList = $entity_list->GetObjectList();
		$client->Message(15, "Object list: ");
		$client->Message(15, "=============");
		foreach my $object (@objectList) {
			$client->Message(15, GetObjectInfo($object));
		}
		$client->Message(15, "=============");
		$client->Message(15, "End of list");
	}
	
	if ($arguments[1] eq "view") {
		$obj = $entity_list->GetObjectByID($arguments[2]);
		if (!$obj) {
			$client->Message(15, "Object with ID ".$arguments[2]." does not exist!");
		}
		else {
			$client->Message(15, GetObjectInfo($obj));
		}
	}
	
	if ($arguments[1] eq "create") {
		if ($arguments[2] eq "frommodel") {
			$model = BuildObjectModel($arguments[3]);
			$entityId = quest::creategroundobjectfrommodel($model, $x, $y, $z, $h);
			$client->Message(15, "Object created.");
			$obj = $entity_list->GetObjectByID($entityId);
			$client->Message(15, GetObjectInfo($obj));
		}
		if ($arguments[2] eq "fromitem") {
			$itemid = $arguments[3];
			$entityId = quest::creategroundobject($itemid, $x, $y, $z, $h);
			$client->Message(15, "Object created.");
			$obj = $entity_list->GetObjectByID($entityId);
			$client->Message(15, GetObjectInfo($obj));
		}
	}
	
	if ($arguments[1] eq "set") {
		$entityId = $arguments[2];
		$obj = $entity_list->GetObjectByID($arguments[2]);
		if (!$obj) {
			$client->Message(15, "Object with ID ".$arguments[2]." does not exist!");
		}
		else {
			my $updated = false;
			if ($arguments[3] eq "location") {
				if ($arguments[6] eq "") {
					$client->Message(15, "Usage: set [ObjectID] location x y z");
				}
				else {
					$obj->SetX($arguments[4]);
					$obj->SetY($arguments[5]);
					$obj->SetZ($arguments[6]);
					$updated = true;
				}
			}
			if ($arguments[3] == "model") {
				if ($arguments[4] eq "") {
					$client->Message(15, "Usage: set [ObjectID] model modelname");
				}
				else {
					$obj->SetModelName(BuildObjectModel($arguments[4]));
					$updated = true;
				}
			}
			if ($arguments[3] == "type") {
				if ($arguments[4] eq "") {
					$client->Message(15, "Usage: set [ObjectID] type [0-255]");
				}
				else {
					$obj->SetType($arguments[4]);
					$updated = true;
				}
			}
			
			
			if ($updated) {
				$client->Message(15, "Object Updated.");
				$client->Message(15, GetObjectInfo($obj));
			}
		}
	}
	
	if ($arguments[1] eq "dbsave") {
		$entityId = $arguments[2];
		$obj = $entity_list->GetObjectByID($entityId);
		if (!$obj) {
			$client->Message(15, "Object with ID ".$entityId." does not exist!");
		}
		else {
			$newid = $obj->VarSave();
			$client->Message(15, "Object saved to database: ID $newid");
			$client->Message(15, GetObjectInfo($obj));
		}
	}	
	if ($arguments[1] eq "dbdel") {
		$entityId = $arguments[2];
		$obj = $entity_list->GetObjectByID($arguments[2]);
		if (!$obj) {
			$client->Message(15, "Object with ID ".$arguments[2]." does not exist!");
		}
		else {
			$newid = $obj->Delete();
			$client->Message(15, "Object deleted from database");
			$client->Message(15, GetObjectInfo($obj));
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
sub BuildObjectModel {
	my $model = $_[0];
	if (substr($model,length($model)-9,9) ne "_ACTORDEF") {
		$model = $model . "_ACTORDEF";
	}
	return $model;
}