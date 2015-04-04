local effects1 = {36, 33, 37, 38, 36}
local effects2 = {41, 36, 39, 8, 41}local lvl = {
[10158] = 0,
[10159] = 1,
[10160] = 2,
[10161] = 3
}

local function iceAttack(cid, pos, dir, number, effect, delay,lvl)
	if number <= 7 then
	local min, max = -(lvl*(getPlayerLevel(cid)+3*getPlayerMagLevel(cid)))*1.1, -(lvl*(getPlayerLevel(cid)+3*getPlayerMagLevel(cid)))*1.3	local nextpos = getPosByDir(pos, dir, 1)
		doAreaCombatHealth(cid, 1, pos, 0, min, max, effects2[effect])
		if isWalkable(nextpos, FALSE, TRUE) == TRUE then
			doSendDistanceShoot(pos, nextpos, effects1[effect])
			addEvent(iceAttack, delay, cid, nextpos, dir, number+1, (effect >= #effects1 and 1 or effect+(getTopCreature(pos).uid > 0 and 1 or 0)), delay*0.6,lvl)
		end
	end
end

local combat = createCombatObject()

function onUse(cid, item, frompos, item2, topos)
	if SPELLS then
		doTransformItem(item.uid,lvl[item.itemid] == 3 and item.itemid-3 or item.itemid+1)
	end
	if not lvl[item.itemid] or  lvl[item.itemid] == 0 then
		doPlayerSendCancel(cid,'You need learn this spell.')
		return true
	end
	local ret, f = ifSpell2(cid, 95*lvl[item.itemid],6,18199,isIce)
	if not ret then
		return false
	end
	local var = numberToVariant(cid)
	if doCombat(cid, combat, var) then
		iceAttack(cid, getPlayerLookPos(cid), getPlayerLookDir(cid), 1, 1, 500,lvl[item.itemid])
		f()
	end

	return ret
end
