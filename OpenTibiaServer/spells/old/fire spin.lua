function getNextFire(pos, target)
	if target.y < pos.y and target.x == pos.x then
		newpos = {x=target.x+1, y=target.y+1, z=target.z}
	elseif target.y > pos.y and target.x == pos.x then
		newpos = {x=target.x-1, y=target.y-1, z=target.z}
	elseif target.y == pos.y and target.x > pos.x then
		newpos = {x=target.x-1, y=target.y+1, z=target.z}
	elseif target.y == pos.y and target.x < pos.x then
		newpos = {x=target.x+1, y=target.y-1, z=target.z}
	elseif target.y < pos.y and target.x > pos.x then
		newpos = {x=target.x, y=target.y+1, z=target.z}
	elseif target.y > pos.y and target.x < pos.x then
		newpos = {x=target.x, y=target.y-1, z=target.z}
	elseif target.y > pos.y and target.x > pos.x then
		newpos = {x=target.x-1, y=target.y, z=target.z}
	elseif target.y < pos.y and target.x < pos.x then
		newpos = {x=target.x+1, y=target.y, z=target.z}
	else
		newpos = pos
	end
	return newpos
end

local arrfirespin = {
  [1] = {
	{0,0,0,1,0,0,0},
	{0,0,0,1,0,0,0},
	{0,0,0,1,0,0,0},
	{0,0,0,2,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0}
  },

  [2] = {
	{0,0,0,0,1,0,0},
	{0,0,0,0,1,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,2,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0}
  },

  [3] = {
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,1,0},
	{0,0,0,0,1,0,0},
	{0,0,0,2,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0}
  },

  [4] = {
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,1,1},
	{0,0,0,2,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0}
  },

  [5] = {
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,2,1,1,1},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0}
  },

  [6] = {
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,2,0,0,0},
	{0,0,0,0,0,1,1},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0}
  },

  [7] = {
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,2,0,0,0},
	{0,0,0,0,1,0,0},
	{0,0,0,0,0,1,0},
	{0,0,0,0,0,0,0}
  },

  [8] = {
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,2,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,1,0,0},
	{0,0,0,0,1,0,0}
  },

  [9] = {
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,2,0,0,0},
	{0,0,0,1,0,0,0},
	{0,0,0,1,0,0,0},
	{0,0,0,1,0,0,0}
  },

  [10] = {
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,2,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,1,0,0,0,0},
	{0,0,1,0,0,0,0}
  },

  [11] = {
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,2,0,0,0},
	{0,0,1,0,0,0,0},
	{0,1,0,0,0,0,0},
	{0,0,0,0,0,0,0}
  },

  [12] = {
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,2,0,0,0},
	{1,1,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0}
  },

  [13] = {
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{1,1,1,2,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0}
  },

  [14] = {
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{1,1,0,0,0,0,0},
	{0,0,0,2,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0}
  },

  [15] = {
	{0,0,0,0,0,0,0},
	{0,1,0,0,0,0,0},
	{0,0,1,0,0,0,0},
	{0,0,0,2,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0}
  },

  [16] = {
	{0,0,1,0,0,0,0},
	{0,0,1,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,2,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0},
	{0,0,0,0,0,0,0}
  },
}

function firespin(cid, pos)
	local nextpos = getNextFire(getCreaturePosition(cid), pos)
	if isSightClear(nextpos, pos, TRUE) == TRUE and isWalkable(pos, FALSE, TRUE) then
		doSendDistanceShoot(pos, nextpos, 3)
		local min, max = getHit(cid, 6, 8)
		doAreaCombatHealth(cid, COMBAT_FIREDAMAGE, pos, 0, min, max, 36)
	end
end

local combatfirespin = {}
for n, v in pairs(arrfirespin) do
	combatfirespin[n] = createCombatObject()
	_G["callback"..n] = firespin
	setCombatCallback(combatfirespin[n], CALLBACK_PARAM_TARGETTILE, "callback"..n)
	setCombatArea(combatfirespin[n], createCombatArea(v))
end

function onUse(cid, item, frompos, item2, topos)
	var = {type=2,pos=getCreaturePosition(cid)}
	local ret,f = ifSpell2(cid, 15,nil,24343,isFire,1,50)
	if ret and doCombat(cid, combatfirespin[1], var) then
		f()
		for times = 0, 2 do
			for i = 1, #combatfirespin do
				addEvent(doCombat, (times*#combatfirespin*50)+(i*50), cid, combatfirespin[i], var)
			end
		end
	end
	return true
end
