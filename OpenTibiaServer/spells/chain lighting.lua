local combat = createCombatObject()

arr = {{3}}

local area = createCombatArea(arr)
setCombatArea(combat, area)

local function energy(cid, position)
	local cid = isCreature(cid) and cid or 0
	for i = 0, 7 do
		local pos = getPosByDir(position, i, 1)
		local creature = getTopCreature(pos).uid
		if isCreature(cid) and creature ~= 0 and creature ~= cid then
			local lvl = getPlayerStorageValue(cid,13350)
			local min, max = getHit(cid, lvl*1.4, lvl*1.8)
			doAreaCombatHealth(cid, COMBAT_ENERGYDAMAGE, pos, 0, min, max, 11)
			doSendDistanceShoot(position, pos, 32)
			if math.random(3) == 1 then
				addEvent(energy, 2000, cid, pos)
			end
		end
	end
end

function onTargetTile(cid, pos)
	energy(cid, pos)
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")


local lvl ={
[10198] = 0,
[10199] = 1,
[10200] = 2,
[10201] = 3,
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
	setPlayerStorageValue(cid,13350,lvl[item.itemid])
	local var = numberToVariant(cid)
	local ret,f = ifSpell2(cid, 150*lvl[item.itemid],25,12121,isEn)
	if ret then
		return  doCombat(cid, combat, var) and f()
	end
end
