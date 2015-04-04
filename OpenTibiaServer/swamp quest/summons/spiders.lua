local config = {}


function onUse(cid, item, frompos, item2, topos)
if getPlayerStorageValue(cid, 23001) == -1 then
setPlayerStorageValue(cid, 23001, 1)
                doCreatureSay(cid, "YOU HAVE ABSORBED THE BEAST OF THE SWAMP", TALKTYPE_ORANGE_1)
		else
			doPlayerSendCancel(cid, "Nothing happens.")		
end
	return true
end