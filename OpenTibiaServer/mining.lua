--[[|Mining System-----[v2.0]-----Features--|
|By |*Skills (like fishing)         <<<<    |
|   |*More skill, more easy                 |
[N]_|*12 rock types (need skill, with bonus)|
[O]_|*2 pick types (need skill, with bonus) |
[R]_|*mining helmet (with bonus)            |
[D]_|_________,.-=[Thanks GOD]=-.,_________]]

local customSkills = {
	["mining"] = {skill = 99901, tries = 99951},
	["woodcutting"] = {skill = 99902, tries = 99952},
}

local rocks = {
[1296] = 2,
[1297] = 2,
[1298] = 2,
[1299] = 2,
[3616] = 2,
[1309] = 2,
[5619] = 2,
[5708] = 2,
[5622] = 2,
[5621] = 2,
[5619] = 2,
[5623] = 2,
[5709] = 2,
[5619] = 2,
[5709] = 2,
[1336] = 2,

[5752] = 1,
[5751] = 1,
[5753] = 1,
[5754] = 1,
[5868] = 1,
[5868] = 1,
[1323] = 1,
[5747] = 1,}

local config = {
	{skill = 10, ore = 5880, points = 3},---1-->cobre
	{skill = 10, ore = 10087, points = 3},---2-->estanho
	{skill = 20, ore = 8306, points = 4},---3-->azulito
	{skill = 25, ore = 2225, points = 5},---4-->ferro
	{skill = 25, ore = 8299, points = 6},---5-->carvão
	{skill = 32, ore = 8310, points = 8},---6-->prata
	{skill = 35, ore = 8301, points = 10},--7-->ouro
	{skill = 40, ore = 8298, points = 12},--8-->adamantio
	{skill = 65, ore = {}, points = 20},--11->pedras preciosas
	{skill = 70, ore = 2145, points = 22},--12->diamante
}

local picks = {
	[2553] = {skill = 10, bonus = 0},
	[4874] = {skill = 20, bonus = 4},--dwarven pickaxe
}

local skill = {
	add = function(cid, name, points)
		local store1, store2 = customSkills[name].skill, customSkills[name].tries
		local skill = getPlayerStorageValue(cid, store1)
		local tries = 0
		if skill == -1 then
			setPlayerStorageValue(cid, store1, 10)
			setPlayerStorageValue(cid, store2, 0)
			skill = 10
		else
			tries = getPlayerStorageValue(cid, store2)
		end
		local newtries = tries+points
		setPlayerStorageValue(cid, store2, newtries)
		local exp = math.floor(1.1^(skill-10)*200)
		if tries < exp and newtries >= exp then
			setPlayerStorageValue(cid, store1, skill+1)
			setPlayerStorageValue(cid, store2, newtries-exp)
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "You advanced to "..name.." "..(skill+1)..".")
        end
	end,
	get = function(cid, name)
		local skill = getPlayerStorageValue(cid, customSkills[name].skill)
		return (skill == -1 and 10 or skill)
	end,
}
function ming(cid,topos,pick,level,rock)
	if getDistanceBetween(topos,getCreaturePosition(cid)) > 1 then
		exhaustion.make(cid, 25100, 5)
		setPlayerStorageValue(cid,44213,-1)
		return
	end
	local level = level+pick.bonus+(getPlayerSlotItem(cid, 1).itemid == 7497 and 7 or 0)
	local chance = math.random(1, 100+(rock.skill/1.5)+(level/10))
			local qsdhgds = {'Tick','Pluck','Tack'}
		doSendAnimatedText(topos,qsdhgds[math.random(1,#qsdhgds)],129)
	if chance <= level then
		skill.add(cid, "mining", 25+rock.points)
		local count = (level > (rock.skill+10) and math.random(10) == 1) and 2 or 1
		local mined = doPlayerAddItem(cid, rock.ore, count)
		if mined then
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You got "..count.." "..getItemName(mined).." mineriu"..(count == 1 and "m" or "ns")..".")
			doSendMagicEffect(topos, 44)



		end
		exhaustion.make(cid, 25100, 2)
		setPlayerStorageValue(cid,44213,-1)
		return
	else
		skill.add(cid, "mining", 10)
		doSendMagicEffect(topos, 34)
		--exhaustion.make(cid, 25100, 0.5)
	end

	addEvent(ming,1000,cid,topos,pick,level,rock)
end
function onUse(cid, item, frompos, itemEx, topos)
	if exhaustion.check(cid, 25100)  then
		doPlayerSendCancel(cid, "You are exhausted.")
		return true
	elseif getPlayerSlotItem(cid, 5).itemid ~= item.itemid and getPlayerSlotItem(cid, 6).itemid ~= item.itemid then
		doPlayerSendCancel(cid, "Put the pick in your hand.")
		return true
	end
	if  getPlayerStorageValue(cid,44213) == 1 then
		doPlayerSendCancel(cid, "You cant mine two time at same.")
		return true
	end
	local pick = picks[item.itemid]
	local level = skill.get(cid, "mining")
	if pick.skill > level then
		doPlayerSendCancel(cid, "You need Mining Level "..pick.skill.." to use this pick.")
		return true
	end
	local rock = rocks[itemEx.itemid]
	if rock == nil then
		doPlayerSendCancel(cid, "Sorry, you can't mine here.")
		return true
	end
	local rock = config[rock]
	if rock.skill > level then
		doPlayerSendCancel(cid, "You need Mining Level "..rock.skill.." to mine it.")
		doSendMagicEffect(topos, 2)
		return true
	end
	addEvent(ming,100,cid,topos,pick,level,rock)
	setPlayerStorageValue(cid,44213,1)
	return true
end
