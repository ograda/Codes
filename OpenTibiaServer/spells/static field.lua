local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_CREATEITEM, 1504)

local combat2 = createCombatObject()

local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 20000)
setConditionParam(condition, CONDITION_PARAM_SPEED, -200)
setConditionFormula(condition, -0.9, 0, -0.9, 0)
setCombatCondition(combat1, condition)

arr = {
{0, 0, 1, 1, 1, 0, 0},
{0, 1, 0, 0, 0, 1, 0},
{1, 0, 0, 0, 0, 0, 1},
{1, 0, 0, 2, 0, 0, 1},
{1, 0, 0, 0, 0, 0, 1},
{0, 1, 0, 0, 0, 1, 0},
{0, 0, 1, 1, 1, 0, 0},
}

local area1 = createCombatArea(AREA_CIRCLE3X3)
local area2 = createCombatArea(arr)
setCombatArea(combat1, area1)
setCombatArea(combat2, area2)

function onTargetTile1(cid, pos)
	local effects = {11, 47, 1}
	local lvl = getPlayerStorageValue(cid,13332)
local min, max = getHit(cid, lvl*0.5, lvl*2.0)
	doDelayAttack(cid, math.random(2000), min, max, COMBAT_ENERGYDAMAGE, math.random(#effects), 4, getCreaturePosition(cid), pos)
end

function onTargetTile2(cid, pos)

	addEvent(doSendMagicEffect, 100, pos, 48)
	doSendDistanceShoot(getCreaturePosition(cid), pos, 35)
	doSendDistanceShoot(getCreaturePosition(cid), pos, 37)
end

setCombatCallback(combat1, CALLBACK_PARAM_TARGETTILE, "onTargetTile1")
setCombatCallback(combat2, CALLBACK_PARAM_TARGETTILE, "onTargetTile2")

local lvl = {
[10142] = 0,
[10143] = 1,
[10144] = 2,
[10145] = 3,
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
	local ret,f = ifSpell(cid, 455,1,14071,isEn)
	if not ret then
		return false
	end
	setPlayerStorageValue(cid,13332,lvl[item.itemid])
	local var = numberToVariant(cid)
	local ret = doCombat(cid, combat1, var)
	f()
	for i=1,lvl[item.itemid] do
		addEvent(doCombat,1000*i,cid, combat2, var)
	end
	return ret
end
