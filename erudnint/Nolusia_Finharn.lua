function event_say(e)
	if(e.message:findi("hail")) then
		e.self:Say(string.format("Greetings, %s! Has Lanken sent you to see me? Are you a [" .. eq.say_link("I am a visitor of Erudin",false,"visitor") .. "] or [" .. eq.say_link("I am a citizen of Erudin",false,"citizen") .. "] of Erudin]?",e.other:GetCleanName()));
	elseif(e.message:findi("visitor of erudin")) then
		e.self:Say("Then, remember, inside the palace walls, never speak the names of those defilers who have passed on. I shall be at the Vasty Inn later tonight. I can answer your questions there.");
	elseif(e.message:findi("citizen of erudin")) then
		e.self:Say("Well then you should know better than to speak the name of defilers inside the palace walls. I must get back to my work or I shall be late to the Inn this evening.");
	end
end
