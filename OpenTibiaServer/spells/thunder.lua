local combat = createCombatObject()

arr = {
{0, 0, 1, 1, 1, 0, 0},
{0, 1, 1, 1, 1, 1, 0},
{1, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 3, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 1},
{0, 1, 1, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 0, 0},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function doThunder(cid, min, max, effect, frompos, pos)
	doSendMagicEffect(frompos, 40)
	addEvent(doSendDistanceShoot, 150, frompos, pos, 32)
	addEvent(doAreaCombatHealth, 300, cid, COMBAT_ENERGYDAMAGE, pos, 0, min, max, effect)
end

function onTargetTile(cid, pos)
	local lvl = getPlayerStorageValue(cid,13331)
	local efeitos = {11, 11, 47, 47, 48}
	local frompos = {x=pos.x-2, y=pos.y-3, z=pos.z}
    local min, max = getHit(cid, lvl*1.8, lvl*2.2)
	for i = 1, lvl+1 do
		addEvent(doThunder, (math.random(4)*250)*i, cid, min, max, 1, frompos, pos)
	end
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")
local lvl = {
[10138] = 0,
[10139] = 1,
[10140] = 2,
[10141] = 3,
}
function onUse(cid, item, frompos, item2, topos)
	if SPELLS then
		doTransformItem(item.uid,lvl[item.itemid] == 3 and item.itemid-3 or item.itemid+1)
	end
	if not lvl[item.itemid] or  lvl[item.itemid] == 0 then
		doPlayerSendCancel(cid,'You need learn this spell.')
		return true
	end
	setPlayerStorageValue(cid,13331,lvl[item.itemid])
	local ret,f = ifSpell(cid, 420*lvl[item.itemid],20,1231,isEn)
	if not ret then
		return false
	end
	local var = numberToVariant(cid)

	local ret = doCombat(cid, combat, var)
	if ret then

		doSendAnimatedText(getCreaturePosition(cid), "Thunder", TEXTCOLOR_TEAL)
		f()
	end
	return ret
end
