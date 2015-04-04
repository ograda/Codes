local playerPosition =
{
	{x=532,y=338,z=8, stackpos = STACKPOS_TOP_CREATURE},
	{x=530,y=339,z=8, stackpos = STACKPOS_TOP_CREATURE},
	{x=530,y=342,z=8, stackpos = STACKPOS_TOP_CREATURE},
	{x=532,y=343,z=8, stackpos = STACKPOS_TOP_CREATURE},
	{x=534,y=343,z=8, stackpos = STACKPOS_TOP_CREATURE},
	{x=536,y=342,z=8, stackpos = STACKPOS_TOP_CREATURE},
	{x=536,y=339,z=8, stackpos = STACKPOS_TOP_CREATURE},
	{x=534,y=338,z=8, stackpos = STACKPOS_TOP_CREATURE},
}



local newPosition =
{
	{x=521,y=368,z=13},
 	{x=519,y=369,z=13},
	{x=519,y=372,z=13},
	{x=521,y=373,z=13},
 	{x=523,y=373,z=13},
	{x=525,y=372,z=13},
	{x=525,y=369,z=13},
	{x=523,y=368,z=13},
}	


local monstersPosition ={

      {x=520,y=351,z=15},
      {x=493,y=375,z=15},
      {x=551,y=374,z=15},
      {x=522,y=399,z=14},
}

local monsters = {
"nihgal'zan",
"gorangor",
"ghyn'gan",
"grandmaster krum'kull",
}


function isPos(p1,p2)
	if p1.x == p2.x and
		p1.y == p2.y and
		p1.z == p2.z then return true end
		return false
end
function check_pos(pos)
	for _, p in pairs(playerPosition) do
		if isPos(pos,p) then return true,_ end
	end
end    
    
function table.plus(array) -- by Conde2
local result = 0
      for _, check in pairs(array) do
            if type(check) == "number" then
                    result = result + check
               end
          end
return result
end 

function insidea(p1,p2,me) -- inside area
			if not me then return false end
			if p1.x <= me.x and p2.x >= me.x then
				if p1.y <= me.y and p2.y >= me.y then
					if p1.z >= me.z and p2.z <= me.z then
						return true
					end
				end
			end
			return false
		end
		
 
function onUse(cid, item, fromPos, itemEx, toPos) 
local affectedList = {}
local countLevels = {}
local membersList
local pedrad = {
{x=516,y=375,z=15},
{x=521,y=380,z=15},
{x=527,y=375,z=15},

}  
--- Check player in quest   
    for x, y in pairs(getPlayersOnline()) do
				if insidea({x=492,y=350,z=16},{x=552,y=406,z=13},getCreaturePosition(y)) then
					doPlayerSendTextMessage(cid, 22, "Please wait another team.")
					return false
				end
			end
			
--- Check player in party
    membersList = getPartyMembers(getPlayerParty(cid))
	if(membersList == nil or type(membersList) ~= 'table' or table.maxn(membersList) <= 1) then
		doPlayerSendTextMessage(cid, 22, "Sorry there aren't player in party.")
		doSendMagicEffect(toPos, CONST_ME_POFF)
		return true
	end
	
	
--- Check player level	
		for _, pid in ipairs(membersList) do
		if isPlayer(pid) then
			local r,v = check_pos(getCreaturePosition(pid))
			if r == true then
				if getPlayerLevel(pid) >= 25 then
					table.insert(affectedList, {pid,v})
					table.insert(countLevels, getPlayerLevel(pid))
				else
					doSendMagicEffect(getCreaturePosition(pid),15)
					doMoveCreature(pid,0)
					doSendMagicEffect(getCreaturePosition(pid),9)
					doPlayerSendTextMessage(cid, 22, "Only players level 25 or more.")
					return true
				end
			end
		end
	end
	
--- Check if have 4 or more player in party
	local tmp = table.maxn(affectedList)
	if(tmp <= 1) then
        doPlayerSendTextMessage(cid, 22, "Sorry all the player need to stay in party.")
		doSendMagicEffect(toPos, CONST_ME_POFF)
		return true
	elseif tmp < 1 then
        doPlayerSendTextMessage(cid, 22, "Sorry there aren't 4 or more in party to do the quest.")
		doSendMagicEffect(toPos, CONST_ME_POFF)
		return true
	end
	
--- Check all players level	
	if table.plus(countLevels) < 160 then
        	doPlayerSendTextMessage(cid, 22, "Sorry, but all levels of players in the party needs to sum greater than or equal to 160.")
	return true
   end
   
   
   
--- Teleporting players
   		for i = 1, #playerPosition do

			if isPlayer(affectedList[i][1]) then
				doSendMagicEffect(getCreaturePosition(affectedList[i][1]), CONST_ME_POFF)
				doTeleportThing(affectedList[i][1], newPosition[affectedList[i][2]], FALSE)
				doSendMagicEffect(newPosition[affectedList[i][2]], CONST_ME_ENERGYAREA)
			end
		end
        
        			
		local sto = 23870
	for pos = 1, #monstersPosition do
		sto = sto+1
		local creature = getGlobalStorageValue(sto)
		if not isCreature(creature) then
			local s = doSummonCreature(monsters[pos], monstersPosition[pos])
			setGlobalStorageValue(sto,s)
		else
			doRemoveCreature(creature)
			local s = doSummonCreature(monsters[pos], monstersPosition[pos])
			setGlobalStorageValue(sto,s)
	end
end
		
		for i= 1, #pedrad do
			for stack=1,10 do
				pedrad[i].stackpos = stack
				if getTileThingByPos(pedrad[i]).itemid == 1304 then
				   return true
                else
					doCreateItem(1304,1,pedrad[i])
				end
			end
		end
		--doTransformItem(item.uid, item.itemid + 1)

	return true
end