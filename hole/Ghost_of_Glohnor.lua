-- Part of SK Epic 1.0
function event_trade(e)
  local item_lib = require("items");
  if(item_lib.check_turn_in(e.trade, {item1 = 14377})) then -- Dark Shroud
    eq.spawn2(39165,0,0,464.4,819,-678,125);
    eq.depop_with_timer();
  end
  item_lib.return_items(e.self, e.other, e.trade)
end
