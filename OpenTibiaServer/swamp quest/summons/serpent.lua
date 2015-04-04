local config = {}


function onUse(cid, item, frompos, item2, topos)
if getPlayerStorageValue(cid, 23002) == -1 then
setPlayerStorageValue(cid, 23002, 1)
	                doCreatureSay(cid, "YOU HAVE ABSORBED THE BEAST OF THE SEA", TALKTYPE_ORANGE_1)
		else
			doPlayerSendCancel(cid, "Nothing happens.")		
end
return true
end