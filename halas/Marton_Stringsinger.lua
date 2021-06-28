-- items: 18153
function event_say(e)
	if(e.message:findi("Hail")) then
		e.self:Say("Hail. " .. e.other:GetName() .. " - Are you interested in helping the League of Antonican Bards by delivering some [" .. eq.say_link("What mail?",false,"mail") .. "]?");
	elseif(e.message:findi("mail")) then
		e.self:Say("The League of Antonican Bards has a courier system made up of travelers and adventurers. We pay good gold to anyone who will take messages from bards such as myself to one of our more central offices. Are you [" .. eq.say_link("I am interested",false,"interested") .. "]?");
	elseif(e.message:findi("interested")) then
		e.self:Say("I have messages that need to go to - well, right now I have one that needs to go to Qeynos. Will you [" .. eq.say_link("I will deliver mail to Qeynos",false,"deliver mail to Qeynos") .. "] for me?");
	elseif(e.message:findi("deliver")) then
		e.self:Say("Take this letter to Tralyn Marsinger in Qeynos. You can find him at the bard guild hall. I am sure he will compensate you for your troubles.");
		e.other:SummonItem(18153); -- Item: Bardic Letter (Qeynos)
	end
end
