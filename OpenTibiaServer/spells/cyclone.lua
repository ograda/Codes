local weapontypes = {1, 2, 3}
local dirs = {[0] = 0, 7, 1, 5, 2, 4, 3, 6}
local effects = {24, 26, 25}
local lvl = {
[10122] = 0,
[10123] = 1,
[10124] = 2,
[10125] = 3,
}
function onUse(cid, item, frompos, item2, topos)
	if SPELLS then
		doTransformItem(item.uid,lvl[item.itemid] == 3 and item.itemid-3 or item.itemid+1)
	end
	if not lvl[item.itemid] or  lvl[item.itemid] == 0 then
		doPlayerSendCancel(cid,'You need learn this spell.')
		return true
	end
	local ret,f = ifSpell2(cid,55*lvl[item.itemid],5,50204)
	if  not ret then
		return
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
	local trapped = TRUE
	for i = 0, 7 do
		if isWalkable(getPosByDir(pos, i), FALSE, FALSE) == TRUE then
			trapped = FALSE
			break
		end
	end
	if trapped == TRUE then
		doPlayerSendCancel(cid, "You can't cast this spell here.")
		doSendMagicEffect(pos, 2)
		return FALSE
	end
	local config = {
		[-1] = {1, 300, FALSE},
		[1] = {1, 250, true},
		[2] = {2, 150, TRUE},
		[3] = {math.random(2,3), 100, TRUE}
	}
	local formula = {
		skill = getPlayerSkillLevel(cid, 1),
		attack = getItemAttack(weapon),
	}
	local store = lvl[item.itemid]
	local hit = (2*formula.skill+formula.attack)*(1+(store/3)+0.2)*0.8
	for times = 1, lvl[item.itemid] do
		for dir = 0, 7 do
			local function attack()
				if not isCreature(cid) then
					return TRUE
				end
				local atkpos = getPosByDir(pos, dirs[dir])
				local atkpos2 = {x=atkpos.x,y=atkpos.y,z=atkpos.z}
				if isWalkable(atkpos, FALSE, FALSE) then
					local c = calcCrit(cid)
					doSendDistanceShoot(pos, atkpos, effects[type])
					doAreaCombatHealth(cid, 1, atkpos2, 0, -(hit-math.random(10,20)), -(hit+math.random(10,30))*c, 9)
					if c ~= 1 then
						addEvent(function(atkpos) doSendAnimatedText(atkpos,'Critical',151) end,500,atkpos)
					end
					if lvl[item.itemid] == times then
						doPushCreature(pos, atkpos, FALSE)
					end


				end
				if dir == 0 then
					doPlayerSetNoMove(cid, TRUE)
				elseif dir == 7 then
					doPlayerSetNoMove(cid, FALSE)
				end
			end
			local event = addEvent(attack, times*dir*config[store][2])
			if event == TRUE then
				break
			end
		end
	end
	f()
	return TRUE
end
