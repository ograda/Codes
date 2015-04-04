-- [[ delaying function ]] -- 100%
function pause(delay)
    delay = delay or 1
    local time_to = os.time() + delay
    while os.time() < time_to do
	--[[ {} ]]
	end
end
			
-- [[ starting bot support ]] -- 100%
function start()
os.execute('start '..Patch..'1.Exec\\iniciar.wksp') pause(10)
end

-- [[ starting bot support ]] -- 100%
function GoHome()
os.execute('start '..Patch..'1.Exec\\home.wksp') pause(6)
end

-- [[ working bot ]] -- 100%
function work(k,H,fim)
os.execute('start '..Patch..'2.Trabalho\\trabHDL.wksp') pause(7)
	if k=="p" or k=="P" then
		if H==1 then
		os.execute('start '..Patch..'2.Trabalho\\trabPREM.wksp') pause(7)
		else
		H=3
		os.execute('start '..Patch..'2.Trabalho\\trabPRE3.wksp') pause(10)
		end
	else
		if H>1 then H=1 end
	os.execute('start '..Patch..'2.Trabalho\\trabFREE.wksp') pause(7)
	end
	if fim then
	pause((60*60*H)+math.random(120)+60)
	else
	pause(10)
	end
end

-- [[ loading list to avoid ]] -- 100%
function loadlist()
	for line in io.lines("arena.txt") do
		if string.match(line,"(.+) %d+") and string.match(line,".+ (%d+)") then
		table.insert(Fight.arena['s'..string.format("%s", string.match(line,".+ (%d+)"))],string.format("%s", string.match(line,"(.+) %d+")))
		end
	end
	for line in io.lines("Cturma.txt") do
		if string.match(line,"(.+) %d+") and string.match(line,".+ (%d+)") then
		table.insert(Fight.turma['s'..string.format("%s", string.match(line,".+ (%d+)"))],string.format("%s", string.match(line,"(.+) %d+")))
		end
	end
	for line in io.lines("GOLDARENA.txt") do
		if string.match(line,"(.+) %d+") and string.match(line,".+ (%d+)") then
		table.insert(GOLD.arena['s'..string.format("%s", string.match(line,".+ (%d+)"))],string.format("%s", string.match(line,"(.+) %d+")))
		end
	end
	for line in io.lines("GOLDTURMA.txt") do
		if string.match(line,"(.+) %d+") and string.match(line,".+ (%d+)") then
		table.insert(GOLD.turma['s'..string.format("%s", string.match(line,".+ (%d+)"))],string.format("%s", string.match(line,"(.+) %d+")))
		end
	end
end

-- [[ get time ]] -- 100%
function horario()
local H= tonumber(string.format("%s", string.match(os.date(),"%d+/%d+/%d+ (%d+):.+")))
local M= tonumber(string.format("%s", string.match(os.date(),"%d+/%d+/%d+ %d+:(%d+).+")))
return H,M
end

-- [[ expedition ]] -- 100%
function expedition(id)
os.execute('start '..Patch..'3.Expedition\\ExpedHDL.wksp') pause(6)
os.execute('start '..Patch..'3.Expedition\\exp('..id..').wksp') pause(6)
end

function masmorra(id)
os.execute('start '..Patch..'8.Dungeon\\DungHDL.wksp') pause(6)
os.execute('start '..Patch..'8.Dungeon\\'..id..'.wksp') pause(15)
end

-- [[ get player life ]] -- 100%
function getPlayerLife()
os.execute('start '..Patch..'4.Cure\\lifehandle.wksp') pause(6)
os.execute('start '..Patch..'paste.exe') pause(2)
file=io.open ("handle.txt", "r")
file:seek ("set")
tnum=file:read("*l")
num=tonumber(tnum)
file:close ()
	if num==nil then num=0 end
return num
end

-- [[ cure ]] -- 100%
function curar(id,Max)
os.execute('start '..Patch..'4.Cure\\cure('..id..').wksp') pause(8)
    if id<Max then return true else return false end
end

-- [[ get player gold ]] -- 100%
function getPlayerGold()
os.execute('start '..Patch..'5.Pack\\pacthandle.wksp') pause(6)
os.execute('start '..Patch..'paste.exe') pause(2)
file=io.open ("handle.txt", "r")
file:seek ("set")
tnum=file:read("*l")
num=tonumber(tnum)
	if num ~= nil then if string.len(tnum)>3 and (num>=1.001) then num=num*1000 end end
file:close ()
	if num==nil then num=50 end
return num
end

-- [[ packet ]] -- 100% --[[ ograda ]] resell
function dopac(id,Max,resell,first)
if (first) then
os.execute('start '..Patch..'5.Pack\\gotopact.wksp') pause(20)
end
os.execute('start '..Patch..'5.Pack\\pack('..id..').wksp') pause(18)
    if (id<Max) then return true else if (resell) then reSell(Max) else return false end end
end

-- [[ Arena ]] -- 100%
function arena(tipo)
local tab={[1]='arena',[2]='turma'}
local gladiador = {nome="",level=200,prov=0,id=0}
local nome,provincia,level = {}, {}, {}
os.execute('start '..Patch..'7.Arenas\\GO'..tab[tipo]..'.wksp') pause(5)
os.execute('start '..Patch..'7.Arenas\\ARHandle.wksp') pause(8)
os.execute('start '..Patch..'paste.exe') pause(2)
	for line in io.lines("handle.txt") do
		if string.match(line,"(.+)%s+%d+%s+%d+") and string.match(line,".+%s+(%d+)%s+%d+") and string.match(line,".+%s+%d+%s+(%d+)")  then
		table.insert(nome,string.format("%s", string.match(line,"(.+)%s+%d+%s+%d+"))) table.insert(level,tonumber(string.format("%s", string.match(line,".+%s+(%d+)%s+%d+")))) table.insert(provincia,tonumber(string.format("%s", string.match(line,".+%s+%d+%s+(%d+)"))))
		end
	end
	if #nome>=3 then
		for list=1,#nome do
			local var = false
			local GoldGlad = false
				if provincia[list]~=nil then
					for best=1,#GOLD[tab[tipo]]['s'..provincia[list]] do
						if nome[list]==GOLD[tab[tipo]]['s'..provincia[list]][best] then
						gladiador.level = level[list]
						gladiador.id = list
						GoldGlad = true
						break
						end
					end
				end
			if (GoldGlad) then break end
				if gladiador.level>=level[list] then
					for test=1,#Fight[tab[tipo]]['s'..provincia[list]] do
						if nome[list]==Fight[tab[tipo]]['s'..provincia[list]][test] then
						var=true
						break
						end
					end
					if not var then
					gladiador.level = level[list]
					gladiador.id = list
					end
				end
		end
	end
		if gladiador.id==0 then math.randomseed(os.time()) gladiador.id = math.random(1,5) end
		os.execute('start '..Patch..'7.Arenas\\Arena('..gladiador.id..').wksp') pause(8)
		os.execute('start '..Patch..'7.Arenas\\Bau.wksp') pause(5)
		os.execute('start '..Patch..'1.Exec\\gotoStart.wksp') pause(5)
end

-- [[ mission HDL ]] -- 100%
function MissionPage()
os.execute('start '..Patch..'6.Mission\\phanteon.wksp') pause(8)
os.execute('start '..Patch..'6.Mission\\PHcopy.wksp') pause(18)
os.execute('start '..Patch..'paste.exe') pause(2)
end

-- [[ mission CHECK ]] -- 100%
function MissionCheck()
	local acc={}
	local hdl = nil
		for line in io.lines("handle.txt") do
			if string.match(line,'.+<div id="quest_header_accepted">.+ aceites: (%d) / %d</div>+') and string.match(line,'.+<div id="quest_header_accepted">.+ aceites: %d / (%d)</div>+') then
			hdl=string.match(line,'.+<div id="quest_header_accepted">.+ aceites: (%d) / %d</div>+') 
			end
			if (hdl=='0') then return
			else
				if string.match(line,'<a class=".+slot_button_finish" href=".+finishQuest&amp;questPos=(%d+)&amp;.+" title="Acabar missão"></a>') then
					table.insert(acc,string.format('%d',string.match(line,'<a class=".+slot_button_finish" href=".+finishQuest&amp;questPos=(%d+)&amp;.+" title="Acabar missão"></a>')))
				elseif string.match(line,'<a class=".+slot_button_restart" href=".+restartQuest&amp;questPos=(%d+)&amp;.+" title="Reiniciar missão"></a>') then
					table.insert(acc,string.format('%d',string.match(line,'<a class=".+slot_button_restart" href=".+restartQuest&amp;questPos=(%d+)&amp;.+" title="Reiniciar missão"></a>')))
				end
			end
		end
		UseMission(acc)
end

-- [[ mission GET ]] -- 100%
function MissionGet()
	local got=false
	local acc={}
	local test, num = false,1
	for line in io.lines("handle.txt") do
		local hdl1, hdl2 = nil,nil
		if string.match(line,'.+<div id="quest_header_accepted">.+ aceites: (%d) / %d</div>+') and string.match(line,'.+<div id="quest_header_accepted">.+ aceites: %d / (%d)</div>+') then
			hdl1, hdl2=string.match(line,'.+<div id="quest_header_accepted">.+ aceites: (%d) / %d</div>+'),string.match(line,'.+<div id="quest_header_accepted">.+ aceites: %d / (%d)</div>+')
			if hdl1==hdl2 then return end
		end
		if not (test) then
			if string.match(line,'.+<div class=".+contentboard_slot_(.+)">.+') then
				hdl1=string.match(line,'.+<div class.+contentboard_slot_(inactive)".+')
				if hdl1=='inactive' then
					test=true
				else
					num=num+1
				end
			end
		else
		test=false
			if string.match(line,'<div class="quest_slot_title">(.+)</div>') then
				local tipo = string.match(line,'.+<div class="quest_slot_title">(.+)</div>')
			 if(testMission(tipo)) then table.insert(acc,num) got=true end
			if (got) then break end	
			num=num+1
			end
		end
	end
	if not (got) then table.insert(acc,num) end
	UseMission(acc)
end

-- [[ test mission ]] -- 100%
function testMission(kind)
local missoes = {'Circus','Vence','Arena'}-- ,'Arena'
	for i=1,#missoes do
	hdl=kind
		if string.match(string.sub(hdl,0,string.len(missoes[i])),missoes[i]) then
		return true
		end
	end
	return false
end

-- [[ Mission use ]] -- 100%
function UseMission(arr)
	for Miz=1,#arr do
		while (Delay.Mission<=25) do end
	os.execute('start '..Patch..'6.Mission\\PHhandler.wksp') pause(14)
		if (tonumber(arr[Miz])<=10) then
		os.execute('start '..Patch..'6.Mission\\phanteon('..arr[Miz]..').wksp') pause(6)
		else
		os.execute('start '..Patch..'6.Mission\\ResetMission.wksp') pause(6)
		end
	end
end