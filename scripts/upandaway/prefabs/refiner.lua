--@@GLOBAL ENVIRONMENT BOOTUP
local _modname = assert( (assert(..., 'This file should be loaded through require.')):match('^[%a_][%w_%s]*') , 'Invalid path.' )
module( ..., package.seeall, require(_modname .. '.booter') )
--@@END ENVIRONMENT BOOTUP

local assets =
{
	Asset("ANIM", "anim/void_placeholder.zip"),
}

local prefabs =
{
    "inv_rock",
    "twigs",
    "cutgrass",
}    

local function ShouldAcceptItem(inst, item)
    if item then
        if item:HasTag("coral") then
        	print "Rock from..."
        	return true
        end
        
        if item:HasTag("algae")  then
			print "Twigs from..."
			return true
		end

        return true
    end
end

local function OnGetItemFromPlayer(inst, giver, item)
    if item then
        if item:HasTag("coral") then
            print "Coral taken."
            local refined1 = SpawnPrefab("rocks")
            
            if refined1 then 
                refined1.Transform:SetPosition(GetPlayer().Transform:GetWorldPosition())             
            end            
        end

        if item:HasTag("algae") then
        	print "Algae taken."
            local refined2 = SpawnPrefab("cutgrass")
            
            if refined2 then
                refined2.Transform:SetPosition(GetPlayer().Transform:GetWorldPosition())    
            end         	
        end

        if item:HasTag("beanstalk_chunk") then
            print "Beanstalk taken."
            local refined3 = SpawnPrefab("twigs")

            if refined3 then
                refined3.Transform:SetPosition(GetPlayer().Transform:GetWorldPosition())
            end    
        end                

        if not item:HasTag("coral") and not item:HasTag("algae") and not item:HasTag("beanstalk_chunk") then
            print "Other item taken."
            local refined4 = SpawnPrefab("ash")

            if refined4 then
                refined4.Transform:SetPosition(GetPlayer().Transform:GetWorldPosition())
            end    
        end    
    end
end

local function OnRefuseItem(inst, item)
	print "The refiner cannot accept that."
end

--This will convert coral into rocks, and algae into sticks.
local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	MakeInventoryPhysics(inst)

	inst.AnimState:SetBank("marble")
	inst.AnimState:SetBuild("void_placeholder")
	inst.AnimState:PlayAnimation("anim")

	inst:AddComponent("inspectable")

    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.onrefuse = OnRefuseItem	
	inst.components.trader:Enable()

    inst:AddComponent("lootdropper")
	inst:AddComponent("inventory")

	return inst
end

return Prefab ("common/inventory/refiner", fn, assets, prefabs) 