local combat1 = createCombatObject()
local combat2 = createCombatObject()

arr = {
{0, 0, 1, 1, 1, 0, 0},
{0, 1, 0, 0, 0, 1, 0},
{1, 0, 0, 0, 0, 0, 1},
{1, 0, 0, 2, 0, 0, 1},
{1, 0, 0, 0, 0, 0, 1},
{0, 1, 0, 0, 0, 1, 0},
{0, 0, 1, 1, 1, 0, 0},
}
AREA_CIRCLE3X3 = {
	{0, 0, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 0},
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 3, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1},
	{0, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 0, 0}
}
local area1 = createCombatArea(AREA_CIRCLE3X3)
local area2 = createCombatArea(arr)
setCombatArea(combat1, area1)
setCombatArea(combat2, area2)

function fireblast1(cid, pos)
	local lvl = getPlayerStorageValue(cid,13329)
local min, max = getHit(cid, lvl*2.3, lvl*2.6)
	doAreaCombatHealth(cid, COMBAT_FIREDAMAGE, pos, 0, min-200, max-300, 36)
    doSendDistanceShoot(getCreaturePosition(cid), pos, 40)
end

function fireblast2(cid, pos)
	local time = math.random(2000)
	addEvent(doSendMagicEffect, time + 100, pos, 6)
	addEvent(doSendDistanceShoot, time, getCreaturePosition(cid), pos, 3)
end

setCombatCallback(combat1, CALLBACK_PARAM_TARGETTILE, "fireblast1")
setCombatCallback(combat2, CALLBACK_PARAM_TARGETTILE, "fireblast2")
local lvl = {
[10130] = 0,
[10131] = 1,
[10132] = 2,
[10133] = 3,
}
function onUse(cid, item, frompos, item2, topos)
	if SPELLS then
		doTransformItem(item.uid,lvl[item.itemid] == 3 and item.itemid-3 or item.itemid+1)
	end
	if not lvl[item.itemid] or  lvl[item.itemid] == 0 then
		doPlayerSendCancel(cid,'You need learn this spell.')
		return true
	end
	local ret, f = ifSpell(cid,360*lvl[item.itemid],25,50209,isFire)
	if not ret then
		return ret
	end
	local var = numberToVariant(cid)
	local ret = doCombat(cid, combat2, var)
	if ret then
		local playerPos = getCreaturePosition(cid)
		doSendMagicEffect(playerPos, 5)
		setPlayerStorageValue(cid,13329,lvl[item.itemid])
		doSendAnimatedText(playerPos, "Fire blast", TEXTCOLOR_RED)
		doCombat(cid, combat1, var)
		doCombat(cid, combat2, var)
		f()
	end
	return ret
end
