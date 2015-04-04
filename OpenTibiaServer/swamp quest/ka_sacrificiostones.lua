config = {}
--//Config
config.doorpos = {x=243, y=570, z=13, stackpos=1} -- POSIÇÃO DA PORTA
config.openeddoorid = 3395 -- ID DA PORTA ABERTA
config.closeddoorid = 3378 -- ID DA PORTA FECHADA
config.venompos = {x=246, y=567, z=13, stackpos=255} -- POS DA VENOM STONE
config.firepos = {x=246, y=573, z=13, stackpos=255} -- POS DA FIRE STONE
config.waterpos = {x=248, y=570, z=13, stackpos=255} -- POS DA WATER STONE
config.venomid = 2155 -- ID DA VENOM STONE
config.fireid = 2156 -- ID DA FIRE STONE
config.waterid = 2158 -- ID DA WATER STONE
config.failmsg = "Nothing happens."
config.donemsg = "You opened a secret door."
config.timetoautoclose = 60 -- TEMPO PARA FECHAR A PORTA(EM SEGUNDOS)
--//Config

local function removeDoor(pos)
	doRemoveItem(getThingFromPos(pos).uid)
	return true
end
function onUse(cid, item, frompos, item2, topos)
	local doorpos = getThingFromPos(config.doorpos)
	if getThingFromPos(config.venompos).itemid == config.venomid and getThingFromPos(config.firepos).itemid == config.fireid and getThingFromPos(config.waterpos).itemid == config.waterid then
		if getThingFromPos(config.doorpos).itemid == config.closeddoorid then
			doRemoveItem(getThingFromPos(config.venompos).uid)
			doRemoveItem(getThingFromPos(config.firepos).uid)
			doRemoveItem(getThingFromPos(config.waterpos).uid)
			doPlayerSendTextMessage(cid, 25, config.donemsg)
			doTransformItem(getThingFromPos(config.doorpos).uid, config.openeddoorid)
			q = addEvent(doCreateItem, config.timetoautoclose*1000, config.closeddoorid, 1, config.doorpos)
			w = addEvent(removeDoor, config.timetoautoclose*1000, config.doorpos)
		else
			stopEvent(q)
			stopEvent(w)
			doTransformItem(getThingFromPos(config.doorpos).uid, config.openeddoorid)
			q = addEvent(doCreateItem, config.timetoautoclose*1000, config.closeddoorid, 1, config.doorpos)
			w = addEvent(removeDoor, config.timetoautoclose*1000, config.doorpos)
			doRemoveItem(getThingFromPos(config.venompos).uid)
			doRemoveItem(getThingFromPos(config.firepos).uid)
			doRemoveItem(getThingFromPos(config.waterpos).uid)
			doPlayerSendTextMessage(cid, 25, config.donemsg)
		end
	else
		doPlayerSendTextMessage(cid, 25, config.failmsg)
	end
	return true
end