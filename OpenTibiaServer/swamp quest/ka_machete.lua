local config = {}

--//Config
config.holeactionid = 7800 -- ACTION ID DO "BURACO" DO COGUMELO
config.msgwrongid = "You can't use your machete on it."
config.rewardid = 2087 -- ID DA CHAVE QUE VAI GANHAR
config.storageid = 56001 -- STORAGE PRO PLAYER NÃO PEGAR MAIS A CHAVE
config.msgdone = "You have found the venom key."
config.msgalreadydone = "It is empty."
config.keyactionid = 9801 -- ACTION ID QUE A CHAVE RECEBERA(PARA ABRIR PORTAS)
--//Config

function onUse(cid, item, frompos, item2, topos)
	if item2.actionid == config.holeactionid then
		if getPlayerStorageValue(cid, config.storageid) == -1 then
			local q = doPlayerAddItem(cid, config.rewardid, 1)
			doSetItemActionId(q, config.keyactionid)
			doPlayerSendTextMessage(cid, 25, config.msgdone)
                        setPlayerStorageValue(cid, config.storageid, 1)
		else
			doPlayerSendCancel(cid, config.msgalreadydone)
			doSendMagicEffect(getCreaturePosition(cid), 2)
		end
	else
		doPlayerSendCancel(cid, config.msgwrongid)
		doSendMagicEffect(getCreaturePosition(cid), 2)
	end
	return true
end