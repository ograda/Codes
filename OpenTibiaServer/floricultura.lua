function onUse(cid, item, frompos, itemEx, topos)
    if itemEx.itemid == 7665 then
        doTransformItem(itemEx.uid, 7670)
        doSendMagicEffect(topos, 1)
    elseif itemEx.itemid == 7670 then
        doTransformItem(itemEx.uid, 7684)
        doSendMagicEffect(topos, 1)
    elseif itemEx.itemid == 7684 then
        doTransformItem(itemEx.uid, 7692)
        doSendMagicEffect(topos, 1)
    elseif itemEx.itemid == 7655 then
        doPlayerSendTextMessage(cid, 22, "Você precisa plantar antes de regar.")
    end
    return TRUE
end