local arvores = {5747, 5751, 5752, 5753, 5754, 5866, 5868,
				 5620, 5621, 5622, 5623, 5624, 5708, 5709,
				 15532, 15533, 15534, 15535, 15536, 15537, 15538, 15539,
				 15541, 15542, 15543, 15544, 15545, 15546,
				 15548, 15549, 15550, 15551, 15552, 15553,
				 15555, 15556, 15557, 15558, 15559, 15560, 15561, 15562}

local axe = 2553

local copper = 5880
local tin = 10087
local iron = 15540
local brass = 15547
local silver = 15554
local gold = 15563

local tronco = 15532
local exhausted = 1200
local frases = {"Pock", "Tck", "Crack"}

local function isNear(pos1, pos2)
	if math.abs(pos1.x - pos2.x) <= 1 and math.abs(pos1.y - pos2.y) <= 1 and pos1.z == pos2.z then
		return TRUE
	else
		return FALSE
	end
end

local function addWoodcutting(cid, skill1, tries1)
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
		if tries > (skill*skill)/7 then
			setPlayerStorageValue(cid, tries1, 0)
			setPlayerStorageValue(cid, skill1, skill+1)
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You advanced to collecting " .. newskill .. ".")
			doSendMagicEffect(getCreaturePosition(cid), math.random(28, 30))
		else
			setPlayerStorageValue(cid, tries1, tries+1)
		end
	end
end

local function getTronco(pos, items)
	local found = 0
	local stack = 0
	repeat
		pos.stackpos = stack
		thing = getTileThingByPos(pos)
		if(thing.itemid == 0)then break
		end
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

local function changeTroncoBack(param)
	local function doTransformArvore(param, effect, toid)
		local arvore = getTronco(param.topos, {tronco, 2769, 2768})
	end
end

local function cutTree(cid, topos, number, actionid, item)
	local arvore = getTronco(topos, arvores)
	if math.random(50) >= 48 then
		if arvore ~= 0 then
			doSetItemActionId(arvore.uid, arvore.itemid)
			local param = {topos = topos, oldid = arvore.itemid}


			if thing.itemid == arvores[1] and getPlayerStorageValue(cid, 9982) <= 101 then
			doPlayerAddItem(cid, copper, 1)
			elseif thing.itemid == arvores[2] and getPlayerStorageValue(cid, 9982) <= 101 then
			doPlayerAddItem(cid, copper, 1)
			elseif thing.itemid == arvores[3] and getPlayerStorageValue(cid, 9982) <= 101 then
			doPlayerAddItem(cid, copper, 1)
			elseif thing.itemid == arvores[4] and getPlayerStorageValue(cid, 9982) <= 101 then
			doPlayerAddItem(cid, copper, 1)
			elseif thing.itemid == arvores[5] and getPlayerStorageValue(cid, 9982) <= 101 then
			doPlayerAddItem(cid, copper, 1)
			elseif thing.itemid == arvores[6] and getPlayerStorageValue(cid, 9982) <= 101 then
			doPlayerAddItem(cid, copper, 1)
			elseif thing.itemid == arvores[7] and getPlayerStorageValue(cid, 9982) <= 101 then
			doPlayerAddItem(cid, copper, 1)


			elseif thing.itemid == arvores[8] and getPlayerStorageValue(cid, 9982) <= 101 then
			doPlayerAddItem(cid, tin, 1)
			elseif thing.itemid == arvores[9] and getPlayerStorageValue(cid, 9982) <= 101 then
			doPlayerAddItem(cid, tin, 1)
			elseif thing.itemid == arvores[10] and getPlayerStorageValue(cid, 9982) <= 101 then
			doPlayerAddItem(cid, tin, 1)
			elseif thing.itemid == arvores[11] and getPlayerStorageValue(cid, 9982) <= 101 then
			doPlayerAddItem(cid, tin, 1)
			elseif thing.itemid == arvores[12] and getPlayerStorageValue(cid, 9982) <= 101 then
			doPlayerAddItem(cid, tin, 1)
			elseif thing.itemid == arvores[13] and getPlayerStorageValue(cid, 9982) <= 101 then
			doPlayerAddItem(cid, tin, 1)
			elseif thing.itemid == arvores[14] and getPlayerStorageValue(cid, 9982) <= 101 then
			doPlayerAddItem(cid, tin, 1)


			elseif getPlayerStorageValue(cid, 9982) >= 15 and thing.itemid == arvores[15] then
			doPlayerAddItem(cid, iron, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 24 and thing.itemid == arvores[15] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 15 and thing.itemid == arvores[16] then
			doPlayerAddItem(cid, iron, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 24 and thing.itemid == arvores[16] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 15 and thing.itemid == arvores[17] then
			doPlayerAddItem(cid, iron, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 24 and thing.itemid == arvores[17] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 15 and thing.itemid == arvores[18] then
			doPlayerAddItem(cid, iron, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 24 and thing.itemid == arvores[18] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 15 and thing.itemid == arvores[19] then
			doPlayerAddItem(cid, iron, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 24 and thing.itemid == arvores[19] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 15 and thing.itemid == arvores[20] then
			doPlayerAddItem(cid, iron, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 24 and thing.itemid == arvores[20] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 15 and thing.itemid == arvores[21] then
			doPlayerAddItem(cid, iron, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 24 and thing.itemid == arvores[21] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 15 and thing.itemid == arvores[22] then
			doPlayerAddItem(cid, iron, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 24 and thing.itemid == arvores[22] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')



			elseif getPlayerStorageValue(cid, 9982) >= 25 and thing.itemid == arvores[23] then
			doPlayerAddItem(cid, brass, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 44 and thing.itemid == arvores[23] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 25 and thing.itemid == arvores[24] then
			doPlayerAddItem(cid, brass, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 44 and thing.itemid == arvores[24] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 25 and thing.itemid == arvores[25] then
			doPlayerAddItem(cid, brass, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 44 and thing.itemid == arvores[25] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 25 and thing.itemid == arvores[26] then
			doPlayerAddItem(cid, brass, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 44 and thing.itemid == arvores[26] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 25 and thing.itemid == arvores[27] then
			doPlayerAddItem(cid, brass, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 44 and thing.itemid == arvores[27] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 25 and thing.itemid == arvores[28] then
			doPlayerAddItem(cid, brass, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 44 and thing.itemid == arvores[28] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')




			elseif getPlayerStorageValue(cid, 9982) >= 45 and thing.itemid == arvores[29] then
			doPlayerAddItem(cid, silver, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 84 and thing.itemid == arvores[29] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 45 and thing.itemid == arvores[30] then
			doPlayerAddItem(cid, silver, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 84 and thing.itemid == arvores[30] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 45 and thing.itemid == arvores[31] then
			doPlayerAddItem(cid, silver, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 84 and thing.itemid == arvores[31] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 45 and thing.itemid == arvores[32] then
			doPlayerAddItem(cid, silver, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 84 and thing.itemid == arvores[32] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 45 and thing.itemid == arvores[33] then
			doPlayerAddItem(cid, silver, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 84 and thing.itemid == arvores[33] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 45 and thing.itemid == arvores[34] then
			doPlayerAddItem(cid, silver, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 84 and thing.itemid == arvores[34] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')




			elseif getPlayerStorageValue(cid, 9982) >= 85 and thing.itemid == arvores[35] then
			doPlayerAddItem(cid, gold, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 101 and thing.itemid == arvores[35] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 85 and thing.itemid == arvores[36] then
			doPlayerAddItem(cid, gold, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 101 and thing.itemid == arvores[36] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 85 and thing.itemid == arvores[37] then
			doPlayerAddItem(cid, gold, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 101 and thing.itemid == arvores[37] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 85 and thing.itemid == arvores[38] then
			doPlayerAddItem(cid, gold, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 101 and thing.itemid == arvores[38] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 85 and thing.itemid == arvores[39] then
			doPlayerAddItem(cid, gold, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 101 and thing.itemid == arvores[39] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 85 and thing.itemid == arvores[40] then
			doPlayerAddItem(cid, gold, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 101 and thing.itemid == arvores[40] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 85 and thing.itemid == arvores[41] then
			doPlayerAddItem(cid, gold, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 101 and thing.itemid == arvores[41] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			elseif getPlayerStorageValue(cid, 9982) >= 85 and thing.itemid == arvores[42] then
			doPlayerAddItem(cid, gold, 1)
			elseif getPlayerStorageValue(cid, 9982) <= 101 and thing.itemid == arvores[42] then
			doPlayerSendCancel(cid, 'You don\'t have enought level.')
			end

			addEvent(changeTroncoBack, 5000, param)
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, 'You got ore.')
			addWoodcutting(cid, 9982, 9983)
			addWoodcutting(cid, 9982, 9983)
			addWoodcutting(cid, 9982, 9983)
			exhaustion.set(cid, 25100, 1)
			doSendAnimatedText(topos, "Ore!", 98)
			doSendMagicEffect(topos, 34)
			doSendMagicEffect(topos, 3)
		end
		

		
	else
		if isPlayer(cid) == TRUE and number < 10 and arvore ~= 0 and isNear(getCreaturePosition(cid), topos) == TRUE then
			addEvent(cutTree, 1000, cid, topos, number+1)
			doSendAnimatedText(topos, frases[math.random(#frases)], 21)
			doSendMagicEffect(topos, 34)
		else
			addWoodcutting(cid, 9982, 9983)
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, 'You haven\'t yet found.')
			exhaustion.set(cid, 25100, 1)
			doSendMagicEffect(getCreaturePosition(cid), 2)
		end
	end
end

function onUse(cid, item, frompos, itemEx, topos)
if getPlayerStorageValue(cid, collector) == 1 then

if getPlayerStorageValue(cid, 9982) >= 1 then
	if exhaustion.check(cid, 25100) == FALSE then
		local axe1 = getPlayerSlotItem(cid,5)
		local axe2 = getPlayerSlotItem(cid,6)
		if isInArray(arvores, itemEx.itemid) == TRUE then
			if axe1.itemid == axe or axe2.itemid == axe then
				if math.random(1,100) <= 10 then
doRemoveItem(item.uid, 1)
doPlayerSendCancel(cid, 'Your pick broken.')
return true
end

				cutTree(cid, topos, 1)
				exhaustion.make(cid, 25100, exhausted)
			else
				doPlayerSendCancel(cid, 'Put the pick in your hand.')
			end
		else
			doPlayerSendCancel(cid, 'You can\'t collect it.')
		end
	else
		doPlayerSendCancel(cid, 'You are already collecting.')
	end
else
		doPlayerSendCancel(cid, 'You don\'t have enought level to that ore.')
end

else
		doPlayerSendCancel(cid, 'Only collectors may execute this.')
end
	return TRUE
end
