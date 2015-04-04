local time = 15*60*1000

local speed = createConditionObject(CONDITION_HASTE)
setConditionParam(speed, CONDITION_PARAM_TICKS, time)
setConditionFormula(speed, 1.0, 0, 1.5, 0)

 
function onUse(cid, item)
	doAddCondition(cid, speed)
	doSendMagicEffect(getPlayerPosition(cid), 49)
	doSendAnimatedText(getPlayerPosition(cid), "haste", math.random(1,200))
	doRemoveItem(item.uid, 1)
 return 1
end

