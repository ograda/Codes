local lvl = {
[10623] = 0,
[10620] = 1,
[10621] = 2,
[10622] = 3,
}

local mana = {
[10623] = 0,
[10620] = 1,
[10621] = 3,
[10622] = 6,
}

function onUse(cid, item, frompos, item2, topos)
	if SPELLS then
		doTransformItem(item.uid,lvl[item.itemid] == 3 and item.itemid-3 or item.itemid+1)
	end
	if not lvl[item.itemid] or  lvl[item.itemid] == 0 then
		doPlayerSendCancel(cid,'You need learn this spell.')
		return true
	end
	local ret,f = ifSpell2(cid,30*mana[item.itemid],2*lvl[item.itemid],12345)
	if not ret then
		return
	end
	if lvl[item.itemid] == 1 then
		doCreatureAddHealth(cid,math.random(40,80))
	elseif lvl[item.itemid] == 2 then
		doCreatureAddHealth(cid,math.random(150,300))
	elseif lvl[item.itemid] == 3 then
		doCreatureAddHealth(cid,math.random(500,700))
	end
	return f()
end
