function onUse(cid, item, frompos, itemEx, topos)
	local pos = getCreaturePosition(cid)
	if pos.x == frompos.x+1 and pos.y == frompos.y then
		pos.z = item.actionid == 9921 and pos.z-4 or pos.z+4
		doTeleportThing(cid, pos, FALSE)
		doSendMagicEffect(pos, 10)
		doSendMagicEffect(topos, 2)
	end
	return TRUE
end