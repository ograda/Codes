local time = 20*60*1000

local inv = createConditionObject(CONDITION_INVISIBLE)
setConditionParam(inv, CONDITION_PARAM_TICKS, time)
 
function onUse(cid, item)
	doAddCondition(cid, inv)
	doSendMagicEffect(getPlayerPosition(cid), 49)
	doSendAnimatedText(getPlayerPosition(cid), "invisible", math.random(1,200))
	doRemoveItem(item.uid, 1)
 return 1
end

