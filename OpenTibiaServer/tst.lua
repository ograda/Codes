function onUse(cid, item, fromPosition, itemEx, toPosition)

    if (item.uid == 10432) then
        if (getPlayerStorageValue(cid, 10001) < 1) then
        Key = doPlayerAddItem(cid, 2087)
        Book = doPlayerAddItem(cid, 1973)
        doSetItemActionId(Key, 10002)
        setPlayerStorageValue(cid, 10001, 1)
        setPlayerStorageValue(cid, 12003, 2)
        doSetItemText(Book, "Mr. Eldon\n21/12/1012\n\n   I’ve found the key to they master smith’s room!\n\n   First I need to get to a secret passage in Mount Christ’s upper caves, but after pass it, there’s no way back until I find the treasure.\n   Then after a few corridors I need to get rid of the guards, and use the key to open the smith’s personal forge.", Eldon, 21/12/1012)
        doPlayerSendTextMessage(cid, 25, "You have found the Mr. Eldon's book and a key.")
        else
        doPlayerSendTextMessage(cid, 25, "Sorry, but you already got it.")
        end
    elseif (itemEx.uid == 10003) and (item.actionid == 10002) then
    Pos = getThingPos(cid)
    doTeleportThing(cid, {x = Pos.x+2, y = Pos.y, z = Pos.z})
    doSendMagicEffect(toPosition, 3)
    doSendMagicEffect(getThingPos(cid), 10)
    doPlayerSendTextMessage(cid, 25, "The key broke!")
    doRemoveItem(item.uid)
    elseif (item.uid == 10004) or (item.uid == 10005) or (item.uid == 10006) or (item.uid == 10007) then
    Bau = {10004, 10005, 10006, 10007}
    Prize = {10607,10608,10609,10611}
        for bau = 1, 4 do
            if (item.uid == Bau[bau]) then
                if (getPlayerStorageValue(cid, 10001+bau) ~= 1) then
                    if (getPlayerFreeCap(cid) >= getItemWeightById(Prize[bau], 1)) then
                    Item = doPlayerAddItem(cid, Prize[bau])
                    doSetItemSpecialDescription(Item, "The Smith's Treasure Rewards.")
                    setPlayerStorageValue(cid, 10001+bau, 1)
                    setPlayerStorageValue(cid, 10001, 2)
                    doPlayerSendTextMessage(cid, 25, "You have rewarded a "..getItemNameById(Prize[bau]).." and 4300 points of experience!")
                    doPlayerAddExp(cid, 4300)
                    else
                    doPlayerSendTextMessage(cid, 25, "You need of "..getItemWeightById(Prize[bau], 1).." freecap.")
                    end
                else
                doPlayerSendTextMessage(cid, 25, "Sorry, but you already did this quest.")
                end
            end
        end
    elseif (item.uid == 10003) then
    Pos = getThingPos(cid)
        if (Pos.x == 509) then
        doPlayerSendTextMessage(cid, 25, "The Smith's Treasure Quest.")
        else
            if (getPlayerStorageValue(cid, 10003) ~= -1) or (getPlayerStorageValue(cid, 10004) ~= -1) or (getPlayerStorageValue(cid, 10005) ~= -1) then
					doTeleportThing(cid, {x=509,y=313,z=6})
					doSendMagicEffect(fromPosition, 3)
					doSendMagicEffect(getThingPos(cid), 10)
				else
					doPlayerSendTextMessage(cid, 25, "Sorry, but you need to do the quest.")
            end
        end
    end

	return TRUE
end
