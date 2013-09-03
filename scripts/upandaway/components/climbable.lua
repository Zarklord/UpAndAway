--@@ENVIRONMENT BOOTUP
local _modname = assert( (assert(..., 'This file should be loaded through require.')):match('^[%a_][%w_%s]*') , 'Invalid path.' )
module( ..., require(_modname .. '.booter') )

--@@END ENVIRONMENT BOOTUP


local Climbing = modrequire 'worldgen.climbing'


local Pred = wickerrequire 'lib.predicates'
local Debuggable = wickerrequire 'gadgets.debuggable'


--[[
-- In what follows, "cave" has extended meaning, i.e., any cave level.
-- So it refers to either an actual cave or a cloud realm.
--]]
local Climbable = Class(Debuggable, function(self, inst)
	self.inst = inst
	Debuggable._ctor(self)

	self.direction = nil

	-- Target cave number, i.e. cave number of the world to be generated.
	-- This should never be set directly.
	self.cavenum = nil
end)


--[[
-- Destroys the associated cave, if any.
--]]
function Climbable:DestroyCave(callback)
	local function actual_callback()
		self.cavenum = nil
		if callback then callback(self.inst) end
	end

	if self.cavenum then
		self:DebugSay("Destroying cave number ", self.cavenum, "...")

		-- This actually destroys it.
		SaveGameIndex:ResetCave(self.cavenum, actual_callback)
	else
		actual_callback()
	end
end

--[[
-- This will only return true if either:
-- 1) The direction is up and we are not below ground.
-- 2) The direction is down and we are not above ground.
--]]
local function should_have_cavenum(self)
	return self.direction and self.direction*Climbing.GetLevelHeight() >= 0
end


--[[
-- Direction should be either a number or a string ("up" or "down", case insensitive).
-- If it is a number, its sign will dictate the direction.
--]]
function Climbable:SetDirection(direction)
	if not Pred.IsNumber(direction) then
		if not Pred.IsWordable(direction) then
			return error("The climbing direction should either a number or a string.")
		end
		direction = tostring(direction)
		if direction:lower() == "up" then
			direction = 1
		elseif direction:lower() == "down" then
			direction = -1
		else
			return error(("Invalid climbing direction %q."):format(direction))
		end
	elseif direction == 0 then
		return error("The climbing direction can't be zero!")
	end

	if direction > 0 then
		direction = 1
	elseif direction < 0 then
		direction = -1
	end

	self.direction = direction

	if not should_have_cavenum(self) then
		self:DestroyCave()
	end
end

function Climbable:GetDirection()
	return self.direction
end

function Climbable:GetDirectionString()
	if not self.direction then return "" end
	if self.direction > 0 then
		return "UP"
	elseif self.direction < 0 then
		return "DOWN"
	else
		return error("The climbing direction can't be zero!")
	end
end


function Climbable:GetCaveNumber()
	return self.cavenum
end

function Climbable:GetEffectiveCaveNumber()
	local n = self:GetCaveNumber()
	if n then
		return n
	elseif SaveGameIndex:GetCurrentMode() == "cave" then
		return SaveGameIndex:GetCurrentCaveNum()
	else
		return 0
	end
end


function Climbable:Climb()
	assert( self.direction, "Attempt to climb a climbable without a direction set." )

	local function doclimb()
		if self:Debug() then
			self:Say("Climbing ", self:GetDirectionString(), " into cave number ", self:GetEffectiveCaveNumber(), ". Current height: ", Climbing.GetLevelHeight(), ".")
		end
		Climbing.Climb(self.direction, self.cavenum)
	end

	if not self.cavenum and should_have_cavenum(self) then
		self.cavenum = SaveGameIndex:GetNumCaves() + 1
		SaveGameIndex:AddCave(nil, doclimb)
	else
		doclimb()
	end
end


function Climbable:OnRemoveEntity()
	self:DestroyCave()
end

function Climbable:OnRemoveFromEntity()
	self:DestroyCave()
end

function Climbable:OnSave()
	return {
		cavenum = self.cavenum,
	}
end

function Climbable:OnLoad(data)
	if data then
		self.cavenum = data.cavenum

		if self.cavenum then
			self.inst:DoTaskInTime(3 + 2*math.random(), function()
				if self.cavenum and not should_have_cavenum(self) then
					self:DestroyCave()
				end
			end)
		end
	end
end

return Climbable
