local arvores = {231, 9059, 8315, 8316, 8317, 8318, 8319, 8320, 8321, 8322}

local axe = 8602

local lumbera = 2692

local tronco = arvores
local exhausted = 1200
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
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You are collecting for the first time. Good luck!")
		doSendMagicEffect(getCreaturePosition(cid), math.random(28, 30))
		setPlayerStorageValue(cid, skill1, 1)
		setPlayerStorageValue(cid, tries1, 0)
	elseif skill == 100 then
	else
		if tries > (skill*skill)/40 then
			setPlayerStorageValue(cid, tries1, 0)
			setPlayerStorageValue(cid, skill1, skill+1)
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You advanced to collecting " .. newskill .. ".")
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

function changeBack(param)
	local function doTransformArvore(param, effect, toid)
		local arvore = getTronco(param.topos, {tronco, 2769, 2768})
		doSendMagicEffect(param.topos, effect)
		doTransformItem(arvore.uid, toid)
	end
	doTransformArvore(param, 46, 2769)
	addEvent(doTransformArvore, 20000, param, 45, 2768)
	addEvent(doTransformArvore, 60000, param, 50, param.oldid)
end

function cutTree(cid, topos, number, actionid, item)
	local arvore = getTronco(topos, arvores)
	if math.random(50) >= 48 then
		if arvore ~= 0 then
			doSetItemActionId(arvore.uid, arvore.itemid)
			local param = {topos = topos, oldid = arvore.itemid}
if getPlayerStorageValue(cid, 9982) <= 20 then
			doPlayerAddItem(cid, lumbera, 1)
elseif getPlayerStorageValue(cid, 9982) >= 21 and getPlayerStorageValue(cid, 9982) <= 40 then
			doPlayerAddItem(cid, lumbera, 2)
elseif getPlayerStorageValue(cid, 9982) >= 41 and getPlayerStorageValue(cid, 9982) <= 60 then
			doPlayerAddItem(cid, lumbera, 3)
elseif getPlayerStorageValue(cid, 9982) >= 61 and getPlayerStorageValue(cid, 9982) <= 80 then
			doPlayerAddItem(cid, lumbera, 4)
else
			doPlayerAddItem(cid, lumbera, 5)
end

			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, 'You got sand.')
			addWoodcutting(cid, 9982, 9983)
			addWoodcutting(cid, 9982, 9983)
			addWoodcutting(cid, 9982, 9983)
			exhaustion.set(cid, 25100, 1)
			doSendAnimatedText(topos, "Sand", TEXTCOLOR_DARKRED)
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
			exhaustion.set(cid, 25100, 1)
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
				if math.random(1,100) <= 10 then
doRemoveItem(item.uid, 1)
doPlayerSendCancel(cid, 'Your shovel broken.')
return true
end

				cutTree(cid, topos, 1)
				exhaustion.make(cid, 25100, exhausted)
			else
				doPlayerSendCancel(cid, 'Put the shovel in your hand.')
			end
		else
			doPlayerSendCancel(cid, 'You can\'t [[[CAVAR]]] it.')
		end
	else
		doPlayerSendCancel(cid, 'You already are [[[CAVANDO]]] a tree.')
	end
	return TRUE
end
