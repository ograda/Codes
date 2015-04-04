--- Feita por Nandonalt para o Kingdom Age
-------- Config
local config = {
       escada_pos = {x=154,y=579,z=7,stackpos=2}, -- Posição da Escada(buraco), deixe 0 em stackpos
       escada_item = 8250, -- ID da escada(buraco)
       ground_item = 4170, -- Ground que estava antes da escada
       time = 1500 -- Em segundos, o tempo que a escada ficará aberta ( 1500 -> 25 min)  
       }
local function sumirescada(param)
doRemoveItem(getThingfromPos(config.escada_pos).uid,1)
doCreateItem(config.ground_item,1,config.escada_pos)
end

function onUse(cid, item, frompos, item2, topos) 
local escada = getThingfromPos(config.escada_pos) 
 doSendMagicEffect(config.escada_pos,3)
 
if getPlayerLevel(cid) >= 50 then 
if escada.itemid == config.ground_item and item.itemid == 1945 then
doRemoveItem(getThingfromPos(config.escada_pos).uid,1)

local q = doCreateItem(config.escada_item,1,config.escada_pos)
doSetItemActionId(q, 7800)
 
doSendMagicEffect(config.escada_pos,3)
 addEvent(sumirescada, config.time * 1000, {cid = cid})
 doTransformItem(item.uid,1946)  
elseif escada.itemid == config.escada_item and item.itemid == 1945 then
 doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR,"The mushroom is already open.") 
elseif item.itemid == 1946 then
doTransformItem(item.uid,1945)   
 end
else
doPlayerSendCancel(cid,"You need level 50 to pull this lever.") 
end
return 1
end