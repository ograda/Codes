local combat = createCombatObject()

function onTargetTile(cid)
    walkAttack(cid, getCreatureTarget(cid), getCreaturePosition(cid), 1, {dmg = COMBAT_FIREDAMAGE, min = 2, max = 4, fx = 13, proj = 33})
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onUse(cid, item, frompos, item2, topos)
	if getCreatureTarget(cid) ~= 0 then
		var = numberToVariant(getCreatureTarget(cid))
		local ret,f = ifSpell2(cid, 15,nil,nil,isFire,1,8)
		if ret then
			return f() and doCombat(cid, combat, var) or false
		end
	else
		doPlayerSendCancel(cid,'You can only use it on creatures.')
	end
end
