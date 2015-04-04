local RAILS = {7121, 7122, 7123, 7124, 7125, 7126, 7127, 7128, 7129, 7130}
local CART = {[0] = 10044, [2] = 10044, [3] =10043, [1] =10043}
local SPEED = 200
local CONFIG = {
	[7121] = 0,
	[7122] = 0,
	[7123] = {EAST, SOUTH},
	[7124] = {WEST, SOUTH},
	[7125] = {EAST, NORTH},
	[7126] = {WEST, NORTH},
	[7127] = 0,--{WEST, NORTH, true},
	[7128] = 0,--{WEST, SOUTH, true},
	[7129] = 0,--{WEST, NORTH, true},
	[7130] = 0,--{EAST, NORTH, true}
}
local reverse = {[0] = 2, 3, 0, 1}

function getRail(items, position)
	local pos = {x=position.x, y=position.y, z=position.z}
	for i = 0, 255 do
		pos.stackpos = i
		local thing = getTileThingByPos(pos)
		if(thing.itemid == 0)then return false end
		if isInArray(items, thing.itemid) then
			return thing.itemid
		end
	end
	return false
end

local function moveTrain(cid, frompos, dir)
	if isPlayer(cid) then
		local pos = getCreaturePosition(cid)
		local rail = getRail(RAILS, pos)
		if not rail then
			doPlayerSetNoMove(cid, false)
			doRemoveCondition(cid, CONDITION_OUTFIT)
			doChangeSpeed(cid, -250)
			doMoveCreature(cid, dir)
		else
			local info = CONFIG[rail]
			if info ~= 0 and info then
				dir = (info[3] and math.random(2) == 1) and dir or info[info[1] == reverse[dir] and 2 or 1]
			end
			doMoveCreature(cid, dir)
			doSetItemOutfit(cid, CART[dir], -1)
			addEvent(moveTrain, SPEED, cid, pos, dir)
		end
	end
end

function onUse(cid, item, frompos)
	if (item.actionid < 500 and item.actionid > 503) or getCreatureCondition(cid, CONDITION_OUTFIT) then
		return false
	end
	doTeleportThing(cid, frompos, false)
	doPlayerSetNoMove(cid, true)
    doChangeSpeed(cid, 250)
	addEvent(moveTrain, SPEED, cid, frompos, item.actionid-500)
	return true
end
