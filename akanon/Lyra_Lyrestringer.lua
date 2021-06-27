-- Author: RealityIncarnate
-- Converted to .lua by Speedz
-- items: 18163

function event_say(e)
	if(e.message:findi("hail")) then
		e.self:Say("Hail " .. e.other:GetName() .. ". Are you [" .. eq.say_link("I am interested",false,"interested") .. "] in helping the League of Antonican Bards by delivering some [" .. eq.say_link("mail") .. "]?");
	elseif(e.message:findi("mail")) then
		e.self:Say("The League of Antonican Bards has a courier system made up of travelers and adventurers. We pay good gold to anyone who will take messages from bards such as myself to one of our more central offices. Are you [" .. eq.say_link("I am interested",false,"interested") .. "]?");
	elseif(e.message:findi("interested")) then
		e.self:Say("I have messages that need to go to... well, right now I have one that needs to go to Kelethin. Will you [" .. eq.say_link("I will deliver mail to Kelethin",false,"deliver mail to Kelethin") .. "] for me?");
	elseif(e.message:findi("kelethin")) then
		e.self:Say("Take this letter to Jakum Webdancer in Kelethin. You can find him at the bard guild hall. I am sure he will compensate you for your troubles.");
		e.other:SummonItem(18163); -- Item: Bardic Letter (Kelethin)
		e.other:Ding();
	end
end

function event_trade(e)
	local item_lib = require("items");
	item_lib.return_items(e.self, e.other, e.trade)
end
