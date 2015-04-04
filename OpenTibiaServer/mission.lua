function onUse(cid, item, frompos, itemEx, topos)
	if getTopCreature(frompos).uid > 0 then
		return TRUE
	end
	local storage = getPlayerStorageValue(cid, 45454)
	if storage < item.actionid - 9900 then
		if item.actionid == 9900 then
			doPlayerSendCancel(cid, "Sorry, you need permission of Mencelot III.")
		else
			doPlayerSendCancel(cid, "You need to complete the mission number "..(item.actionid - 9900).." to pass.")
		end
	else
		if isItemDoor(item.itemid + 1) == TRUE then
			doTransformItem(item.uid, item.itemid + 1)
		end
		doTeleportThing(cid, frompos, TRUE)
	end
	return TRUE
end