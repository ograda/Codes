local time = 18*60*1000

local condition = createConditionObject(CONDITION_ATTRIBUTES)

setConditionParam(condition, CONDITION_PARAM_BUFF, true)
setConditionParam(condition, CONDITION_PARAM_TICKS, time)
setConditionParam(condition, 
CONDITION_PARAM_SKILL_SHIELD, 15)



 
function onUse(cid, item)
	doAddCondition(cid, condition)
	doSendMagicEffect(getPlayerPosition(cid), 49)
	doSendAnimatedText(getPlayerPosition(cid), "Blessed", math.random(1,200))
	doRemoveItem(item.uid, 1)
 return 1
end

