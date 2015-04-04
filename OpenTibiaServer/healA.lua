local heal = createConditionObject(CONDITION_REGENERATION)
setConditionParam(heal, CONDITION_PARAM_TICKS, 25000) -- Minimum damage the condition can do at total
setConditionParam(heal, CONDITION_PARAM_HEALTHTICKS, 1000)
setConditionParam(heal, CONDITION_PARAM_HEALTHGAIN, 10)
setConditionParam(heal, CONDITION_PARAM_MANATICKS, 1000)

function onCastSpell(cid, var)
	local ret,f = ifSpell2(cid,40)
	if not ret then
		return
	end
	if getPlayerStorageValue(cid,54872) <= os.time() then
		doPlayerSendCancel(cid, 'You can\'t use this spell without stop effect and potion effect.')
		return TRUE
	end
	setPlayerStorageValue(cid,54872,os.time()+25)
	doAddCondition(cid, heal)
	f()
	return TRUE
end
