BindGlobal()

local Game = wickerrequire "game"

local Configurable = wickerrequire "adjectives.configurable"
local cfg = Configurable("WINNIE_STAFF")

local assets=
{
    Asset("ANIM", "anim/ua_staves.zip"),
    Asset("ANIM", "anim/swap_ua_staves.zip"),

    Asset( "ATLAS", "images/inventoryimages/winnie_staff.xml" ),
    Asset( "IMAGE", "images/inventoryimages/winnie_staff.tex" ),
}

local prefabs = {}

local function herd_enable(inst, owner)
	local leadercmp = owner and owner.components.leader
    if leadercmp then
		local max_new_followers = cfg("MAX_FOLLOWERS") - leadercmp:CountFollowers("beefalo")

		if max_new_followers > 0 then
			local function filter_fn(beefalo)
				local followercmp = beefalo.components.follower
				return followercmp and not leadercmp:IsFollower(beefalo)
			end

			local ents = Game.FindClosestEntities(owner, cfg("MAX_FOLLOWER_DIST"), filter_fn, max_new_followers, {"beefalo"})

			for _, v in ipairs(ents) do
				owner.components.leader:AddFollower(v)
				TheMod:DebugSay("Added follower [", v, "]")
			end
		end

        for k, v in pairs(owner.components.leader.followers) do
            if k:HasTag("beefalo") and k.components.follower then
                k.components.follower:AddLoyaltyTime(1.1)
				--[[
                if not k.components.sanityaura then
                    k:AddComponent("sanityaura")
                end
				]]--
            end
        end
    end          
end

local function herd_disable(inst, owner)
    if inst.updatetask then
        inst.updatetask:Cancel()
        inst.updatetask = nil
    end    
	local leadercmp = owner and owner.components.leader
    if leadercmp then
        for follower in pairs(leadercmp.followers) do
            if follower:HasTag("beefalo") and follower.components.follower then
                leadercmp:RemoveFollower(follower)
                follower.components.follower:SetLeader(nil)
                --follower:RemoveComponent("sanityaura")
				if follower.brain and follower.brain.bt then
					follower.brain.bt:Reset()
				end
                TheMod:DebugSay("Removing follower [",follower, "]")
            end
        end
    end 
end    

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_object", "swap_ua_staves", "purplestaff")
    owner.AnimState:Show("ARM_carry") 
    owner.AnimState:Hide("ARM_normal")
	if inst.updatetask then
		inst.updatetask:Cancel()
		inst.updatetask = nil
	end
	if owner.prefab == "winnie" then
		inst.updatetask = inst:DoPeriodicTask(1, function(inst)
			herd_enable(inst, owner)
		end, 1)
	end
end

local function onunequip(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal")
	if inst.updatetask then
		inst.updatetask:Cancel()
		inst.updatetask = nil
	end
	if owner.prefab == "winnie" then
		herd_disable(inst, owner) 
	end
end

local function fn()
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()        
    MakeInventoryPhysics(inst)
    
    anim:SetBank("staffs")
    anim:SetBuild("ua_staves")
    anim:PlayAnimation("orangestaff")


    ------------------------------------------------------------------------
    SetupNetwork(inst)
    ------------------------------------------------------------------------

    
    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/winnie_staff.xml"
    
    inst:AddComponent("equippable")
    inst:AddComponent("weapon")
    
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)  
    
    return inst
end

return Prefab( "common/inventory/winnie_staff", fn, assets, prefabs) 
