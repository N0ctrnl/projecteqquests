-- Event: LDoN Raid: Mistmoore Catacombs: Struggles within the Progeny
-- http://www.peqtgc.com/phpBB3/viewtopic.php?f=4&t=15491
-- http://everquest.allakhazam.com/db/quest.html?quest=4177
--
-- 243672 Valdoon Kel`Novar (real)
-- 243677 Valdoon Kel`Novar (fake)
-- 243636 Guardian of Kel`Novar
local valdoon_hp_5 = 30000;
local extra_loot = false;
local guardians = 0;
local instance_id;
local raid_list;

function Guardian_Death(e)
  eq.get_entity_list():MessageClose(e.self, true, 100, 15, "The massive stone beast shudders violently as it transforms into a lifeless statue. The power of its master wanes slightly by the loss of its soul-bound guardian.")
  local valdoon = eq.get_entity_list():GetMobByNpcTypeID(243672);
  local valdoon_hp = valdoon:GetHP() - valdoon_hp_5;
  valdoon:SetOOCRegen(0);
  valdoon:SetHP(valdoon_hp);
  guardians = guardians + 1;
  if ( guardians == 3 ) then
    eq.zone_emote(14, "Your victory has weakened a shroud of magic cloaking the dungeon's treasure.");
  end

end

function Fake_Spawn(e)
  extra_loot = false;
end

function Fake_Death(e)
  eq.zone_emote(15, "A mighty laugh echoes out into the night from the gargoyle aviary. The sound of Valdoon Kel'Novar's voice is clear, 'Did you fools really believe I would be so careless? You'll not live to regret the mistake of crossing the Trueborn!' ");
  eq.spawn2(243636, 0, 0, e.self:GetX(), e.self:GetY(), e.self:GetZ(), e.self:GetHeading()); -- NPC: Guardian_of_Kel`Novar
  extra_loot = true;
end

function Real_Spawn(e)
  instance_id = eq.get_zone_instance_id();
  raid_list = eq.get_characters_in_instance(instance_id);
end

function Real_Death(e)
  eq.stop_timer('valdoon');
  eq.spawn2(243680, 0, 0, 1129, 560, 10.13, 372); -- NPC: Guardian`s_Stone_Chest
  eq.spawn2(243681, 0, 0, 1129, 477, 10.13, 372); -- NPC: Guardian`s_Granite_Chest
  if (extra_loot == true) then
    eq.spawn2(243679, 0, 0, 1241, 510, -3.90, 380); -- NPC: Valdoon`s_gilded_coffin
  end

  local dz = eq.get_expedition()
  if dz.valid then
    dz:AddReplayLockout(eq.seconds("4d12h"))
  end
end

function Real_Combat(e)
  if (e.joined) then
    eq.set_timer('valdoon', 30 * 1000);
  else 
    eq.stop_timer('valdoon');
    eq.depop_all(243678);
  end
end

function Real_Timer(e)
  if (e.timer == 'valdoon') then
    eq.spawn2(243678, 0, 0, 1060, 480, 11.73, 506); -- NPC: Kel`Novar_Lookout
    eq.spawn2(243678, 0, 0, 1030, 480, 11.73, 506); -- NPC: Kel`Novar_Lookout
    eq.spawn2(243678, 0, 0, 1060, 564, 11.73, 242); -- NPC: Kel`Novar_Lookout
    eq.spawn2(243678, 0, 0, 1030, 564, 11.73, 242); -- NPC: Kel`Novar_Lookout
  end
end

function Agent_Hp(e)
	if (e.hp_event == 20) then
		eq.zone_emote(13,"A Trueborn night agent begins to jerk violently as a second pair of eyes grows from its head.");
		eq.set_timer("split", 6 * 1000);
	end
end

function Agent_Combat(e)
	if (e.joined == true) then
		eq.set_next_hp_event(20);
	end
end

function Agent_Timer(e)
	if (e.timer == "split") then
		eq.zone_emote(13,"A Trueborn night agent screams as it is torn in two!");
		eq.stop_timer("split");
		eq.spawn2(243622, 0, 0, e.self:GetX(), e.self:GetY(),  e.self:GetZ(),  e.self:GetHeading());
		eq.spawn2(243622, 0, 0, e.self:GetX(), e.self:GetY(),  e.self:GetZ(),  e.self:GetHeading());
		eq.depop();
	end
end

function event_encounter_load(e)
  eq.register_npc_event('mmcc', Event.timer,          243622, Agent_Timer);
  eq.register_npc_event('mmcc', Event.combat,         243622, Agent_Combat);
  eq.register_npc_event('mmcc', Event.hp,         243622, Agent_Hp);
  
  eq.register_npc_event('mmcc', Event.death_complete, 243636, Guardian_Death);
  eq.register_npc_event('mmcc', Event.death_complete, 243677, Fake_Death);
  eq.register_npc_event('mmcc', Event.spawn,          243677, Fake_Spawn);

  eq.register_npc_event('mmcc', Event.death_complete, 243672, Real_Death);
  eq.register_npc_event('mmcc', Event.spawn,          243672, Real_Spawn);
  eq.register_npc_event('mmcc', Event.timer,          243672, Real_Timer);
  eq.register_npc_event('mmcc', Event.combat,         243672, Real_Combat);
end
