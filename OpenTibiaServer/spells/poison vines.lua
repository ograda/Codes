local poison = createConditionObject(CONDITION_POISON)
setConditionParam(poison, CONDITION_PARAM_DELAYED, TRUE)
setConditionParam(poison, CONDITION_PARAM_MINVALUE, -80)
setConditionParam(poison, CONDITION_PARAM_MAXVALUE, -80)
setConditionParam(poison, CONDITION_PARAM_STARTVALUE, -10)
setConditionParam(poison, CONDITION_PARAM_TICKINTERVAL, 800)
setConditionParam(poison, CONDITION_PARAM_FORCEUPDATE, TRUE)

local function poisonWalk(cid, pos, dir, number)
	local cid = isCreature(cid) and cid or 0
	if number <= 7 then
		local nextpos = getPosByDir(pos, dir)
		local lvl = getPlayerStorageValue(cid,13348)
       	local min, max = getHit(cid, lvl*2, lvl*2.5)
		doAreaCombatHealth(cid, 4, nextpos, 0, min, max, 8)
		doAreaCombatCondition(cid, nextpos, 0, poison, CONST_ME_NONE)
		if isWalkable(nextpos, FALSE, TRUE) == TRUE then
			for i = 0, 3 do
				doSendDistanceShoot(getPosByDir(pos, i), nextpos, 38)
			end
			addEvent(poisonWalk, 50, cid, nextpos, dir, number+1)
		end
	end
end

local combat = createCombatObject()

function onTargetTile(cid, pos)
    poisonWalk(cid, getCreaturePosition(cid), getPlayerLookDir(cid), 1)

end

setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

local lvl ={
[10194] = 0,
[10195] = 1,
[10196] = 2,
[10197] = 3,
}
function onUse(cid, item, frompos, item2, topos)
	-- sistema
	if SPELLS then
			doTransformItem(item.uid,lvl[item.itemid] == 3 and item.itemid-3 or item.itemid+1)
	end
	local pos = getCreaturePosition(cid)
	if not lvl[item.itemid] or  lvl[item.itemid] == 0 then
		doPlayerSendCancel(cid,'You need learn this spell.')
		return true
	end
	setPlayerStorageValue(cid,13348,lvl[item.itemid])

	local ret, f = ifSpell(cid, 70*(lvl[item.itemid]/2),2,3111,isEa)
	if not ret then
		return false
	end
	if ret  then
		poisonWalk(cid, getCreaturePosition(cid), getPlayerLookDir(cid), 1)
		--doCombat(cid, combat,  numberToVariant((cid)))
		f()
		return
	end
end
