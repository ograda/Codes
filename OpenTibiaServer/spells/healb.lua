local lvl = {
[10623] = 0,
[10620] = 1,
[10621] = 2,
[10622] = 3,
}
function onUse(cid, item, frompos, item2, topos)
	if SPELLS then
		doTransformItem(item.uid,lvl[item.itemid] == 3 and item.itemid-3 or item.itemid+1)
	end
	if not lvl[item.itemid] or  lvl[item.itemid] == 0 then
		doPlayerSendCancel(cid,'You need learn this spell.')
		return true
	end
	local ret,f = ifSpell2(cid,50*lvl[item.itemid],2*lvl[item.itemid],12345)
	if not ret then
		return
	end
	if lvl[item.itemid] == 1 then
		doCreatureAddHealth(cid,150)
	elseif lvl[item.itemid] == 2 then
		doCreatureAddHealth(cid,350)
	elseif lvl[item.itemid] == 3 then
		doCreatureAddHealth(cid,600)
	end
	return f()
end
