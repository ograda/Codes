function onUse(cid, item, frompos, item2, topos)
    local tin = 1294
    local copper = 5880
    local bronzebar = 5888
    if getPlayerItemCount(cid, tin) > 0 and getPlayerItemCount(cid, copper) > 0 then
       	local tin_ = getPlayerItemCount(cid, tin)
		local cop = getPlayerItemCount(cid, copper)
		local i = math.min(tin_,cop)
		doPlayerRemoveItem(cid, tin,i)
		doPlayerRemoveItem(cid, copper,i)
		local i2 = math.random(1,i+1)
		if math.random(0,100) <= 50 then
			doPlayerSendCancel(cid, "You created "..(i2-1).." piece"..((i2-1) == 1 and '' or 's').." of bronze bar.")
			doPlayerAddItem(cid, bronzebar,i2-1)
			doSendMagicEffect(topos,36)

		else
			doPlayerSendCancel(cid, "You creation has failed.")
			doSendMagicEffect(topos,2)
		end
	else
		doPlayerSendCancel(cid, "It's necessary tin and copper to merge a bronze bar.")
	end
	return true
end
--[[
tutorial = {
{{x=1,y=2,z=3},{'aqui vc bate punheta por 10 segundos',type=25},10*1000,true},
{{x=1,y=2,z=3},{'aqui vc bate punheta por 50 segundos',type=25},50*1000,true},
{{x=1,y=2,z=3},{'aqui vc bate punheta por 10 segundos e anda',type=25},10*1000,false},
{{x=1,y=2,z=3},{'aqui termina',type=25},100,false},
}
function doTutorial(cid,tutorial)
	for i,b in pairs(tutorial) do
		addEvent(function(cid,v)
			if not isPlayer(cid) then return end
			doTeleportThing(cid,v[1])
			doPlayerSendTextMessage(cid,v[2][1],v[2][1])
			doCreatureSetNoMove(cid, v[4])
		end,b[3],cid,b)
	end
end]]
