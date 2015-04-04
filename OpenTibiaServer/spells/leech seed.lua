local combat = createCombatObject()

local function isInScreen(pos1, pos2)
	if math.abs(pos1.x - pos2.x) <= 7 and math.abs(pos1.y - pos2.y) <= 5 and pos1.z == pos2.z then
		return TRUE
	else
		return FALSE
	end
end

local function event(cid, target,n)
	if isCreature(cid) and isCreature(target) and isInScreen(getCreaturePosition(cid), getCreaturePosition(target)) then
		local lvl = getPlayerStorageValue(cid,13351)
		doAreaCombatHealth(cid, 1, getCreaturePosition(target), 0, -30*lvl, -30*lvl, 46)
		for i = 0, 3 do
			doSendDistanceShoot(getPosByDir(getCreaturePosition(target), i), getCreaturePosition(cid), 38)
		end
		addEvent(doCreatureAddHealth, 300, cid, (30*lvl)/2)
		addEvent(doSendAnimatedText, 300, getCreaturePosition(cid), '+'..(30*lvl)/2,189)
		addEvent(doSendMagicEffect, 300, getCreaturePosition(cid), 12)
		n = n-1
		if n == 0 then
			return
		end
		addEvent(event, 1500, cid, target,n)
	else
		if isCreature(cid) == TRUE then
			exhaustion.set(cid, 4005, 0)
		end
	end
end

function onTargetTile(cid, pos)
	doSendDistanceShoot(getCreaturePosition(cid), pos, 38)
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local lvl = {
[10202] = 0,
[10203] = 1,
[10204] = 2,
[10205] = 3,
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
	local lvla = lvl[item.itemid]
	local var = numberToVariant(getCreatureTarget(cid))
	local ret,f = ifSpell(cid, 25*lvl[item.itemid], 5,40005,isEa)
	if not ret then
		return false
	end

		if ret then
			doCombat(cid, combat, var)
			addEvent(event, 300, cid, getCreatureTarget(cid),10*lvla)
			setPlayerStorageValue(cid,13351,lvl[item.itemid])
			return f()
		end
	return false
end
