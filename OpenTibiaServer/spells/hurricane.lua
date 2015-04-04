local efect = 9
local tipu = 28
arts = {
[1] = 24,
[2] = 26,
[3] = 25,
}
local weapontypes = {1, 2, 3}
local function doh(cid,pos)
	local weapon = getPlayerWeapon(cid).uid
	if weapon == 0 then
		return FALSE
	end
	local formula = {
		skill = getPlayerSkillLevel(cid, 1),
		attack = getItemAttack(weapon),
		nivel = getPlayerLevel(cid)
	}
	local store = getPlayerStorageValue(cid,13369)
	local hit = (formula.skill+formula.attack)*store*1.1
	if isCreature(cid or 0) then
		doAreaCombatHealth(cid, 1, pos, 0, -(hit-math.random(10,20)), -(hit+math.random(10,20))-30*calcCrit(cid), 9)
	end
end
local function terceiro(p,n,cid)
local gir_table = {0,3,4,4,2,2,5,5,1,1,7,7,0,0,6,6,3,3,4,4,2,2,5,5,1,1,7,7,0,0,6,6,3}
if gir_table[n] ~= nil then
local np = getPosByDir({x=p.x,y=p.y,z=p.z},gir_table[n])
n = n+1
if hasSqm(np) == TRUE and getTilePzInfo(np) == false then
doSendDistanceShoot({x=p.x,y=p.y,z=p.z}, np,tipu)
doSendMagicEffect(np, efect)
doh(cid,np)
end
addEvent(terceiro,100,np,n,cid)
end
end

local function segundo(p,n,cid)
local gir_table = {0,3,4,2,2,5,1,1,7,0,0,6,3,3,4,2,2,5,1,1,7,0,0,6,3,}
if gir_table[n] ~= nil then
local np = getPosByDir({x=p.x,y=p.y,z=p.z},gir_table[n])
n = n+1
if hasSqm(np) == TRUE and getTilePzInfo(np) == false then
doSendDistanceShoot({x=p.x,y=p.y,z=p.z}, np,tipu)
doSendMagicEffect(np,efect)
doh(cid,np)
end
addEvent(segundo,150,np,n,cid)
end
end

local function primeiro(p,n,cid)
local gir_table = {0,3,2,2,1,1,0,0,3,3,2,2,1,1,0,0,3}
if gir_table[n] ~= nil then
local np = getPosByDir({x=p.x,y=p.y,z=p.z},gir_table[n])
doSendDistanceShoot({x=p.x,y=p.y,z=p.z}, np,tipu)
n = n+1
if hasSqm(np) == TRUE and getTilePzInfo(np) == false then
doSendMagicEffect(np, efect)
doh(cid,np)
end
addEvent(primeiro,200,np,n,cid)
end
end

local function primeiro2(p,n,cid)
local gir_table = {2,1,0,0,3,3,2,2,1,1,0,0,3,3,2,2,1}
if gir_table[n] ~= nil then
local np = getPosByDir({x=p.x,y=p.y,z=p.z},gir_table[n])
doSendDistanceShoot({x=p.x,y=p.y,z=p.z}, np,tipu)
n = n+1
if hasSqm(np) == TRUE and getTilePzInfo(np) == false then
doSendMagicEffect(np, efect)
doh(cid,np)
end
addEvent(primeiro2,200,np,n,cid)
end
end

local function segundo2(p,n,cid)
local gir_table = {2,1,7,0,0,6,3,3,4,2,2,5,1,1,7,0,0,6,3,3,4,2,2,5,1}
if gir_table[n] ~= nil then
local np = getPosByDir({x=p.x,y=p.y,z=p.z},gir_table[n])
n = n+1
if hasSqm(np) == TRUE  and getTilePzInfo(np) == false then
doSendDistanceShoot({x=p.x,y=p.y,z=p.z}, np,tipu)
doSendMagicEffect(np,efect)
doh(cid,np)
end
addEvent(segundo2,150,np,n,cid)
end
end

local function terceiro2(p,n,cid)
local gir_table = {2,1,7,7,0,0,6,6,3,3,4,4,2,2,5,5,1,1,7,7,0,0,6,6,3,3,4,4,2,2,5,5,1}
if gir_table[n] ~= nil then
local np = getPosByDir({x=p.x,y=p.y,z=p.z},gir_table[n])
n = n+1
if hasSqm(np) == TRUE and isWalkable(np) == TRUE and getTilePzInfo(np) == false then
doSendDistanceShoot({x=p.x,y=p.y,z=p.z}, np,tipu)
doSendMagicEffect(np, efect)
doh(cid,np)
end
addEvent(terceiro2,100,np,n,cid)
else
  doPlayerSetNoMove(cid, FALSE)
end
end

local lvl = {
[10579] = 0,
[10580] = 1,
[10581] = 2,
[10582] = 3,
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
	local ret,f = ifSpell2(cid,240,15,50206)
	if  not ret then
		return
	end
	setPlayerStorageValue(cid,13369,lvl[item.itemid])

	tipu = arts[type]
	local ej = getCreaturePosition(cid)
    addEvent(primeiro,100,getCreaturePosition(cid),1,cid)
	addEvent(primeiro2,100,getCreaturePosition(cid),1,cid)
	local ej = getCreaturePosition(cid)
	ej.y = ej.y-1
	addEvent(segundo,100,ej,1,cid)
   local ejk = getCreaturePosition(cid)
	ejk.y = ejk.y+1
	addEvent(segundo2,100,ejk,1,cid)
	local eja = getCreaturePosition(cid)
	eja.y = eja.y-2
   addEvent(terceiro,100,eja,1,cid)
   	local ejak = getCreaturePosition(cid)
	ejak.y = ejak.y+2
   addEvent(terceiro2,100,ejak,1,cid)
 return f()
end
