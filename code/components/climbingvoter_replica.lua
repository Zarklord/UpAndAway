local ClimbingScreen = modrequire "screens.climbingscreen"

---

local pushscreen
local popscreen

local ClimbingVoter = Class(Debuggable, function(self, inst)
	self.inst = inst
	Debuggable._ctor(self, "ClimbingVoterReplica")

	self.poll_screen = nil

	local cm = assert( GetClimbingManager() )

	cm:AddStartRequestCallback(function(poll_data)
		pushscreen(self, poll_data)
	end)
	cm:AddFinishRequestCallback(function(poll_data)
		popscreen(self, poll_data)
	end)
end)

---

function ClimbingVoter:Vote(target_inst, favorably)
	assert(target_inst)
	favorably = favorably and true or false

	self:Say("Voting ", favorably, " for request to climb [", target_inst, "].")
	self:Say("Previous poll data: ", GetClimbingManager():GetPollData())

	ServerRPC.VoteForClimbing(target_inst, favorably)
end

---

pushscreen = function(self, poll_data)
	popscreen(self, poll_data)

	local target = poll_data.target
	if target and replica(target).climbable then
		local screen = ClimbingScreen(target, replica(target).climbable:GetDirectionString())

		screen:SetOnYesFn(function()
			self:Vote(target, true)
		end)
		screen:SetOnNoFn(function()
			self:Vote(target, false)
		end)
		screen:SetOnBecomeActiveFn(function()
			self.poll_screen = screen
		end)
		screen:SetOnBecomeInactiveFn(function()
			self.poll_screen = nil
		end)

		TheFrontEnd:PushScreen(screen)
	end
end

popscreen = function(self, poll_data)
	if self.poll_screen then
		TheFrontEnd:PopScreen(self.poll_screen)
		self.poll_screen = nil
	end
end

---

return ClimbingVoter