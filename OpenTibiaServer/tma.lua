local function doCloseDoor(none)
Grade = doCreateItem(9533, 1, {x=467, y=459, z=9})
doSetItemActionId(Grade, 10021)
return TRUE
end


function onUse(cid, item, fromPosition, itemEx, toPosition)

    if (item.actionid == 10020) and (getThingFromPos({x=467, y=459, z=9, stackpos=1}).itemid == 9533) then
        if (isInArray({3058, 3059}, getThingFromPos({x=463, y=456, z=9, stackpos=255}).itemid) == TRUE) and (isInArray({3058, 3059}, getThingFromPos({x=465, y=456, z=9, stackpos=255}).itemid) == TRUE) then
        doRemoveItem(getThingFromPos({x=463, y=456, z=9, stackpos=255}).uid)
        doRemoveItem(getThingFromPos({x=465, y=456, z=9, stackpos=255}).uid)
        doSendMagicEffect({x=463, y=456, z=9, stackpos=255}, 2)
        doSendMagicEffect({x=465, y=456, z=9, stackpos=255}, 2)


            if (item.itemid == 1945) then
            Alavanca = doTransformItem(item.uid, 1946)
            doSetItemActionId(Alavanca, 10020)
            else
            Alavanca = doTransformItem(item.uid, 1945)
            doSetItemActionId(Alavanca, 10020)
            end

        doRemoveItem(getThingFromPos({x=467, y=459, z=9, stackpos=1}).uid)
        doSendMagicEffect({x=467, y=459, z=9, stackpos=1}, 10)
        addEvent(doCloseDoor, 300000, 1)
        doPlayerSendTextMessage(cid, 25, "You openned a secret way. It's temporally!")
        else
        doPlayerSendTextMessage(cid, 25, "Sorry, but you need to offer your sacrifices.")
        end
    elseif (item.actionid == 10021) then
    Pos = getThingPos(cid)
        if (Pos.x == 468) then
        doTeleportThing(cid, {x = Pos.x-2, y = Pos.y, z = Pos.z})
        doSendMagicEffect(fromPosition, 3)
        doSendMagicEffect(getThingPos(cid), 10)
        else
        doPlayerSendTextMessage(cid, 25, "The Minotaur Arsenal Quest.")
        end
    elseif (item.uid == 10021) then
        if (getPlayerStorageValue(cid, 10020) < 1) then
        Key = doPlayerAddItem(cid, 2088)
        Book = doPlayerAddItem(cid, 1955)
        doSetItemActionId(Key, 10022)
        setPlayerStorageValue(cid, 10020, 1)
        setPlayerStorageValue(cid, 12005, 2)
        doSetItemText(Book, "General Kuh'muneks\n12/02/850\n\n   In the Minotaur Camp, next to the Mavigic Forest, there's a underground room locked, open it with this key and then you will find the general's treasure.", "General Kuh'muneks Diary", "12/02/850")
        doPlayerSendTextMessage(cid, 25, "You have found General Kuh'muneks Diary and a key.")
        else
        doPlayerSendTextMessage(cid, 25, "Sorry, but you already got it.")
        end
    elseif (itemEx.uid == 10023) and (item.actionid == 10022) then
    Pos = getThingPos(cid)
    doTeleportThing(cid, {x = Pos.x-2, y = Pos.y, z = Pos.z})
    doSendMagicEffect(toPosition, 3)
    doSendMagicEffect(getThingPos(cid), 10)
    doPlayerSendTextMessage(cid, 25, "The key broke!")
    doRemoveItem(item.uid)
    elseif (item.uid == 10024) or (item.uid == 10025) then
    Bau = {10024 ,10025}
    Prize = {10603,10604,10605,10606}
        for bau = 1, 4 do
            if (item.uid == Bau[bau]) then
                if (getPlayerStorageValue(cid, 10020+bau) ~= 1) then
                    if (getPlayerFreeCap(cid) >= getItemWeightById(Prize[bau], 1)) then
                    Item = doPlayerAddItem(cid, Prize[(bau == 1 and bau or bau+1)])
                    doSetItemSpecialDescription(Item, "The Minotaur Arsenal Rewards.")
					Item = doPlayerAddItem(cid, Prize[(bau == 1 and bau or bau+1)+1])
                    doSetItemSpecialDescription(Item, "The Minotaur Arsenal Rewards.")
                    setPlayerStorageValue(cid, 10020+bau, 1)
                    setPlayerStorageValue(cid, 10020, 2)
                    doPlayerSendTextMessage(cid, 25, "You have rewarded a "..getItemNameById(Prize[bau]).." and 8000 points of experience!")
                    doPlayerAddExp(cid, 8000)
                    doSendMagicEffect(getThingPos(cid), 13)
                    else
                    doPlayerSendTextMessage(cid, 25, "You need of "..getItemWeightById(Prize[bau], 1).." freecap.")
                    end
                else
                doPlayerSendTextMessage(cid, 25, "Sorry, but you already did this quest.")
                end
            end
        end
    elseif (item.uid == 10023) then
    Pos = getThingPos(cid)
        if (Pos.x ~= 565) then
        doPlayerSendTextMessage(cid, 25, "The Minotaur Arsenal Quest.")
        else
            if (getPlayerStorageValue(cid, 10021) == 1) or (getPlayerStorageValue(cid, 10022) == 1) then
            doTeleportThing(cid, {x = Pos.x+2, y = Pos.y, z = Pos.z})
            doSendMagicEffect(fromPosition, 3)
            doSendMagicEffect(getThingPos(cid), 10)
            else
            doPlayerSendTextMessage(cid, 25, "Sorry, but you need to do the quest.")
            end
        end
    end

	return TRUE
end
