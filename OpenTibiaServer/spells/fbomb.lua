local lvl = {
[10591] = 0,
[10592] = 1,
[10593] = 2,
[10594] = 3,
}
local waterids = {4608, 4609, 4610, 4611, 4612, 4613, 4614, 4615, 4616, 4617, 4618, 4619, 4620, 4621, 4622, 4623, 4624, 4625, 4664, 4665, 4666, 4820, 4821, 4822, 4823, 4824, 4825}
local arvores = {2700, 2701, 2707, 2711, 2712, 8313, 2703, 2702, 2708, 2705, 2768, 4120}
local fireid = 8631
function doRemoveFire(pos)
	doSendMagicEffect(pos, 2)
	doRemoveItem(doFindItemInPos({fireid}, pos).uid, 1)
end

function onUse(cid, item, frompos, item2, topos)
	local pos = getCreaturePosition(cid)
	if SPELLS then
		doTransformItem(item.uid,lvl[item.itemid] == 3 and item.itemid-3 or item.itemid+1)
	end
	if not lvl[item.itemid] or  lvl[item.itemid] == 0 then
		doPlayerSendCancel(cid,'You need learn this spell.')
		return true
	end
	local ret,f = ifSpell2(cid,175,5,50203)
	if  not ret then
		return
	end
	local pos2 = getCreaturePosition(cid)
	if getCreatureTarget(cid) == 0 then
		doPlayerSendCancel(cid,'You can only use it on creatures.')
		doSendMagicEffect(pos2, 2)
		return true
	end
	local center = {}
	local area = {
	{0, 0, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 0},
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1},
	{1, 1, 1, 1, 1, 1, 1},
	{0, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 0, 0}
	}
	function choose(...)
		local arg = {...}
		return arg[math.random(1,#arg)]
	end
	local lvla = lvl[item.itemid]
	local pos = getCreaturePosition(getCreatureTarget(cid))
	doSendDistanceShoot(pos2,pos,3)
	center.y = math.floor(#area/2)+1
	for y = 1, #area do
		for x = 1, #area[y] do
			local number = area[y][x]
			if number > 0 then
				center.x = math.floor(table.getn(area[y])/2)+1
				local final = {x = pos.x + x - center.x, y = pos.y + y - center.y, z = pos.z}
				if hasSqm(final) and not getTilePzInfo(final) then
					if isCreature(cid or 0) then
                       local min, max = getHit(cid, lvla*0.9, lvla*1.2)
						local tmp = 100*math.random(1,6)
						addEvent(doAreaCombatHealth,tmp,cid, COMBAT_FIREDAMAGE, final, 0, min, max, choose(6,36,15,5))
						if doFindItemInPos(arvores, final) ~= 0 then
							for i = 2, 5 do
								addEvent(doSendMagicEffect, i*1000,final, 36)
							end
							local contador = math.random(4)
							addEvent(doCreateItem,tmp,fireid, 1, final)
							addEvent(doRemoveFire, contador*500+5000, final)
						end
					end
				end
			end
		end
	end
 return f()
end
