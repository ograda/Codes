local config = {}

--//Config
config.items = { --ID DO ITEM DE RECOMPENSA E QUANTIDADE
	{id=2498, amount=1},
	{id=7411, amount=1},
	{id=2536, amount=1},
	{id=2160, amount=3},
	{id=2195, amount=1},
}
config.storages = {23000, 23001, 23002, 23003} --STORAGES DOS SPAWNS DE ALAVANCA
config.msgfail = "You must absorb all beasts."
config.alreadydonemsg = "It is empty."
config.msgdone = "You have found the swamp treasure."
config.laststorage = 28765 -- STORAGE DO BAÚ QUE VEM MUITOS ITENS
config.containerid = 1991 -- ID DA BP Q VAI VIM OS ITEM
--//Config

function onUse(cid, item, frompos, item2, topos)
	for i = 1, #config.storages do
		if getPlayerStorageValue(cid, config.storages[i]) == -1 then
			failed = 1
		end
	end
	if failed == 1 then
		return doPlayerSendCancel(cid, config.msgfail)
	end
	if failed == nil then
		if getPlayerStorageValue(cid, config.laststorage) == -1 then
			local w = doPlayerAddItem(cid, config.containerid, 1)
			for _, v in ipairs(config.items) do
				doAddContainerItem(w, v.id, v.amount)
			end
                        setPlayerStorageValue(cid, config.laststorage, 1)
			doPlayerSendTextMessage(cid, 25, config.msgdone)
		else
			doPlayerSendCancel(cid, config.alreadydonemsg)
		end
	end
	return true
end