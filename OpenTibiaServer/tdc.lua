function onUse(cid, item, fromPosition, itemEx, toPosition)

    if (item.uid == 10010) then
        if (getPlayerStorageValue(cid, 10010) < 1) then
        Key = doPlayerAddItem(cid, 2087)
        doSetItemActionId(Key, 10011)
        setPlayerStorageValue(cid, 10010, 1)
        setPlayerStorageValue(cid, 12004, 2)
        doPlayerSendTextMessage(cid, 25, "You have found a secret key.")
        else
        doPlayerSendTextMessage(cid, 25, "Sorry, but you already got it.")
        end
    elseif (itemEx.uid == 10011) and (item.actionid == 10011) then
    Pos = getThingPos(cid)
    doTeleportThing(cid, {x = Pos.x, y = Pos.y+2, z = Pos.z})
    doSendMagicEffect(toPosition, 3)
    doSendMagicEffect(getThingPos(cid), 10)
    doPlayerSendTextMessage(cid, 25, "The secret key broke!")
    doRemoveItem(item.uid)
    elseif (item.uid == 10012) or (item.uid == 10013) then
    Bau = {10012, 10013}
      Prize = {10601,10602}
        for bau = 1, 2 do
            if (item.uid == Bau[bau]) then
                if (getPlayerStorageValue(cid, 10010+bau) ~= 1) then
                    if (getPlayerFreeCap(cid) >= getItemWeightById(Prize[bau], 1)) then
                    Item = doPlayerAddItem(cid, Prize[bau])
                    doSetItemSpecialDescription(Item, "The Draconian Chambers Rewards.")
                    setPlayerStorageValue(cid, 10010+bau, 1)
                    setPlayerStorageValue(cid, 10010, 2)
                    doPlayerSendTextMessage(cid, 25, "You have rewarded a "..getItemNameById(Prize[bau]).." and 3100 points of experience!")
                    doPlayerAddExp(cid, 3100)
                    else
                    doPlayerSendTextMessage(cid, 25, "You need of "..getItemWeightById(Prize[bau], 1).." freecap.")
                    end
                else
                doPlayerSendTextMessage(cid, 25, "Sorry, but you already did this quest.")
                end
            end
        end
    elseif (item.uid == 10011) then
    Pos = getThingPos(cid)
        if (Pos.y == 387) then
        doPlayerSendTextMessage(cid, 25, "The Draconian Chambers Quest.")
        else
            if (getPlayerStorageValue(cid, 10011) == 1) or (getPlayerStorageValue(cid, 10012) == 1) then
            doTeleportThing(cid, {x = Pos.x, y = Pos.y-2, z = Pos.z})
            doSendMagicEffect(fromPosition, 3)
            doSendMagicEffect(getThingPos(cid), 10)
            else
            doPlayerSendTextMessage(cid, 25, "Sorry, but you need to do the quest.")
            end
        end
    end

	return TRUE
end
