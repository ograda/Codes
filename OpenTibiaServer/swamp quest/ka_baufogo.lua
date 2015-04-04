local config = {}

--//Config
config.storageid = 56000 -- STORAGE DA QUEST
config.itemid = 2089 -- ID DA CHAVE
config.msgdone = "You have found the fire key."
config.msgalreadydone = "It is empty."
config.keyactionid = 9800 -- ACTION ID QUE VAI SER POSTO NA CHAVE PRA ENTRAR NA PORTA
--//Config

function onUse(cid, item, frompos, item2, topos)
	if getPlayerStorageValue(cid, config.storageid) == -1 then
		local q = doPlayerAddItem(cid, config.itemid, 1)
		doSetItemActionId(q, config.keyactionid)
		doPlayerSendTextMessage(cid, 25, config.msgdone)
		setPlayerStorageValue(cid, config.storageid, 1)
	else
		doPlayerSendCancel(cid, config.msgalreadydone)
		doSendMagicEffect(getCreaturePosition(cid), 2)
	end
	return true
end