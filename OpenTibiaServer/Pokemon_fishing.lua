local water = 5810
local crystal = 5885

local evo = {
        ["Squirtle"] = {"wartortle", 1, water},
        ["Wartortle"] = {"blastoise", 2, water, water},
        ["Magikarp"] = {"gyarados", 2, water, crystal},
		["Staryu"] = "starmie",
        ["Psyduck"] = "golduck",
        ["Goldeen"] = "seaking",
        ["Krabby"] = "kingler",
        ["Eevee"] = "vaporeon",
        ["Poliwag"] = "poliwhir",
        ["Poliwhir"] = "poliwrath",
        ["Horsea"] = "seadra",
        ["Seal"] = "dewgoing",
        ["Slowpoke"] = "slowbro",
        ["Tentacool"] = "tentacruel",
}

local pokeballs = {
[2531] = {"Pokeball"},
[2557] = {"Superball"},
[2524] = {"Greatball"},
[2525] = {"Ultraball"},
[2523] = {"Masterball"},
}

local level = {
['abra'] = 15,
['shiny abra'] = 15,
['kadabra'] = 45,
['alakazam'] = 80,
['machop'] = 20,
['machoke'] = 45,
['machamp'] = 70,
['bellsprout'] = 5,
['weepinbell'] = 25,
['victreebel'] = 50,
['tentacool'] = 15,
['tentacruel'] = 75,
['shiny tentacool'] = 15,
['shiny tentacruel'] = 75,
['geodude'] = 15,
['graveler'] = 40,
['golem'] = 65,
['ponyta'] = 20,
['rapidash'] = 55,
['slowpoke'] = 15,
['slowbro'] = 45,
['magnemite'] = 15,
['magneton'] = 35,
['farfetchd'] = 40,
['shiny farfetchd'] = 40,
['duduo'] = 15,
['dodrio'] = 45,
['seel'] = 20,
['dewgong'] = 65,
['grimmer'] = 15,
['shiny grimmer'] = 15,
['muk'] = 35,
['shiny muk'] = 35,
['shellder'] = 10,
['cloyster'] = 60,
['gastly'] = 20,
['haunter'] = 45,
['gengar'] = 80,
['onix'] = 50,
['crystal onix'] = 50,
['drownzee'] = 25,
['hypno'] = 55,
['krabby'] = 10,
['shiny krabby'] = 10,
['klinger'] = 40,
['shiny klinger'] = 40,
['voltorb'] = 10,
['shiny voltorb'] = 10,
['electrode'] = 35,
['shiny electrode'] = 35,
['exeggcute'] = 10,
['exeggutor'] = 55,
['cubone'] = 20,
['marowak'] = 55,
['hitmonlee'] = 60,
['shiny hitmonlee'] = 60,
['hitmonchan'] = 75,
['shiny hitmonchan'] = 75,
['lickitung'] = 55,
['koffing'] = 15,
['weezing'] = 35,
['rhyhorn'] = 30,
['rhydon'] = 70,
['chansey'] = 60,
['tangela'] = 40,
['kangaskhan'] = 75,
['horsea'] = 10,
['shiny horsea'] = 10,
['seadra'] = 45,
['shiny seadra'] = 45,
['goldeen'] = 10,
['seaking'] = 35,
['staryu'] = 15,
['starmie'] = 35,
['mr.Mime'] = 60,
['scyther'] = 80,
['shiny scyther'] = 80,
['jynx'] = 75,
['shiny jynx'] = 75,
['electabuzz'] = 80,
['shiny electabuzz'] = 80,
['magmar'] = 80,
['pinsir'] = 45,
['tauros'] = 45,
['magikarp'] = 5,
['shiny magikarp'] = 5,
['gyarados'] = 85,
['shiny gyarados'] = 85,
['lapras'] = 80,
['ditto'] = 40,
['eevee'] = 20,
['vaporeon'] = 55,
['flareon'] = 55,
['jolteon'] = 55,
['porygon'] = 40,
['omanyte'] = 20,
['omastar'] = 80,
['kabuto'] = 20,
['kabutops'] = 80,
['snorlax'] = 85,
['articuno'] = 100,
['zapdos'] = 100,
['moltres'] = 100,
['dratini'] = 20,
['shiny dratini'] = 20,
['dragonair'] = 60,
['dragonite'] = 90,
['mew'] = 150,
['mewtwo'] = 160,
['beedrill'] = 3,
['shiny beedrill'] = 3,
['bulbasaur'] = 20,
['ivysaur'] = 40,
['venusaur'] = 85,
['charmander'] = 20,
['charmeleon'] = 40,
['charizard'] = 85,
['elder charizard'] = 150,
['squirtle'] = 20,
['wartortle'] = 40,
['blastoise'] = 85,
['shiny blastoise'] = 85,
['caterpie'] = 1,
['metapod'] = 10,
['butterfree'] = 30,
['shiny butterfree'] = 30,
['weedle'] = 1,
['kakuna'] = 10,
['pidgey'] = 5,
['pidgeotto'] = 20,
['pidgeot'] = 65,
['rattata'] = 1,
['raticate'] = 20,
['shiny rattata'] = 1,
['shiny raticate'] = 20,
['spearow'] = 5,
['fearow'] = 50,
['ekans'] = 15,
['arbok'] = 30,
['pikachu'] = 20,
['raichu'] = 45,
['shiny raichu'] = 45,
['sandshrew'] = 20,
['sandslash'] = 55,
['nidoranFE'] = 10,
['nidorina'] = 30,
['nidoqueen'] = 65,
['nidoranMA'] = 10,
['nidorino'] = 25,
['nidoking'] = 65,
['clefairy'] = 20,
['clefable'] = 35,
['vulpix'] = 15,
['ninetales'] = 65,
['jigglypuff'] = 20,
['wigglytuff'] = 45,
['zubat'] = 10,
['golbat'] = 30,
['oddish'] = 5,
['gloom'] = 25,
['vileplume'] = 50,
['paras'] = 5,
['parasect'] = 50,
['shiny paras'] = 5,
['shiny parasect'] = 50,
['venonat'] = 20,
['venomoth'] = 50,
['shiny venomoth'] = 50,
['diglett'] = 10,
['dugtrio'] = 35,
['meowth'] = 15,
['persian'] = 25,
['psyduck'] = 20,
['golduck'] = 55,
['mankey'] = 15,
['primeape'] = 50,
['growlithe'] = 25,
['shiny growlithe'] = 25,
['arcanine'] = 80,
['shiny arcanine'] = 80,
['poliwag'] = 5,
['poliwhirl'] = 25,
['poliwrath'] = 65,
}

function Evolve(cid,itemEx,item,name, ball, toPosition, level)
doRemoveCreature(itemEx.uid)
local summon = doCreateMonster(name, toPosition)
doConvinceCreature(cid, summon)
doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "name", "".. name .." "..ball)
doItemSetAttribute(getPlayerSlotItem(cid, 8).uid, "level", level)
doSendMagicEffect(getThingPos(summon), 18)
end

function onUse(cid, item, fromPosition, itemEx, toPosition)
    if isMonster(itemEx.uid) and getCreatureMaster(itemEx.uid) == cid then
        local monster  = getCreatureName(itemEx.uid)
		local pokem = evo[monster]
		local balls = pokeballs[getPlayerSlotItem(cid,8).itemid]
        if evo[monster] then
			local lvl = level[pokem[1]]
			if lvl <= getPlayerLevel(cid) then
				if pokem[2] == 1 and pokem[3] == item.itemid then
					doRemoveItem(item.uid)
					Evolve(cid,itemEx,item,pokem[1],balls[1], toPosition, lvl)
				elseif pokem[2] == 2 and (item.itemid == pokem[3] or item.itemid == pokem[4]) and pokem[3] == pokem[4] then
					if getPlayerItemCount(cid, pokem[3]) >= 2 then
						doPlayerRemoveItem(cid,pokem[3],2)
						Evolve(cid,itemEx,item,pokem[1],balls[1], toPosition, lvl)
					else
						return doPlayerSendCancel(cid, "you need another stone to evolve this pokemon.")
					end
				elseif pokem[2] == 2 and (item.itemid == pokem[3] or item.itemid == pokem[4]) and pokem[3] ~= pokem[4] then
					if getPlayerItemCount(cid, pokem[3]) >= 1 and getPlayerItemCount(cid, pokem[4]) >= 1  then
						doPlayerRemoveItem(cid,pokem[4],1)
						doPlayerRemoveItem(cid,pokem[3],1)
						Evolve(cid,itemEx,item,pokem[1],balls[1], toPosition, lvl)
					else
						return doPlayerSendCancel(cid, "you need another stone to evolve this pokemon.")
					end
				else
					return doPlayerSendCancel(cid, "you can't evolve this pokemon with this stone.")	
				end
			else
				return doPlayerSendCancel(cid, "You can only evolve this pokemon at level "..lvl..".")	
			end
		else
			return doPlayerSendCancel(cid, "You can't evolve this pokemon.")	
        end
	else
		return doPlayerSendCancel(cid, "You can only evolve your own pokemon.")	
	end
return true
end