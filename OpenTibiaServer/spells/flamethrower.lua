function doFlamethrower(cid, pos, number,l)
	if cid > 0 then
		if number < 30*(l/2) then
			local dir = getPlayerLookDir(cid)
			local newpos = {
				[0] = {x=pos.x, y=pos.y-1, z=pos.z},
				[1] = {x=pos.x+1, y=pos.y, z=pos.z},
				[2] = {x=pos.x, y=pos.y+1, z=pos.z},
				[3] = {x=pos.x-1, y=pos.y, z=pos.z}
			}
			local min, max = getHit(cid, l*1.2, l*1.5)
			doAreaCombatHealth(cid, COMBAT_FIREDAMAGE, newpos[dir], 0, min, max, 6)
			addEvent(doFlamethrower, 200, cid, newpos[dir], number+1,l)
		else
			doPlayerSendTextMessage(cid, 24, "Your flamethrower has stopped.")
		end
	end
end

local lvl = {
[10587] = 0,
[10588] = 1,
[10589] = 2,
[10590] = 3,
}
function onUse(cid, item, frompos, item2, topos)
	if SPELLS then
		doTransformItem(item.uid,lvl[item.itemid] == 3 and item.itemid-3 or item.itemid+1)
	end
	if not lvl[item.itemid] or  lvl[item.itemid] == 0 then
		doPlayerSendCancel(cid,'You need learn this spell.')
		return true
	end
	local ret,f = ifSpell2(cid,75*lvl[item.itemid],10,50202,isFire)
	if  not ret then
		return ret
	end
	doFlamethrower(cid, getCreaturePosition(cid), 0,lvl[item.itemid])
	f()
	return true
end
