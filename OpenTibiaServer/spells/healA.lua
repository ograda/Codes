local heal1 = createConditionObject(CONDITION_REGENERATION)
setConditionParam(heal1, CONDITION_PARAM_TICKS, 42000) -- Minimum damage the condition can do at total
setConditionParam(heal1, CONDITION_PARAM_HEALTHTICKS, 1000)
setConditionParam(heal1, CONDITION_PARAM_HEALTHGAIN, 5)
local heal2 = createConditionObject(CONDITION_REGENERATION)
setConditionParam(heal2, CONDITION_PARAM_TICKS, 49000) -- Minimum damage the condition can do at total
setConditionParam(heal2, CONDITION_PARAM_HEALTHTICKS, 1000)
setConditionParam(heal2, CONDITION_PARAM_HEALTHGAIN, 10)
local heal3 = createConditionObject(CONDITION_REGENERATION)
setConditionParam(heal3, CONDITION_PARAM_TICKS, 50000) -- Minimum damage the condition can do at total
setConditionParam(heal3, CONDITION_PARAM_HEALTHTICKS, 1000)
setConditionParam(heal3, CONDITION_PARAM_HEALTHGAIN, 15)


local lvl = {
[10575] = 0,
[10576] = 1,
[10577] = 2,
[10578] = 3,
}
function onUse(cid, item, frompos, item2, topos)
	if SPELLS then
		doTransformItem(item.uid,lvl[item.itemid] == 3 and item.itemid-3 or item.itemid+1)
	end
	if not lvl[item.itemid] or  lvl[item.itemid] == 0 then
		doPlayerSendCancel(cid,'You need learn this spell.')
		return true
	end
	local ret,f = ifSpell2(cid,40,5*lvl[item.itemid],12345)
	if not ret then
		return
	end
	if getPlayerStorageValue(cid,54872) > os.time() then
		doPlayerSendCancel(cid, 'You can\'t use this spell without stop effect and potion effect.')
		return TRUE
	end

	if lvl[item.itemid] == 1 then
		doAddCondition(cid, heal1)
		setPlayerStorageValue(cid,54872,os.time()+42)
	elseif lvl[item.itemid] == 2 then
		doAddCondition(cid, heal2)
		setPlayerStorageValue(cid,54872,os.time()+49)
	else
		doAddCondition(cid, heal3)
		setPlayerStorageValue(cid,54872,os.time()+51)
	end
	doSendMagicEffect(getCreaturePosition(cid), 12)
	f()
	return TRUE
end
