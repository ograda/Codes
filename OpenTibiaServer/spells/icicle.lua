local combat = createCombatObject()

function onTargetTile(cid)
	local lvl = getPlayerStorageValue(cid,13352)
    if lvl == 1 then
    walkAttack(cid, getCreatureTarget(cid), getCreaturePosition(cid), 1, {dmg = COMBAT_ICEDAMAGE, min = 0.4, max = 0.5, fx = 41, proj = 28})
    elseif lvl == 2 then
    walkAttack(cid, getCreatureTarget(cid), getCreaturePosition(cid), 1, {dmg = COMBAT_ICEDAMAGE, min = 0.7, max = 0.8, fx = 41, proj = 28})
    elseif lvl == 3 then
    walkAttack(cid, getCreatureTarget(cid), getCreaturePosition(cid), 1, {dmg = COMBAT_ICEDAMAGE, min = 1.0, max = 1.2, fx = 41, proj = 28})
	end
	end

setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local lvl = {
[10595] = 0,
[10596] = 1,
[10597] = 2,
[10598] = 3,
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
	local var = numberToVariant(getCreatureTarget(cid))
	local ret,f = ifSpell(cid, 15*lvl[item.itemid],4-lvl[item.itemid],50201,isIce)
	if not ret then
		return false
	end
	setPlayerStorageValue(cid,13352,lvl[item.itemid])
	if doCombat(cid, combat, var) then
		return f()
	else
		doPlayerSendCancel(cid,'WTF?')
	end
	return true
end
