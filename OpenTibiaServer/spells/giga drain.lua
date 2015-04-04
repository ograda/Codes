function ae(pos,cid)
	doSendMagicEffect(pos,46)
	local creature = getTopCreature(pos).uid
	if creature > 0 then
		local lvl = getPlayerStorageValue(cid,13344)
		local hp = getCreatureHealth(creature)
		local life = (getPlayerMagLevel(cid)*7+getPlayerLevel(cid)/2)*(math.random(8, 13)/10)+((lvl^2*10))
		doAreaCombatHealth(cid, COMBAT_EARTHDAMAGE, pos, 0, -life, -life,46)
		for i = 0, 3 do
			doSendDistanceShoot(getPosByDir(pos, i), getCreaturePosition(cid), 38)
		end
		if hp ~= getCreatureHealth(creature) then
			local laife = math.random(0,hp-getCreatureHealth(creature))
			doSendAnimatedText(getCreaturePosition(cid), '+'.. laife,189)
			doPlayerSendTextMessage(cid,20,'Heal +'..laife)
			doCreatureAddHealth(cid, laife )
		end
	end
end


local lvl = {
[10182] = 0,
[10183] = 1,
[10184] = 2,
[10185] = 3,
}
function onUse(cid, item, frompos, item2, topos)
	-- sistema
	if SPELLS then
		doTransformItem(item.uid,lvl[item.itemid] == 3 and item.itemid-3 or item.itemid+1)
	end
	if not lvl[item.itemid] or  lvl[item.itemid] == 0 then
		doPlayerSendCancel(cid,'You need learn this spell.')
		return true
	end
	local pos = getCreaturePosition(cid)
	if getCreatureTarget(cid) == 0 then
		doPlayerSendCancel(cid,'You can only use it on creatures.')
		doSendMagicEffect(pos, 2)
		return true
	end
	setPlayerStorageValue(cid,13344,lvl[item.itemid])
	local var = numberToVariant(getCreatureTarget(cid))
	local ret,f = ifSpell(cid, 680,10,11331,isEa)
	if not ret then
		return false
	end
	local area = {
{0,0,0,1,0,0,0},
{0,0,1,1,1,0,0},
{0,1,1,1,1,1,0},
{1,1,1,1,1,1,1},
{0,1,1,1,1,1,0},
{0,0,1,1,1,0,0},
{0,0,0,1,0,0,0},
}
    pos = getCreaturePosition(getCreatureTarget(cid))
	local center = {}
	center.y = math.floor(#area/2)+1
	for y = 1, #area do
		for x = 1, #area[y] do
			local number = area[y][x]
			if number > 0 then
				center.x = math.floor(table.getn(area[y])/2)+1
				local pos = {x = pos.x + x - center.x, y = pos.y + y - center.y, z = pos.z}
				ae(pos,cid)
			end
		end
	end
	return f()
end
