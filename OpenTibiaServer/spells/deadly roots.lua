local combat = createCombatObject()

function onTargetTile(cid, pos)
	local frompos, target = getCreaturePosition(cid), getCreatureTarget(cid)
	doSendMagicEffect(frompos, 45)
	local function event()
		local atk = getCreaturePosition(target)
		if atk and atk.z == frompos.z then
			doSendDistanceShoot(frompos, atk,29)
			local lvl = getPlayerStorageValue(cid,13345)
			local min, max = getHit(cid, lvl*1.5, lvl*1.8)
			doAreaCombatHealth(isCreature(cid) and cid or 0, COMBAT_EARTHDAMAGE, atk, 0, min+lvl, max, 50)
		end
	end
	addEvent(event, 500)
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")
local lvl ={
[10186] = 0,
[10187] = 1,
[10188] = 2,
[10189] = 3,
}
function onUse(cid, item, frompos, item2, topos)
	-- sistema
	if SPELLS then
			doTransformItem(item.uid,lvl[item.itemid] == 3 and item.itemid-3 or item.itemid+1)
	end
	if not lvl[item.itemid] or  lvl[item.itemid] == 0 then
		doPlayerSendCancel(cid,'You need learn this spell.')
		return true
	end
	local pos = getCreaturePosition(cid)
	if getCreatureTarget(cid) == 0 then
		doPlayerSendCancel(cid,'You can only use it on creatures.')
		doSendMagicEffect(pos, 2)
		return true
	end
	setPlayerStorageValue(cid,13345,lvl[item.itemid])
	local var = numberToVariant(getCreatureTarget(cid))
	local ret,f = ifSpell(cid, 20*lvl[item.itemid],2,17201,isEa)
	if ret then
		doCombat(cid, combat, var)
		f()
	end
end
