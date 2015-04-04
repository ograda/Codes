local ids = {2544, 2545, 2546, 7840, 7838, 7839, 7850, 7364, 7365}
local arrow = {
	[2544] = {ani = CONST_ANI_ARROW, me = CONST_ME_HITAREA, damage = COMBAT_PHYSICALDAMAGE, condition = 0},
	[2545] = {ani = CONST_ANI_POISONARROW, me = CONST_ME_POISONAREA, damage = COMBAT_POISONDAMAGE, condition = CONDITION_POISON},
	[2546] = {ani = CONST_ANI_BURSTARROW, me = CONST_ME_EXPLOSIONHIT, damage = COMBAT_FIREDAMAGE, condition = CONDITION_FIRE},
	[7840] = {ani = CONST_ANI_FLAMMINGARROW, me = CONST_ME_FIREAREA, damage = COMBAT_FIREDAMAGE, condition = CONDITION_FIRE},
	[7838] = {ani = CONST_ANI_FLASHARROW, me = CONST_ME_ENERGYHIT, damage = COMBAT_ENERGYDAMAGE, condition = CONDITION_ENERGY},
	[7839] = {ani = CONST_ANI_SHIVERARROW, me = CONST_ME_ICEATTACK, damage = COMBAT_ICEDAMAGE, condition = CONDITION_FREEZING},
	[7850] = {ani = CONST_ANI_EARTHARROW, me = CONST_ME_CARNIPHILA, damage = COMBAT_EARTHDAMAGE, condition = CONDITION_POISON},
	[7364] = {ani = CONST_ANI_SNIPERARROW, me = CONST_ME_GROUNDSHAKER, damage = COMBAT_PHYSICALDAMAGE, condition = CONDITION_CURSED},
	[7365] = {ani = CONST_ANI_ONYXARROW, me = CONST_ME_GROUNDSHAKER, damage = COMBAT_PHYSICALDAMAGE, condition = CONDITION_CURSED}
}
local quant = {
	[1] = 10,
	[2] = 15,
	[3] = 20
}
local extra = {
	[1] = 2.0,
	[2] = 2.5,
	[3] = 3.5
}
for i = 1, #ids do
	if arrow[ids[i]].condition ~= 0 then
		arrow[ids[i]].condition = createConditionObject(arrow[ids[i]].condition)
		setConditionParam(arrow[ids[i]].condition, CONDITION_PARAM_DELAYED, 1)
		addDamageCondition(arrow[ids[i]].condition, 1, 2000, -3)
		addDamageCondition(arrow[ids[i]].condition, 2, 2000, -2)
		addDamageCondition(arrow[ids[i]].condition, 5, 2000, -1)
	end
end

local lvl = {
[10174] = 0,
[10175] = 1,
[10176] = 2,
[10177] = 3,
}
function onUse(cid, item, frompos, item2, topos)
	setPlayerStorageValue(cid,13332,lvl[item.itemid])
	if SPELLS then
		doTransformItem(item.uid,lvl[item.itemid] == 3 and item.itemid-3 or item.itemid+1)
	end
	if not lvl[item.itemid] or  lvl[item.itemid] == 0 then
		doPlayerSendCancel(cid,'You need learn this spell.')
		return true
	end
	local pos = getCreaturePosition(cid)
	local weapon = getPlayerWeapon(cid)
	if weapon.uid == 0 or arrow[weapon.itemid] == nil then
		doPlayerSendCancel(cid, "You need be equiped with a bow and a arrow.")
		doSendMagicEffect(pos, 2)
		return FALSE
	end
	if getPlayerItemCount(cid,weapon.itemid) < (quant[lvl[item.itemid]]) then
		doPlayerSendCancel(cid, "You need more than 25 arrows.")
		return false
	end
	local ret,f = ifSpell2(cid,180*lvl[item.itemid],10,50204)
	if  not ret then
		return
	end
	local status = lvl[item.itemid]
	local formula = (getPlayerSkillLevel(cid, SKILL_DISTANCE)+getItemAttack(weapon.uid))*status*1.2
	local hit = (formula*calcCrit(cid))
	for times = 1, quant[status] do
		for dir = 0, 7 do
			local airpos = getPosByDir({x=pos.x-4, y=pos.y-4, z=pos.z}, dir)
			local atkpos = getPosByDir(pos, dir, math.random(2))
			if isWalkable(atkpos, false, TRUE,TRUE) == TRUE and isSightClear(airpos, atkpos, TRUE) == TRUE then
				addEvent(doSendDistanceShoot, math.random(10)*100, pos, airpos, arrow[weapon.itemid].ani)
				local function shower()
					doAreaCombatHealth(isCreature(cid) and cid or 0, arrow[weapon.itemid].damage, atkpos, 0, -(hit+30), -(hit-50)*calcCrit(cid), arrow[weapon.itemid].me)
					doSendDistanceShoot(airpos, atkpos, arrow[weapon.itemid].ani)
					local condition = arrow[weapon.itemid].condition
					if condition ~= 0 then
						doAreaCombatCondition(cid, atkpos, 0, condition, arrow[weapon.itemid].me)
					end
				end
				addEvent(shower, math.random(10)*100+1500)
			end
		end
	end
	f()
	doPlayerRemoveItem(cid, weapon.itemid, (quant[lvl[item.itemid]]))
	return TRUE
end
