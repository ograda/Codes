local function doRemoveIce(pos)
	doSendMagicEffect(pos, 2)
	doRemoveItem(doFindItemInPos({6966}, pos).uid, 1)
end

local combat = createCombatObject()

local paralyze = createConditionObject(CONDITION_PARALYZE)
setConditionParam(paralyze, CONDITION_PARAM_TICKS, 15000)
setConditionFormula(paralyze, -2.5, 0, -2.5, 0)
setCombatCondition(combat, paralyze)

arr = {
{1, 1, 1},
{1, 2, 1},
{1, 1, 1},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onTargetTile(cid, pos)
	if isWalkable(pos, FALSE, TRUE) then
		doCreateItem(6966, 1, pos)
		doSendMagicEffect(pos, 52)

		addEvent(doRemoveIce, 15000, pos)
		local player = getTopCreature(pos).uid
		if player ~= 0 then
			if isPlayer(player) then
				doSetItemOutfit(player, 7307, 15000)
			end
			doAddCondition(player, paralyze)
		end
	end
	return true
end

setCombatCallback(combat, 3, "onTargetTile")

local lvl = {
[10154] = 0,
[10155] = 1,
[10156] = 2,
[10157] = 3,
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
	local ret,f = ifSpell(cid, 460*lvl[item.itemid],nil,nil,isIce)
	if not ret then
		return false
	end
	local pos = getCreaturePosition(cid)
	local var = numberToVariant(cid)
	local var = numberToVariant(cid)
	setPlayerStorageValue(cid,13337,lvl[item.itemid])
	for i = 0, 7 do
		if isWalkable(getPosByDir(pos, i), FALSE, FALSE) then
			f()
			return doCombat(cid, combat, var)
		end
	end
	doPlayerSendDefaultCancel(cid, 2)
	doSendMagicEffect(pos, 2)

	return ret
end
