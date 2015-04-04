local combat = createCombatObject()

function onTargetTile(cid, pos)
	local frompos, target = getCreaturePosition(cid), getCreatureTarget(cid)
	for i = 0, 3 do
		local start = getPosByDir(frompos, i, 1)
		doSendDistanceShoot(getPosByDir(frompos, i, 1), frompos, 37)
	end
	doSendMagicEffect(frompos, 48)
	local function event()
		local atk = getCreaturePosition(target)
		if atk and atk.z == frompos.z then
			doSendDistanceShoot(frompos, atk, 32)
			local lvl = getPlayerStorageValue(cid,13345)
			local min, max = getHit(cid, lvl*0.6, lvl*1.0)
			doAreaCombatHealth(isCreature(cid) and cid or 0, COMBAT_ENERGYDAMAGE, atk, 0, min, max, 39)
		end
	end
	addEvent(event, 500)
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local lvl ={
[10190] = 0,
[10191] = 1,
[10192] = 2,
[10193] = 3,
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
	local ret,f = ifSpell(cid, 25*lvl[item.itemid],4*lvl[item.itemid],22013,isEn)
	local var = numberToVariant(getCreatureTarget(cid))
	if ret then
		f()
		return  doCombat(cid, combat, var)
	end
end
