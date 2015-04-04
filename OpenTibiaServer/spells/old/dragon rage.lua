function onCastSpell(cid, var)
	if not ifSpell(cid, 450,nil,nil,isFire) then
		return false
	end
	local pos = getCreaturePosition(cid)
	doSendMagicEffect(pos, 36)
	doSendAnimatedText(pos, "Flames", TEXTCOLOR_RED)
	doDelayCombatModifier(cid, COMBAT_FIREDAMAGE, 50, 20, 50, 36)
	return ret
end
