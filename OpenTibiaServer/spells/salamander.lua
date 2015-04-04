function doSalamander(cid, pos, number,walk)
	if cid > 0 then
		if number < walk then
			local dir = getPlayerLookDir(cid)
			local newpos = {
			[0] = {x=pos.x, y=pos.y-1, z=pos.z},
			[1] = {x=pos.x+1, y=pos.y, z=pos.z},
			[2] = {x=pos.x, y=pos.y+1, z=pos.z},
			[3] = {x=pos.x-1, y=pos.y, z=pos.z}
			}
			doAreaCombatHealth(cid, COMBAT_EARTHDAMAGE, newpos[dir], 0, -250, -300, 20)
			addEvent(doSalamander, 200,cid, newpos[dir], number+1,walk)
		else
			setPlayerStorageValue(cid, 4004, 0)
			doPlayerSendTextMessage(cid, 24, "Your salamander has stopped.")
		end
	end
end
local lvl = {
[10102] = 0,
[10103] = 1,
[10104] = 2,
[10105] = 3,
}
local walkes = {20,35,50}
function onUse(cid, item, frompos, item2, topos)
	if SPELLS then
		doTransformItem(item.uid,lvl[item.itemid] == 3 and item.itemid-3 or item.itemid+1)
	end
	if not lvl[item.itemid] or  lvl[item.itemid] == 0 then
		doPlayerSendCancel(cid,'You need learn this spell.')
		return true
	end
	local ret,f = ifSpell(cid, 230,((walkes[lvl[item.itemid]]*200)/1000)+20,13732,isEa)
	if not ret then
		return false
	end
	local walk = walkes[lvl[item.itemid]]
	doAddCondition(cid, salamander)
	doSalamander(cid, getPlayerLookPos(cid), 1,walk)
	f()
	doSendAnimatedText(getCreaturePosition(cid),'Salamander',math.random(0,255))
	return true
end
