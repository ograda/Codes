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
local times = {
	[1] = 3,
	[2] = 6,
	[3] = 8,
}
local lvl = {
[10098] = 0,
[10099] = 1,
[10100] = 2,
[10101] = 3,
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
	if getPlayerItemCount(cid,weapon.itemid) < (times[lvl[item.itemid]]) then
		doPlayerSendCancel(cid, "You need more than "..(times[lvl[item.itemid]]).." arrows.")
		doSendMagicEffect(pos, 2)
		return false
	end
	local ret,f = ifSpell2(cid,55*lvl[item.itemid],2*lvl[item.itemid],50204)
	if  not ret then
		doSendMagicEffect(pos, 2)
		return true
	end
	local var = numberToVariant(getCreatureTarget(cid))
	local target = getCreatureTarget(cid)
	local tpos = getCreaturePosition(target)
	local status = lvl[item.itemid]
	local hit = -(getPlayerSkillLevel(cid, SKILL_DISTANCE)+getItemAttack(weapon.uid))*(1)*calcCrit(cid)
	for x = 1, times[lvl[item.itemid]] do
		local function flechar(x,cid,target,tpos)
			if isCreature(cid) and isCreature(target) and isReachable(getCreaturePosition(cid), tpos) == TRUE then
				doSendDistanceShoot(getCreaturePosition(cid), tpos, arrow[weapon.itemid].ani)
				doTargetCombatHealth(cid, target, arrow[weapon.itemid].damage, hit+100, hit-100, arrow[weapon.itemid].me)
			end
		end
		addEvent(flechar, x*200,x,cid,target,tpos)
	end
	doPlayerRemoveItem(cid, weapon.itemid,(times[lvl[item.itemid]]))
	doSendAnimatedText(getCreaturePosition(cid),'Strafe',math.random(0,255))
	f()
	return TRUE
end
