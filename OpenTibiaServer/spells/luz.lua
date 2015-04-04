
local lvl = {
[10551] = 0,
[10552] = 1,
[10553] = 2,
[10554] = 3,
}
function onUse(cid, item, frompos, item2, topos)
	if SPELLS then
		doTransformItem(item.uid,lvl[item.itemid] == 3 and item.itemid-3 or item.itemid+1)
	end
	if not lvl[item.itemid] or  lvl[item.itemid] == 0 then
		doPlayerSendCancel(cid,'You need learn this spell.')
		return true
	end
	local ret,f = ifSpell2(cid,10,10,48213)
	if not ret then
		return
	end
	if lvl[item.itemid] == 1 then
		doSetCreatureLight(cid, 14,73, 120000)
	elseif lvl[item.itemid] == 2 then
		doSetCreatureLight(cid, 20,7,  2*120000)
	else
		doSetCreatureLight(cid, 28,43, 4*120000)
	end
	doSendMagicEffect(getCreaturePosition(cid), 12)
	f()
	return TRUE
end
