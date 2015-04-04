local function doBridge(fpos, tpos, rpos, teleport)
	for x = fpos.x, tpos.x do
		for y = fpos.y, tpos.y do
			local pos = {x = x, y = y, z = fpos.z, stackpos = 0}
			local id = getTileThingByPos(pos)
			if id.uid > 0 and id.actionid ~= 0 then
				doTransformItem(id.uid, id.actionid)
				doSetItemActionId(id.uid, id.itemid)
				local cid = getTopCreature(pos).uid
				if teleport ~= 0 and teleport ~= nil and cid > 0 then
					doTeleportThing(cid, rpos, TRUE)
					doSendMagicEffect(rpos, 10)
				end
			end
			local lever1 = getTileItemById(pos, 1945).uid
			local lever2 = getTileItemById(pos, 1946).uid
			if lever1 ~= 0 then
				doTransformItem(lever1, 1946)
			end
			if lever2 ~= 0 then
				doTransformItem(lever2, 1945)
			end
		end
	end
end

function onUse(cid, item, pos)
	if item.itemid ~= 1945 then
		doPlayerSendCancel(cid, "Sorry, not possible.")
		return TRUE
	end
	local fpos = {x = pos.x-5, y = pos.y-5, z = pos.z}
	local tpos = {x = pos.x+5, y = pos.y+5, z = pos.z}
	doBridge(fpos, tpos, pos)
	addEvent(doBridge, 5000, fpos, tpos, pos, TRUE)
	return LUA_NO_ERROR
end