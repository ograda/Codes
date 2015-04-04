local weapontypes = {1, 2, 3}
local ids = {[0] = 6286, 6285, 6286, 6285}
local arr = {
[0] = {
	{5,5,5},
	{4,4,4},
	{0,3,0},
	{0,2,0},
	{0,1,0},
	{0,0,0},
	{0,0,0},
	{0,0,0},
	{0,0,0},
	{0,0,0},
},
[2] = {
	{0,0,0},
	{0,0,0},
	{0,0,0},
	{0,0,0},
	{0,0,0},
	{0,0,0},
	{0,1,0},
	{0,2,0},
	{0,3,0},
	{4,4,4},
	{5,5,5},
},
[1] = {
	{0,0,0,0,0,0,0,0,0,4,5},
	{0,0,0,0,0,0,1,2,3,4,5},
	{0,0,0,0,0,0,0,0,0,4,5},
},
[3] = {
	{5,4,0,0,0,0,0,0,0,0},
	{5,4,3,2,1,0,0,0,0,0},
	{5,4,0,0,0,0,0,0,0,0},
}
}
local function seismicwave(cid, pos,dir,lvla)
	if isCreature(cid) == FALSE then
		return FALSE
	end
	local weapon = getPlayerWeapon(cid).uid
	if weapon == 0 then
		return FALSE
	end
	local type = getItemWeaponType(weapon)
	if isInArray(weapontypes, type) == FALSE then
		return FALSE
	end
	local function atk(cid,pos,weapon)
		local weapon = getPlayerWeapon(cid).uid
		if weapon == 0 then
			addEvent(function(pos)
			local item = doFindItemInPos({6285, 6286}, pos)
			doRemoveItem(item.uid, 1) end,600,pos)
			return FALSE
		end
	local formula = {
		skill = getPlayerSkillLevel(cid, 1),
		attack = getItemAttack(weapon),
	}
	local store = lvla
	local hit = (2*formula.skill+formula.attack)*store*1.2
		local extra = {
			[-1] = math.random(5,9),
			[1] = math.random(5,11),
			[2] = math.random(7,13),
			[3] = math.random(8,15)
		}
		local finalhit = hit
		if isCreature(cid or 0) then
			doAreaCombatHealth(cid, 1, pos, 0, -(finalhit-math.random(10,20)), -(finalhit+math.random(10,20))-30*calcCrit(cid), 44)
		end
		addEvent(function(pos)
		local item = doFindItemInPos({6285, 6286}, pos)
		doRemoveItem(item.uid, 1) end,600,pos)
	end
	local center = {}
	local area = arr[dir]
	center.y = math.floor(#area/2)+1
	for y = 1, #area do
		for x = 1, #area[y] do
			local number = area[y][x]
			if number > 0 then
				center.x = math.floor(table.getn(area[y])/2)+1
				local final = {x = pos.x + x - center.x, y = pos.y + y - center.y, z = pos.z}
				if hasSqm(final) and not getTilePzInfo(final) then
					addEvent(doCreateItem,100*(number*1.2),ids[dir],1,final)
					addEvent(doSendMagicEffect,100*number,final,34)
					addEvent(doSendDistanceShoot,100*(number+5),pos,final,11 )
					addEvent(atk,100*((number+5)*1.3),cid,final,weapon)
				end
			end
		end
	end
	addEvent(doPlayerSetNoMove,2000,cid, FALSE)
end


local lvl = {
[10178] = 0,
[10179] = 1,
[10180] = 2,
[10181] = 3,
}
function onUse(cid, item, frompos, item2, topos)
	local pos = getCreaturePosition(cid)
	if SPELLS then
		doTransformItem(item.uid,lvl[item.itemid] == 3 and item.itemid-3 or item.itemid+1)
	end
	if not lvl[item.itemid] or  lvl[item.itemid] == 0 then
		doPlayerSendCancel(cid,'You need learn this spell.')
		return true
	end
		local weapon = getPlayerWeapon(cid).uid
	if weapon == 0 then
		doPlayerSendCancel(cid, "You need a weapon in your hand.")
		doSendMagicEffect(pos, 2)
		return FALSE
	end
	local type = getItemWeaponType(weapon)
	if isInArray(weapontypes, type) == FALSE then
		doPlayerSendCancel(cid, "Your weapon should be fighting infighting.")
		doSendMagicEffect(pos, 2)
		return FALSE
	end
	local ret,f = ifSpell2(cid,125,15,50205)
	if  not ret then
		return
	end
	f()
	doPlayerSetNoMove(cid, TRUE)
	setPlayerStorageValue(cid,13341,lvl[item.itemid])
	seismicwave(cid, pos,getPlayerLookDir(cid),lvl[item.itemid])
	return TRUE
end