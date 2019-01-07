--############
--Quest Name: bazaar\Caelyna
--Author: Dencelle
--NPCs Involved: 1
--Items Involved: 216
--#################

-- Credits: 
-- Kovou - Original creator of the bag for token script
-- Dencelle - updated for lua and made array of items

--	Array Layout:
--	ArrayID	: This can be any number really, just as long as they don't match each other
--	Bag ID	: id of the bag you would like to trade for the coresponding token
--	TokenID : id of the token you would like to trade for the coresponding bag
--	Enable	: enables or disables the trade
Bags = {
	[1] = {33233,93665,true}, -- Ambleshifts Amazing Automated Amalgamator
	[2] = {93450,93668,true}, -- Anizok's Bait Dispenser
	[3] = {92871,56873,true}, -- Antonican Sewing Kit
	[4] = {17405,56852,true}, -- Archeologist Pack
	[5] = {17354,56843,true}, -- Bag of Sewn Evil-Eye
	[6] = {17403,56850,true}, -- Bag of the Tinkerers
	[7] = {17071,56805,true}, -- Beetle Box
	[8] = {63819,51522,true}, -- Bolstered Cragbeast Backpack
	[9] = {63820,51523,true}, -- Bolstered Cragbeast Bag
	[10] = {63821,51524,true}, -- Bolstered Cragbeast Pack
	[11] = {63822,51525,true}, -- Bolstered Cragbeast Sack
	[12] = {63807,51514,true}, -- Bolstered Hynid-Hide Backpack
	[13] = {63808,51515,true}, -- Bolstered Hynid-Hide Bag
	[14] = {63809,51516,true}, -- Bolstered Hynid-Hide Pack
	[15] = {63810,51517,true}, -- Bolstered Hynid-Hide Sack
	[16] = {17798,56860,true}, -- Bonecollector's Sack
	[17] = {17799,56861,true}, -- Bottomless Box
	[18] = {11703,56800,true}, -- Box of Abu-Kar
	[19] = {17082,56808,true}, -- Box of Nil Space
	[20] = {92877,56879,true}, -- Clockwork Sewing Kit
	[21] = {63811,51518,true}, -- Cragbeast Backpack
	[22] = {63812,51519,true}, -- Cragbeast Bag
	[23] = {63814,51521,true}, -- Cragbeast Pouch
	[24] = {17157,56824,true}, -- Crude Fur Bandolier
	[25] = {17201,56826,true}, -- Dakoit Coin Purse
	[26] = {17703,56857,true}, -- Darkwood Trunk
	[27] = {17966,51537,true}, -- Deluxe Sewing Kit
	[28] = {17406,56853,true}, -- Driftwood Treasure Chest
	[29] = {17081,56807,true}, -- Dusty Ransacker's Pack
	[30] = {17806,51538,true}, -- Erudite Sewing Kit
	[31] = {92873,56875,true}, -- Erudite Sewing Kit
	[32] = {70162,70193,true}, -- Ethereal Satchel of Gathering
	[33] = {17241,56834,true}, -- Feather Lined Bag
	[34] = {17587,56854,true}, -- Feather Lined Box
	[35] = {17813,56876,true}, -- Fier`Dal Sewing Kit
	[36] = {17105,56813,true}, -- Fine Xakra Runed Jar
	[37] = {17327,56839,true}, -- Fleeting Quiver
	[38] = {17213,56832,true}, -- Gem Pouch
	[39] = {92868,56870,true}, -- Guktan Sewing Kit
	[40] = {92870,56872,true}, -- Half Elf Sewing Kit
	[41] = {17969,56863,true}, -- Hand Made Backpack
	[42] = {17358,56845,true}, -- Herbalist Pack
	[43] = {63799,51510,true}, -- Hynid-Hide Backpack
	[44] = {63800,51511,true}, -- hynid-Hide Bag
	[45] = {63801,51512,true}, -- Hynid-Hide Pack
	[46] = {63802,51513,true}, -- Hynid-Hide Sack
	[47] = {72502,93166,true}, -- Ice Cream Churn
	[48] = {92879,56881,true}, -- iksar Sewing Kit
	[49] = {17701,56855,true}, -- Kavruul's Mystic Pouch
	[50] = {17062,56804,true}, -- Kejekan Tool Kit
	[51] = {92875,56877,true}, -- Koada`Dal Sewing Kit
	[52] = {51175,56869,true}, -- Large Lemming Fur Bag
	[53] = {17404,56851,true}, -- Large Soiled Bag
	[54] = {17144,56821,true}, -- Leatherfoot Backpack
	[55] = {17142,56819,true}, -- Leatherfoot Belt Pouch
	[56] = {17145,56822,true}, -- Leatherfoot Haversack
	[57] = {17143,56820,true}, -- Leatherfoot Shoulderbag
	[58] = {17141,56818,true}, -- Leatherfoot Small Pouch
	[59] = {17140,56817,true}, -- Leatherfoot Wrist Pouch
	[60] = {51172,56866,true}, -- Lemming Fur Backpack
	[61] = {17353,56842,true}, -- Light Burlap Sack
	[62] = {17350,56840,true}, -- Lionhide Backpack
	[63] = {17139,51535,true}, -- Marble Mortar and Pestle
	[64] = {17204,56829,true}, -- Medium Coin Purse
	[65] = {51174,56868,true}, -- Medium Lemming Fur Bag
	[66] = {17402,56849,true}, -- Memento Box
	[67] = {92872,56874,true}, -- Northman Sewing Kit
	[68] = {17196,56825,true}, -- Nigrud's Sewing Kit
	[69] = {17186,51536,true}, -- Odylic Vial
	[70] = {92880,56882,true}, -- Ogre Sewing Kit
	[71] = {17302,56838,true}, -- Pierce's Pouch of Storing
	[72] = {17072,56806,true}, -- Pristine Beetle Box
	[73] = {17008,56801,true}, -- Quiver
	[74] = {17359,56846,true}, -- Rallic Pack
	[75] = {17251,56835,true}, -- Rotted Skin Bag
	[76] = {17129,56816,true}, -- Satchel of the Hatchling
	[77] = {33234,93666,true}, -- Scrindite's Mechanoinstruction Holepoker
	[78] = {92869,56871,true}, -- Shar Vahl Sewing Kit
	[79] = {17401,56848,true}, -- Shralok Pack
	[80] = {17203,56828,true}, -- Small Coin Purse
	[81] = {51173,56867,true}, -- Small Lemming Fur Bag
	[82] = {93492,93667,true}, -- Spell Research Kit
	[83] = {63816,51526,true}, -- Steel Reinforced Cragbeast Backpack
	[84] = {63816,51527,true}, -- Steel Reinforced Cragbeast Bag
	[85] = {62817,51528,true}, -- Steel Reinforced Cragbeast Pack
	[86] = {63803,51530,true}, -- Steel Reinforced Hynid-Hide Backpack
	[87] = {63804,51531,true}, -- Steel Reinforced Hynid-Hide Bag
	[88] = {63805,51532,true}, -- Steel-Reinforced Hynid-Hide Pack
	[89] = {63806,51533,true}, -- steel Reinforced Hynid-Hide Sack
	[90] = {66136,51542,true}, -- Surefall Fletching Kit
	[91] = {17123,56815,true}, -- Tae Ew Hide Sack
	[92] = {17084,56810,true}, -- Tailored Large Bag
	[93] = {17083,56809,true}, -- Tailored Large Belt Pouch
	[94] = {17804,56862,true}, -- Tailored Quiver
	[95] = {17047,56803,true}, -- Tailored Small Bag
	[96] = {17085,56811,true}, -- Tailored Wrist Pouch
	[97] = {92876,56878,true}, -- Tier`Dal Sewing Kit
	[98] = {17352,56841,true}, -- Thunderhoof Quiver
	[99] = {17202,56827,true}, -- Tiny Coin Purse
	[100] = {17301,56837,true}, -- Travelers Pack
	[101] = {17300,56836,true}, -- Travelers Pouch
	[102] = {17702,56856,true}, -- Treasure Hunter's Satchel
	[103] = {17705,56859,true}, -- Treasure Seekers Pack
	[104] = {92881,56883,true}, -- Troll Sewing Kit
	[105] = {17812,51543,true}, -- Vale Sewing Kit
	[106] = {92882,56884,true}, -- Vale Sewing Kit
	[107] = {17207,56831,true}, -- Very Large Coin Purse
	[108] = {17104,56812,true}, -- Xakra Runed Jar
}
function event_say(e)
  if (e.message:findi("hail")) then
    e.self:Say("Greetings " .. e.other:GetCleanName() .. "! Nice to meet you. I've started up a complimentary bag check service. Feel free to give me your weight reducing bag, and I'll give you a token in return. When you would like to get your bag back, simply return to me with your token.");
  end
end
function event_trade(e)
	local item_lib = require("items");
	for id, v in pairs(Bags) do
        if (item_lib.check_turn_in(e.trade, {item1 = v[1]}) and v[3]) then
            e.self:Say("Here you go. Bring this token back to me when you would like your bag back.")
			e.other:SummonItem(v[2])
        elseif (item_lib.check_turn_in(e.trade, {item1 = v[2]}) and v[3]) then
            e.self:Say("Here you go. Here is your bag back.")
			e.other:SummonItem(v[1])
        end
    end 
	item_lib.return_items(e.self, e.other, e.trade)
end
