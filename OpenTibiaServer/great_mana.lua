local MIN = 400
local MAX = 800
local EMPTY_POTION = 11656

local exhaust = createConditionObject(CONDITION_EXHAUST)
setConditionParam(exhaust, CONDITION_PARAM_TICKS, (getConfigInfo('timeBetweenExActions') - 100))
function onUse(cid, item, fromPosition, itemEx, toPosition)
	itemEx.uid = cid
	if isPlayer(itemEx.uid) == FALSE then
		return FALSE
	end
	if hasCondition(cid, CONDITION_EXHAUST_HEAL) == TRUE then
		doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
		return TRUE
	end
	local m = math.random(MIN, MAX)
	doPlayerAddMana(itemEx.uid,m)
	doCreatureAddHealth(itemEx.uid,m)
	doSendAnimatedText(getThingPos(itemEx.uid),'B +'..m,177)
	doAddCondition(itemEx.uid, exhaust)
	doSendMagicEffect(getThingPos(itemEx.uid), CONST_ME_MAGIC_BLUE)
	doCreatureSay(itemEx.uid, "Aaaah...", TALKTYPE_ORANGE_1)
	doTransformItem(item.uid, EMPTY_POTION)
	return TRUE
end

