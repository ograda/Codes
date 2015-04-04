local weapontypes = {1, 2, 3}
local dirs = {[0] = 2, 3, 0, 1}
local effects = {24, 26, 25}
local lvl = {
[10094] = 0,
[10095] = 1,
[10096] = 2,
[10097] = 3,
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
	local var = numberToVariant(getCreatureTarget(cid))
	local ret,f = ifSpell2(cid,25*lvl[item.itemid],10,50203)
	if  not ret then
		return true
	end
	local weapon = getPlayerWeapon(cid).uid
	local pos = getCreaturePosition(cid)
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
	local target = getCreatureTarget(cid)
	local targetpos = getCreaturePosition(target)
	local atkpos = getPosByDir(targetpos, dirs[getPlayerLookDir(cid)])
	if isWalkable(atkpos, TRUE, FALSE) == FALSE and (pos.x ~= atkpos.x or pos.y ~= atkpos.y) then
		doPlayerSendCancel(cid, "Sorry, not possible.")
		doSendMagicEffect(pos, 2)
		return FALSE
	end
	doTeleportThing(cid, atkpos, FALSE)
	doSendMagicEffect(atkpos, 9)
	local formula = {
		skill = getPlayerSkillLevel(cid, 1),
		attack = getItemAttack(weapon),
		nivel = getPlayerLevel(cid)
	}
	local store = lvl[item.itemid]
	local hit = (2*formula.skill+formula.attack)*(1+(store/3)+0.1)*0.8
	doTargetCombatHealth(cid, target, 1, -(hit-math.random(10,20)), -(hit+math.random(1,20))*calcCrit(cid), 34)
	--doSendAnimatedText(getCreaturePosition(cid),-hit*(math.random(100) == 1 and 1.3 or 1.1),100)
	doSendDistanceShoot(atkpos, targetpos, effects[type])
	local function back()
		if isCreature(cid) then
			doSendMagicEffect(getCreaturePosition(cid), 9)
			doTeleportThing(cid, pos, FALSE)
			doSendMagicEffect(pos, 2)
		end
	end
	addEvent(back, 1000)
	f()
	doSendAnimatedText(getCreaturePosition(cid),'Cleave',math.random(0,255))
	return TRUE
end
