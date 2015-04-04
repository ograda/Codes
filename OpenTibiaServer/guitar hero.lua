--[[OTNet script VIP
	Name: Guitar Hero
	Author: Nord
	Version: 1.0

]]--Configuração--

local premios = {
	[1] = {PERCENT = 100, REWARD = 6527},
	[2] = {PERCENT = 95, REWARD = 6527},
	[3] = {PERCENT = 85, REWARD = 2349}
}
local levels = {
	[1] = 750,
	[2] = 500,
	[3] = 400
}
local cost = {id = 2148, count = 10}
local music = {1,2,3,1,3,1,2,1,2,0,3,1,2,3,0,2,0,3,2,3,1,3,2,3,2,1,0,0,1,0,3,0,1}
local moneypos = {x = 65, y = 57, z = 7}
local piecepos = {x = 57, y = 54, z = 7}
local startpos = {x = 57, y = 60, z = 7}
local blockpos = {x = 64, y = 57, z = 7, id = 1486}

--Daqui para baixo recomendo não editar.
local topleft = {x = piecepos.x-1, y = piecepos.y-1, z = piecepos.z}
local bottomright = {x = startpos.x+1, y = startpos.y-2, z = startpos.z}
startpos.stackpos = 253
moneypos.stackpos = 1

function getZeros(table)
	zeros = 0
	for i = 1, #table do
		if table[i] == 0 then
			zeros = zeros+1
		end
	end
	return zeros
end

function doShowPoints(cid, level)
	local acertos = getPlayerStorageValue(cid, 21212)
	local erros = getPlayerStorageValue(cid, 21213)
	local passadas = (#music-getZeros(music))-acertos
	local porcentagem = (acertos/(#music-getZeros(music)))*100
	if porcentagem > 70 then
		nota = "Você é fera!!!"
	else
		nota = "Você é ruim..."
	end
	doTeleportThing(cid, outpos, 0)
	doShowTextDialog(cid, 2349, "-=--== "..nota.." ==--=-\n \n  *Notas acertadas: "..acertos..".\n  *Notas passadas: "..passadas..".\n  *Notas erradas: "..erros..".\n  *Nota final: "..math.floor(porcentagem).."%")
	if porcentagem >= premios[level].PERCENT then
		local item = doPlayerAddItem(cid, premios[level].REWARD, 1)
		doSetItemSpecialDescription(item, "It was rewarded by "..getCreatureName(cid).." at dificulty level "..level..".")
		doSendMagicEffect(getCreaturePosition(cid), math.random(28, 30))
	end
end

function getPieces(frompos, topos)
	local notes = {}
	for X = frompos.x, topos.x do
		for Y = frompos.y, topos.y do
			stack = 1
			found = 0
			pos = {x = X, y = Y, z = frompos.z}
			repeat
				pos.stackpos = stack
				note = getThingfromPos(pos)
				if (note.itemid == 0) then break end
				if isInArray(pieces, note.itemid) == 1 then
					found = 1
					table.insert(notes, note.uid)
					break
				end
				stack = stack + 1
			until (found == 1)
		end
	end
	return notes
end

function doMovePieces(frompos, topos)
	local notes = getPieces(frompos, topos)
	for i = 1, #notes do
		local pos = getThingPos(notes[i])
		doTeleportThing(notes[i], {x=pos.x, y=pos.y+1, z=pos.z})
	end
end

function doGuitarHero(cid, level, n)
	if isPlayer(cid) == FALSE or n >= #music+5 then
		doPosRemoveItem(blockpos.id, 1, blockpos)
	end
	if n <= #music+5 then
		if music[n] ~= 0 and n <= #music then
			doCreateItem(pieces[music[n]], 1, {x = piecepos.x-2+music[n], y = piecepos.y-1, z = piecepos.z})
		end
		doMovePieces(topleft, bottomright)
		addEvent(doGuitarHero, levels[level], cid, level, n+1)
	else
		doShowPoints(cid, level)
	end
end

function onUse(cid, item, frompos, itemEx, topos) 
	if item.itemid == 1945 then
		local money = getThingfromPos(moneypos)
		if money.itemid == cost.id and money.type >= cost.count then
			doTeleportThing(cid, startpos, 0)
			setPlayerStorageValue(cid, 21212, 0)
			setPlayerStorageValue(cid, 21213, 0)
			for i = 1, 3 do
				local starteffect = {x = startpos.x-2+i, y = startpos.y, z = startpos.z}
				doSendDistanceShoot(frompos, starteffect, CONST_ANI_SNOWBALL)
				doSendMagicEffect(starteffect, 12)
			end
			doGuitarHero(cid, item.actionid - 4600, 1)
			doCreateItem(blockpos.id, 1, blockpos)
			doRemoveItem(money.uid, cost.count)
		else
			local plural = ""
			if cost.count > 1 then
				plural = "s"
			end
			doPlayerSendCancel(cid, "Put "..cost.count.." "..getItemName(cost.id)..""..plural.." on coal.")
			doSendMagicEffect(frompos, 2)
		end
	end
	return TRUE
end