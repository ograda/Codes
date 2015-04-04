local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, 47)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 27)
AREA_BEAM1 = {
	{3}
}

local area = createCombatArea(AREA_BEAM1)
setCombatArea(combat, area)

local atkarea = {
	{1,4,6},
	{5,8,2},
	{7,9,3}
}

local function getDistanceBetween(pos1, pos2)
	local xDif = math.abs(pos1.x - pos2.x)
	local yDif = math.abs(pos1.y - pos2.y)

	return (pos1.x == pos2.x and xDif or yDif)
end

local function massShooting(pos, area)
	local centro = {}
	local result = {}
	centro.y = math.floor(table.getn(area)/2)+1
	for y = 1, table.getn(area) do
		for x = 1, table.getn(area[y]) do
			number = area[y][x]
			if number > 0 then
				centro.x = math.floor(table.getn(area[y])/2)+1
				local atkpos = {x = pos.x + x - centro.x, y = pos.y + y - centro.y, z = pos.z}
				result[number] = atkpos
			end
		end
	end
	return result
end

local function doLongPush(frompos, pos, number)
	if number < 5 and isWalkable(pos, FALSE, TRUE) then
		doPushCreature(frompos, pos, FALSE)
		doSendMagicEffect(pos, 34)
		addEvent(doLongPush, 150, pos, getPosByDir(pos, getDirectionTo(frompos, pos)), number+1)
	end
end

function onThunderBolt(cid, pos)
	local pos = getCreaturePosition(cid)
	local target = getCreatureTarget(cid)
	local atkpos = getCreaturePosition(target)
	local near = getPosByDir(atkpos, getDirectionTo(atkpos, pos), 1)
	doSendDistanceShoot(pos, near, 30)
	doSendMagicEffect(near, 48)
	local shoots = massShooting(atkpos, atkarea)
	for i = 1, #shoots do
		if i ~= #shoots then
			addEvent(doSendDistanceShoot, i*100, shoots[i], shoots[i+1], 37)
			addEvent(doSendDistanceShoot, i*100+150, shoots[#shoots-i], shoots[#shoots-i], 37)
			addEvent(doSendDistanceShoot, i*100+300, shoots[i], shoots[i+1], 37)
			addEvent(doSendDistanceShoot, i*100+450, shoots[#shoots-i], shoots[#shoots-i], 37)
			addEvent(doSendDistanceShoot, i*100+600, shoots[i], shoots[i+1], 32)
		else
			local function event()
				if isCreature(cid) == TRUE then
						local lvl = getPlayerStorageValue(cid,27384)
				       	local min, max = getHit(cid, lvl*1.0, lvl*1.9)
	                	doAreaCombatHealth(cid, COMBAT_ENERGYDAMAGE, atkpos, 1, min, max, 37)
					doSendMagicEffect(atkpos, 40)
					doLongPush(pos, atkpos, 1)
				end
			end
			addEvent(event, #shoots*100+700)
		end
	end
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onThunderBolt")

local lvl = {
[10206] = 0,
[10207] = 1,
[10208] = 2,
[10209] = 3,
}
function onUse(cid, item, frompos, item2, topos)
	-- sistema
	if SPELLS then
			doTransformItem(item.uid,lvl[item.itemid] == 3 and item.itemid-3 or item.itemid+1)
	end
	if not lvl[item.itemid] or  lvl[item.itemid] == 0 then
		doPlayerSendCancel(cid,'You need learn this spell.')
		return true
	end
		local pos = getCreaturePosition(cid)
	if getCreatureTarget(cid) == 0 then
		doPlayerSendCancel(cid,'You can only use it on creatures.')
		doSendMagicEffect(pos, 2)
		return true
	end
	local pos, target = getCreaturePosition(cid), getCreaturePosition(getCreatureTarget(cid))
	if pos.x ~= target.x and pos.y ~= target.y then
		doPlayerSendCancel(cid, "Stand in front of your target.")
		return false
	end
	setPlayerStorageValue(cid,27384,lvl[item.itemid])
	local var = numberToVariant(getCreatureTarget(cid))
	local ret,f = ifSpell(cid, 160*lvl[item.itemid],10,23211,isEn)
	if ret then
		f()
		if doCombat(cid, combat, var) then
			--doThunder(cid, pos, getPosByDir(pos, getPlayerLookDir(cid)), getPlayerLookDir(cid), 1, -50, -50, 1)
			return
		end
	end
end
