-- Robregen VS/VSR script

function event_spawn(e)
  if(eq.get_entity_list():IsMobSpawnedByNpcTypeID(102099)) then -- Depop VSR if VSR is up.
    eq.depop_with_timer(102099);
  end
end

function event_death_complete(e)
  eq.spawn2(102099,0,0,-553,-77.0,15.0,192.0); -- Spawn Venril's remains
end
