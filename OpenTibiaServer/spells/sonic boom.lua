local ids = {2544, 2545, 2546, 7840, 7838, 7839, 7850, 7364, 7365}
local arrow = {
	[2544] = {ani = CONST_ANI_ARROW, me = CONST_ME_HITAREA, damage = COMBAT_PHYSICALDAMAGE, condition = CONDITION_POISON},
	[2545] = {ani = CONST_ANI_POISONARROW, me = CONST_ME_POISONAREA, damage = COMBAT_POISONDAMAGE, condition = CONDITION_POISON},
	[2546] = {ani = CONST_ANI_BURSTARROW, me = CONST_ME_EXPLOSIONHIT, damage = COMBAT_FIREDAMAGE, condition = CONDITION_FIRE},
	[7840] = {ani = CONST_ANI_FLAMMINGARROW, me = CONST_ME_FIREAREA, damage = COMBAT_FIREDAMAGE, condition = CONDITION_FIRE},
	[7838] = {ani = CONST_ANI_FLASHARROW, me = CONST_ME_ENERGYHIT, damage = COMBAT_ENERGYDAMAGE, condition = CONDITION_ENERGY},
	[7839] = {ani = CONST_ANI_SHIVERARROW, me = CONST_ME_ICEATTACK, damage = COMBAT_ICEDAMAGE, condition = CONDITION_FREEZING},
	[7850] = {ani = CONST_ANI_EARTHARROW, me = CONST_ME_CARNIPHILA, damage = COMBAT_EARTHDAMAGE, condition = CONDITION_POISON},
	[7364] = {ani = CONST_ANI_SNIPERARROW, me = CONST_ME_GROUNDSHAKER, damage = COMBAT_PHYSICALDAMAGE, condition = CONDITION_CURSED},
	[7365] = {ani = CONST_ANI_ONYXARROW, me = CONST_ME_GROUNDSHAKER, damage = COMBAT_PHYSICALDAMAGE, condition = CONDITION_CURSED}
}

for i = 1, #ids do
	if arrow[ids[i]].condition ~= 0 then
		arrow[ids[i]].condition = createConditionObject(arrow[ids[i]].condition)
		--setConditionParam(arrow[ids[i]].condition, CONDITION_PARAM_DELAYED, 1)
		setConditionParam(arrow[ids[i]].condition, CONDITION_PARAM_TICKS, 20000)
		addDamageCondition(arrow[ids[i]].condition, 2, 2000, -10)
		addDamageCondition(arrow[ids[i]].condition, 2, 2000, -5)
		addDamageCondition(arrow[ids[i]].condition, 5, 2000, -1)
	end
end

local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 40000)
setConditionParam(condition, CONDITION_PARAM_SPEED, -130)
setConditionFormula(condition, -0.1, -10, -0.1, -10)

local lvl = {
[10571] = 0,
[10572] = 1,
[10573] = 2,
[10574] = 3,
}
local extra = {
	[1] = 2.0,
	[2] = 3.8,
	[3] = 4.4
}
function onUse(cid, item, frompos, item2, topos)
	if SPELLS then
		doTransformItem(item.uid,lvl[item.itemid] == 3 and item.itemid-3 or item.itemid+1)
	end
	if not lvl[item.itemid] or  lvl[item.itemid] == 0 then
		doPlayerSendCancel(cid,'You need learn this spell.')
		return true
	end
	local pos = getCreaturePosition(cid)
	local ret,f = ifSpell2(cid,95,2,50203)
	if  not ret then
		return
	end
	local pos = getCreaturePosition(cid)
	local weapon = getPlayerWeapon(cid)
	if weapon.uid == 0 or arrow[weapon.itemid] == nil then
		doPlayerSendCancel(cid, "You need be equiped with a bow and a arrow.")
		doSendMagicEffect(pos, 2)
		return FALSE
	end
	if getPlayerItemCount(cid,weapon.itemid) <= 1 then
		doPlayerSendCancel(cid, "You need more than 1 arrow.")
		doSendMagicEffect(getCreaturePosition(cid), 2)
		return false
	end
	local status = lvl[item.itemid]
	local formula = (getPlayerSkillLevel(cid, SKILL_DISTANCE)+getItemAttack(weapon.uid))*status*2
	local hit = -(formula*calcCrit(cid))
	local atkpos = getPlayerLookPos(cid)
	doSendDistanceShoot(pos, atkpos, arrow[weapon.itemid].ani)
	doAreaCombatHealth(cid, arrow[weapon.itemid].damage, atkpos, 0, hit+30, hit-50,255)
	doAreaCombatCondition(cid, atkpos, {{1,1,1},{1,3,1},{1,1,1}}, condition, 13)--
	doPlayerRemoveItem(cid, weapon.itemid, 1)
	for i=1,4 do
	atkpos = getPosByDir(atkpos,getCreatureLookDir(cid))
	doSendDistanceShoot(pos, atkpos, arrow[weapon.itemid].ani)
	doAreaCombatHealth(cid, arrow[weapon.itemid].damage, atkpos, 0, hit+30, hit-50,255)
	doAreaCombatCondition(cid, atkpos, {{1,1,1},{1,3,1},{1,1,1}}, condition, 13)--
	end
	f()
	return TRUE
end
