local function addEngineering(cid, skill1, tries1, skillDet)
        local skill = getPlayerStorageValue(cid, skill1)
        local tries = getPlayerStorageValue(cid, tries1)       
        triesbon = math.ceil(skillDet/100)
        setPlayerStorageValue(cid, tries1, tries+triesbon)
        if skill == -1 then
                doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You are doing alchemy for the first time. Good luck!")
                doSendMagicEffect(getCreaturePosition(cid), math.random(28, 30))
                setPlayerStorageValue(cid, skill1, 1)
                setPlayerStorageValue(cid, tries1, 0)
        elseif not (skill == 100) or not (skill >= getPlayerLevel) then
                if tries >= (skill*skill)/7 then
                        setPlayerStorageValue(cid, tries1, 0)
                        setPlayerStorageValue(cid, skill1, skill+1)
                        doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You advanced to alchemist skill " .. skill .. ".")
                        doSendMagicEffect(getCreaturePosition(cid), math.random(28, 30))
                end
        end
end