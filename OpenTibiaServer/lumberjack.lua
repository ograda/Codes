local arvores = {2700, 2701, 2707, 2712, 8313}
local axe = 2386
local lumber = 5901
local tronco = 8786
local exhausted = 12
local frases = {"Pock", "Tck", "Pec"}

function isNear(pos1, pos2)
	if math.abs(pos1.x - pos2.x) <= 1 and math.abs(pos1.y - pos2.y) <= 1 and pos1.z == pos2.z then
		return TRUE
	else
		return FALSE
	end
end

function addWoodcutting(cid, skill1, tries1)
	local skill = getPlayerStorageValue(cid, skill1)
	local tries = getPlayerStorageValue(cid, tries1)
	local newskill = skill+1
	if skill == -1 then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You are woodcutting for the first time. Good luck!")
		doSendMagicEffect(getCreaturePosition(cid), math.random(28, 30))
		setPlayerStorageValue(cid, skill1, 10)
		setPlayerStorageValue(cid, tries1, 0)
	else
		if tries > (skill*skill)/30 then
			setPlayerStorageValue(cid, tries1, 0)
			setPlayerStorageValue(cid, skill1, skill+1)
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You advanced to woodcutting " .. newskill .. ".")
			doSendMagicEffect(getCreaturePosition(cid), math.random(28, 30))
		else
			setPlayerStorageValue(cid, tries1, tries+1)
		end
	end
end

function getTronco(pos, items)
	local found = 0
	local stack = 0
	repeat
		pos.stackpos = stack
		thing = getTileThingByPos(pos)
		if(thing.itemid == 0)then break end
		if(isInArray(items, thing.itemid) == TRUE)then
			found = 1
			break
		end
		stack = stack + 1
	until (found == 1 or stack > 20)
	if stack > 20 then
		return 0
	else
		return thing
	end
end

function changeTroncoBack(param)
	local function doTransformArvore(param, effect, toid)
		local arvore = getTronco(param.topos, {tronco, 2769, 2768})
		doSendMagicEffect(param.topos, effect)
		doTransformItem(arvore.uid, toid)
	end
	doTransformArvore(param, 46, 2769)
	addEvent(doTransformArvore, 20000, param, 45, 2768)
	addEvent(doTransformArvore, 60000, param, 50, param.oldid)
end

function cutTree(cid, topos, number, actionid)
	local arvore = getTronco(topos, arvores)
	if math.random(50) >= 48 then
		if arvore ~= 0 then
			doSetItemActionId(arvore.uid, arvore.itemid)
			local param = {topos = topos, oldid = arvore.itemid}
			doTransformItem(arvore.uid, tronco)
			doPlayerAddItem(cid, lumber, 1)
			addEvent(changeTroncoBack, 5000, param)
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, 'You got lumber.')
			addWoodcutting(cid, 9982, 9983)
			addWoodcutting(cid, 9982, 9983)
			addWoodcutting(cid, 9982, 9983)
			exhaustion.set(cid, 25100, 0)
			doSendAnimatedText(topos, "Wood", TEXTCOLOR_DARKRED)
			doSendMagicEffect(topos, 16)
			doSendMagicEffect(topos, 8)
			doSendMagicEffect(topos, 3)
		end
	else
		if isPlayer(cid) == TRUE and number < 10 and arvore ~= 0 and isNear(getCreaturePosition(cid), topos) == TRUE then
			addEvent(cutTree, 1000, cid, topos, number+1)
			doSendAnimatedText(topos, frases[math.random(#frases)], TEXTCOLOR_LIGHTGREEN)
			doSendMagicEffect(topos, 16)
		else
			addWoodcutting(cid, 9982, 9983)
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, 'You can\'t find yet.')
			exhaustion.set(cid, 25100, 0)
			doSendMagicEffect(getCreaturePosition(cid), 2)
		end
	end
end

function onUse(cid, item, frompos, itemEx, topos)
	if exhaustion.check(cid, 25100) == FALSE then
		local axe1 = getPlayerSlotItem(cid,5)
		local axe2 = getPlayerSlotItem(cid,6)
		if isInArray(arvores, itemEx.itemid) == TRUE then
			if axe1.itemid == axe or axe2.itemid == axe then
				cutTree(cid, topos, 1)
				exhaustion.make(cid, 25100, exhausted)
			else
				doPlayerSendCancel(cid, 'Put the axe in your hand.')
			end
		else
			doPlayerSendCancel(cid, 'You can\'t cut it.')
		end
	else
		doPlayerSendCancel(cid, 'You already are cutting a tree.')
	end
	return TRUE
end
