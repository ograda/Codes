function onUse(cid, item, frompos, item2, topos)
  local tempo = 24*60*60*1000 
  local expe = 1.5
      doRemoveItem(item.uid,1)
      doPlayerSetExperienceRate(cid,expe)
      doSendMagicEffect(getPlayerPosition(cid),math.random(28,30))
      doPlayerSendTextMessage(cid,20,"You received 50% extra experience for a day (note that getting killed or loging out cut's the effect!)")
      addEvent(potion,2*60*1000,cid)
end

function potion(cid)
if isPlayer(cid) == TRUE then
  doPlayerSetExperienceRate(cid,1)
  doPlayerSendTextMessage(cid,20,"Your experience just came back to normal state.")
end
 end