local waterids = {4608, 4609, 4610, 4611, 4612, 4613, 4614, 4615, 4616, 4617, 4618, 4619, 4620, 4621, 4622, 4623, 4624, 4625, 4664, 4665, 4666, 4820, 4821, 4822, 4823, 4824, 4825}
local arvores = {2700, 2701, 2707, 2711, 2712, 8313, 2703, 2702, 2708, 2705, 2768, 4120}
local fireid = 8631

local combat = createCombatObject()

arr = {
{0, 0, 1, 1, 1, 0, 0},
{0, 1, 1, 1, 1, 1, 0},
{1, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 3, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 1},
{0, 1, 1, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 0, 0},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function doRemoveFire(pos)
	doSendMagicEffect(pos, 2)
	doRemoveItem(doFindItemInPos({fireid}, pos).uid, 1)
end

function onTargetTile(cid, pos)
	if getTilePzInfo(pos) then
		return false
	end
	local efeitos, explosion = isInArray(waterids, getTile(pos).itemid) and {1, 53} or {5, 36, 6}, {255, 255, 36, 34, 44, 6, 5, 15}
	local min, max = getHit(cid, 12, 14)
	doAreaCombatHealth(cid, COMBAT_FIREDAMAGE, pos, 0, min, max, explosion[math.random(#explosion)])
	local time = math.random(70)*50
	addEvent(doSendMagicEffect, time+150, pos, efeitos[math.random(#efeitos)])
	addEvent(doSendDistanceShoot, time, {x=pos.x-math.random(3, 4), y=pos.y-math.random(3, 5), z=pos.z}, pos, 3)
	if math.random(3) == 1 and getTile(pos).uid ~= 0 and isWalkable(pos, false, false) then
		local function event()
			local item = doCreateItem(math.random(1500, 1502), 1, pos)
			doDecayItem(item)
		end
		addEvent(event, time/2)
	end
	if doFindItemInPos(arvores, pos) ~= 0 then
		for i = 2, 5 do
			addEvent(doSendMagicEffect, i*1000, pos, 15)
		end
		local contador = math.random(4)
		addEvent(doCreateItem, contador*500+1000, fireid, 1, pos)
		addEvent(doRemoveFire, contador*500+5000, pos)
	end
end
function printTable(t,n)
	n = n or ''
	for i,b in pairs(t) do
		print(n..' '..tostring(i),b)
		if type(b) == 'table' then
			printTable(b,n..'-')
		end

	end
end
setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onCastSpell(cid, var)

	local ret,f = ifSpell2(cid, 600, 5,nil,isFire)
	if ret then
		doCombat(cid, combat, var)
		doSendAnimatedText(getCreaturePosition(cid), "Meteors!", TEXTCOLOR_RED)
		f()
	end
	return ret
end
