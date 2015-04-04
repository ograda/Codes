local function moveTrain(pos, t, n)
	pos.stackpos = 0
	local dir = doFindItemInPos({}, pos).actionid-9827 == 0 and 3 or 1
	if getTileThingByPos(getPosByDir(pos, dir, 2)).actionid ~= 0 then
		doMoveInArea(pos, dir)
	else
		n = 1
	end
	if t < 3000 then
		addEvent(moveTrain, t, getPosByDir(pos, dir), n == 1 and t*1.5 or t, n)
	end
end

local doMoveInArea(pos, dir)
	for x = pos.x-1, pos.x+1 do
		for y = pos.y-1, pos.y+1 do
			for z = pos.z, pos.z+1 do
				local pos = {x = x, y = y, z = z}
				local thing = getTileItemById(pos, itemId)
				if thing.actionid == 2000 then
					doTeleportThing(thing.uid, getPosByDir(pos, dir), FALSE)
				end
				local creature = getTopCreature(pos).uid
				if creature ~= 0 then
					doTeleportThing(creature, getPosByDir(pos, dir), FALSE)
				end
			end
		end
	end
end

function onUse(cid, item, frompos, itemEx, topos)
	if item.itemid ~= 1945 and item.itemid ~= 1946 then
    	return true
	end
	if frompos.x == .. and frompos.y == .. and frompos.z == .. then
		moveTrain(frompos, 500, 0)
	end
	return true
end