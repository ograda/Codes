local combat = createCombatObject()

function onTargetTile(cid)
	local lvl = getPlayerStorageValue(cid,13352)
    if lvl == 1 then
    walkAttack(cid, getCreatureTarget(cid), getCreaturePosition(cid), 1, {dmg = COMBAT_FIREDAMAGE,min = 0.7, max = 1, fx = 36, proj = 3})
    elseif lvl == 2 then
    walkAttack(cid, getCreatureTarget(cid), getCreaturePosition(cid), 1, {dmg = COMBAT_FIREDAMAGE, min = 1.5, max = 1.9, fx = 36, proj = 3})
    elseif lvl == 3 then
    walkAttack(cid, getCreatureTarget(cid), getCreaturePosition(cid), 1, {dmg = COMBAT_FIREDAMAGE, min = 1.9, max = 2.4, fx = 36, proj = 3})
	end
	end

setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local lvl = {
[10583] = 0,
[10584] = 1,
[10585] = 2,
[10586] = 3,
}
function onUse(cid, item, frompos, item2, topos)
	-- sistema 15,50201
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
	setPlayerStorageValue(cid,13352,lvl[item.itemid])
	local ret, f = ifSpell(cid, 25,4,50201,isFire)
	if ret and doCombat(cid, combat, var) then
		return  f()
	end
end
