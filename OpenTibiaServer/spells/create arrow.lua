local lvl ={
[10555] = 0,
[10556] = 1,
[10557] = 2,
[10558] = 3,
}
function onUse(cid, item, frompos, item2, topos)
	-- sistema
	if SPELLS then
		doTransformItem(item.uid,lvl[item.itemid] == 3 and item.itemid-3 or item.itemid+1)
	end
	if not lvl[item.itemid] or  lvl[item.itemid] == 0 then
		doPlayerSendCancel(cid,'You need learn this spell.')
		return true
	end
	if getPlayerItemCount(cid,5901) == 0 then
		doPlayerSendCancel(cid,'Sorry, you need lumber.')
	end
	local ret,f = ifSpell2(cid,25,1,12121)
	if ret then
		doPlayerRemoveItem(cid,5901,1)
		doPlayerAddItem(cid,2544,5+(5*(lvl[item.itemid])))
		local old = getCreaturePosition(cid)
		for d=0,7 do
			for i=1,4 do
				addEvent(doSendDistanceShoot,100*math.random(0,10),getPosByDir(old,d),getCreaturePosition(cid),2)
			end
		end
		doSendMagicEffect(getCreaturePosition(cid),12)
		f()
	end
end
