AREA_CROSS5X5 = {
	{0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0},
	{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
	{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0},
	{0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
	{0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0}
}

local function beIced(cid, target, times, speed)
	if not isCreature(target) then
		return
	end
	local cid = isCreature(cid) and cid or 0
	if times == 1 then
		doAreaCombatHealth(cid, COMBAT_ICEDAMAGE, getCreaturePosition(target), 0, -100, -200, 53)
		doChangeSpeed(target, speed)
		return
	end
	doAreaCombatHealth(cid, COMBAT_ICEDAMAGE, getCreaturePosition(target), 0, -2, -2, 52)
	addEvent(beIced, 2000, cid, target, times-1, speed)
end

local combat = createCombatObject()

local area = createCombatArea(AREA_CROSS5X5)
setCombatArea(combat, area)

function onTargetTile(cid, pos)
	local player = getTopCreature(pos).uid
	if player ~= 0 and player ~= cid then
		if isMonster(player) then
			local speed = getCreatureSpeed(player)
			doChangeSpeed(player, -speed+30)
			addEvent(beIced, 2000, cid, player, 5, speed)
		end
	end
	local lvl = getPlayerStorageValue(cid,13339)
   local min, max = getHit(cid, lvl*1.9, lvl*2.3)
	doAreaCombatHealth(cid, COMBAT_ICEDAMAGE, pos, 0, min, max, 41)
end

setCombatCallback(combat, 3, "onTargetTile")
local lvl = {
[10162] = 0,
[10163] = 1,
[10164] = 2,
[10165] = 3,
}
function onUse(cid, item, frompos, item2, topos)
	setPlayerStorageValue(cid,13332,lvl[item.itemid])
	if SPELLS then
		doTransformItem(item.uid,lvl[item.itemid] == 3 and item.itemid-3 or item.itemid+1)
	end
	if not lvl[item.itemid] or  lvl[item.itemid] == 0 then
		doPlayerSendCancel(cid,'You need learn this spell.')
		return true
	end
	local ret, f = ifSpell2(cid, 500*lvl[item.itemid],20,22211,isIce)
	local var = numberToVariant(cid)
	setPlayerStorageValue(cid,13339,lvl[item.itemid])
	if ret and doCombat(cid, combat, var)then
		return f()
	end
end
