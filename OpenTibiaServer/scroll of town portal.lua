function Four(cid)
doSendAnimatedText(getPlayerPosition(cid), "4..", 17)
end
 
function Three(cid)
doSendAnimatedText(getPlayerPosition(cid), "3..", 17)
end
 
function Two(cid)
doSendAnimatedText(getPlayerPosition(cid), "2..", 17)
end
 
function One(cid)
doSendAnimatedText(getPlayerPosition(cid),"1..", 17)
end

function onUse(cid, item, frompos, item2, topos)

if hasCondition(cid, CONDITION_INFIGHT) ~= false then

	doPlayerSendCancel(cid, "You can't use the scroll until you're out of battle.")
	doSendMagicEffect(getPlayerPosition(cid),2)
else
	doPlayerSetNoMove(cid, true)
	doSendAnimatedText(getPlayerPosition(cid), "5..", 17)
	doRemoveItem(item.uid, 1)
	addEvent(Four, 1000, cid)
	addEvent(Three, 2000, cid)
	addEvent(Two, 3000, cid)
	addEvent(One, 4000, cid)
	addEvent(doTeleportThing, 5000, cid, getPlayerMasterPos(cid))
	addEvent(doSendMagicEffect, 5010, getPlayerMasterPos(cid), 10)
	addEvent(doPlayerSetNoMove, 5020, cid, false)
	end

	return 1
end

