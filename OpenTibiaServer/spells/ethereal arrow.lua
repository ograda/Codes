local arrow = {
	[2544] = {ani = CONST_ANI_ARROW, me = CONST_ME_HITAREA, damage = COMBAT_PHYSICALDAMAGE},
	[2545] = {ani = CONST_ANI_POISONARROW, me = CONST_ME_POISONAREA, damage = COMBAT_POISONDAMAGE},
	[2546] = {ani = CONST_ANI_BURSTARROW, me = CONST_ME_EXPLOSIONHIT, damage = COMBAT_FIREDAMAGE},
	[7840] = {ani = CONST_ANI_FLAMMINGARROW, me = CONST_ME_FIREAREA, damage = COMBAT_FIREDAMAGE},
	[7838] = {ani = CONST_ANI_FLASHARROW, me = CONST_ME_ENERGYHIT, damage = COMBAT_ENERGYDAMAGE},
	[7839] = {ani = CONST_ANI_SHIVERARROW, me = CONST_ME_ICEATTACK, damage = COMBAT_ICEDAMAGE},
	[7850] = {ani = CONST_ANI_EARTHARROW, me = CONST_ME_CARNIPHILA, damage = COMBAT_EARTHDAMAGE},
	[7364] = {ani = CONST_ANI_SNIPERARROW, me = CONST_ME_GROUNDSHAKER, damage = COMBAT_PHYSICALDAMAGE},
	[7365] = {ani = CONST_ANI_ONYXARROW, me = CONST_ME_GROUNDSHAKER, damage = COMBAT_PHYSICALDAMAGE}
}
local extra = {
	[1] = 2.0,
	[2] = 2.8,
	[3] = 3.4
}
local lvl = {
[10110] = 0,
[10111] = 1,
[10112] = 2,
[10113] = 3,
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
	if getCreatureTarget(cid) == 0 then
		doPlayerSendCancel(cid,'You can only use it on creatures.')
		doSendMagicEffect(pos, 2)
		return true
	end
	local weapon = getPlayerWeapon(cid)
	if weapon.uid == 0 or arrow[weapon.itemid] == nil then
		doPlayerSendCancel(cid, "You need be equiped with a bow and a arrow.")
		doSendMagicEffect(pos, 2)
		return FALSE
	end
	if getPlayerItemCount(cid,weapon.itemid) <= 1 then
		doPlayerSendCancel(cid, "You need more than 1 arrow.")
		doSendMagicEffect(pos, 2)
		return false
	end
	local ret,f = ifSpell2(cid,25*lvl[item.itemid],5,50203)
	if  not ret then
		doSendMagicEffect(pos, 2)
		return
	end
	local pos = getCreaturePosition(cid)
	local target = getCreatureTarget(cid)
	local tpos = getCreaturePosition(target)
	local status = lvl[item.itemid]
	local formula = (getPlayerSkillLevel(cid, SKILL_DISTANCE)+getItemAttack(weapon.uid))*status*0.8
	local hit = -(formula*calcCrit(cid))
	doSendDistanceShoot(pos, tpos, CONST_ANI_ETHEREALSPEAR)
	doTargetCombatHealth(cid, target, 1, hit+30, hit-50*calcCrit(cid), CONST_ME_ENERGYAREA)
	doPlayerRemoveItem(cid, weapon.itemid, 1)
	f()
	return TRUE
end
