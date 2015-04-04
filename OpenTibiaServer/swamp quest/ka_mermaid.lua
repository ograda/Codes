function onUse(cid, item, frompos, item2, topos)

epos={x=201, y=556, z=7}

if getPlayerStorageValue(cid, 9777) == -1 then
		doCreateMonster("Red Maple's Squirrel", epos)
                setPlayerStorageValue(cid, 9777, 1)
                doCreatureSay(cid, "Chch chch", TALKTYPE_ORANGE_1)
end
end