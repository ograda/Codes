local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, 13)

local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 20000)
setConditionParam(condition, CONDITION_PARAM_SPEED, -200)
setConditionFormula(condition, -0.9, 0, -0.9, 0)
setCombatCondition(combat, condition)

local function event(cid, target, hit,lvl,aa)
	local hit = -math.abs(hit)
	if isCreature(cid) and isCreature(target) then
		local percent = getCreatureMaxHealth(target)/5
		local hit = (hit < -percent and -math.random(percent*0.6, percent*lvl) or hit)
		doAreaCombatHealth(cid, COMBAT_POISONDAMAGE, getCreaturePosition(target), 0, hit, hit-30, 8)
		doSendMagicEffect(getCreaturePosition(target), 16)
		aa = aa -1
		if aa == 0 then
			return
		end
		addEvent(event, 1500, cid, target, hit*((10+math.random(2, 7))/10),lvl,aa)
	else
		if isCreature(cid) then
			exhaustion.set(cid, 4006, 0)
		end
	end
end

function onTargetTile(cid, pos)
	doSendDistanceShoot(getCreaturePosition(cid), pos, 38)
	local lvl = getPlayerStorageValue(cid,13330)
	local t = {5,8,10}
	addEvent(event, 300, cid, getCreatureTarget(cid), getPlayerMagLevel(cid),lvl,t[lvl])
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")
local lvl = {
[10134] = 0,
[10135] = 1,
[10136] = 2,
[10137] = 3,
}
function onUse(cid, item, frompos, item2, topos)
	if SPELLS then
		doTransformItem(item.uid,lvl[item.itemid] == 3 and item.itemid-3 or item.itemid+1)
	end
	local pos = getCreaturePosition(cid)
	if not lvl[item.itemid] or  lvl[item.itemid] == 0 then
		doPlayerSendCancel(cid,'You need learn this spell.')
		return true
	end
	if getCreatureTarget(cid) == 0 then
		doPlayerSendCancel(cid,'You can only use it on creatures.')
		doSendMagicEffect(pos, 2)
		return true
	end
	maxmana = 1
	local ret, f = ifSpell(cid,855,25,4004,isEa)
	if not ret then
		return false
	end
	local var = numberToVariant(getCreatureTarget(cid))
	setPlayerStorageValue(cid,13330,lvl[item.itemid])
	if doCombat(cid, combat, var) then
		f()
	end
	return false
end
