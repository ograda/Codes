------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--      ESSENCIAL CONFIGURATION -----------------------------------------------
cure = {first=1,last=32,life=40} -- first cure id, last cure id, life % to cure
pack = {now=1,last=17,gold=50000, repack=false, total=1000000} -- actual pack id, last pack id, min gold to pack
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--      USUAL CONFIGURATION ---------------------------------------------------
Arena = {true,5,0} -- true para ir na arena // minutos de delay na arena // tem minutos adicionais para iniciar a arena?
Turma = {true,5,0} -- true para ir no ct // minutos de delay no ct // tem minutor adicionais para iniciar o ct?
working = {false,"f",3,1,false,false}  -- true para trabalhar // p para premium, f para free // quantas horas 1 ou maximo (3) // quantas vezes // desligar o pc? // work after bot?
Expedition = {true,4,5,false,20,3} -- ativar expedição? qual expedição? de quantos em quantos minutos? limite de expedições? quantas expedições quer fazer?
Dungeon = {true,'valeriaBOSS',5,false,17,0} -- ativar masmorra? qual masmorra (nome)? de quantos em quantos minutos? limite de masmorra? quantas masmorras quer fazer?
Mission = {delay=6,tostart=0,check=true,get=true --[[HDL]]} -- delay to start - checar - check=true, pegar get=trueMis
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--      SPECIAL CONFIGURATION ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Spconf = {develop = false, startDL = 0, debugging=false} --developing version? delay to start? debug mode?
Execution = {0,0*60,true,false} -- times to execute (0 to infinite) // minutes to execute // 0 to infinite // shutdown?
--		---------------------------------------------------		 --
--		--				   -------						 -- 	 --
--		-------------------HANDLER-------------------------		 --
--		--				   -------						 -- 	 --
--		--------------------------------------------------- 	 --
dofile("config.lua")
Patch = ''
Fight = {arena={s1={},s2={},s3={},s4={},s5={},s6={},s7={},s8={},s9={},s10={},s11={},s12={},s13={},s14={},s15={},s16={},s17={},s18={},s19={}},turma={s1={},s2={},s3={},s4={},s5={},s6={},s7={},s8={},s9={},s10={},s11={},s12={},s13={},s14={},s15={},s16={},s17={},s18={},s19={}}}
GOLD = {arena={s1={},s2={},s3={},s4={},s5={},s6={},s7={},s8={},s9={},s10={},s11={},s12={},s13={},s14={},s15={},s16={},s17={},s18={},s19={}},turma={s1={},s2={},s3={},s4={},s5={},s6={},s7={},s8={},s9={},s10={},s11={},s12={},s13={},s14={},s15={},s16={},s17={},s18={},s19={}}}
Delay = {Mission=os.time()+(Mission.tostart*60),Arena=os.time()+(Arena[3]*60),Turma=os.time()+(Turma[3]*60),Dungeon=os.time()+(Dungeon[6]*60),Expedition=os.time()+(Expedition[6]*60),Execution=os.time()+Execution[2]*60,start=os.time()+(60*Spconf.startDL),Proeza=os.time()}
Handler ={Life=100,Gold=50,Daily=false,Exit=true,mission=false,n=0,debugg=debugging,inicial=os.time()}
os.execute('CLS')print("------------------------------------------")print("------------------------------------------")print("--    ------------------------------    --")print("--    --                          --    --")print("--    --          Ograda          --    --")print("--    --        S17 Brasil        --    --")print("--    --  Ultimate Gladiatus Bot  --    --")print("--    --                          --    --")print("--    ------------------------------    --")print("------------------------------------------")print("------------------------------------------")
function Cturma(Dl)
	if (Turma[1]) then
		if (Dl <= os.time()) then
		arena(2)
		Delay.Turma = (os.time()+(Turma[2]*60)+math.random(5))-10
		end
	end
end
function Gmiss(Dl)
	if (Dl <= os.time()) then
	return true
	end
	return false
end
--		---------------------------------------------------		 --
--		--					-----						 -- 	 --
--		--------------------START-------------------------- 	 --
--		--					-----						 -- 	 --
--		--------------------------------------------------- 	 --


--[[ developing Area ]]-- [[

--]]
--[[ developing protect ]]  if (Spconf.develop) then pause(60000) end --]]
--[[ working support ]] 	if (working[1]) then
								while (working[4]) do
									working[4]=working[4]-1
									work(working[2],working[3],working[4])
								end
								if working[5] then
								os.execute('shutdown -s -t 600')
								os.exit ()
								end
							end --]]
--[[ starting delay ]] 		while os.time() < Delay.start do end --]]
--[[ starting usual bot]] -----------------------------------------
--[[ goes to start page]] start() --]]
--[[ loading atack list]] loadlist() --]]
--[[start]] while (Handler.Exit) do
--[[daily reward]] Hora,Min = horario()
				if (not Handler.Daily and ((Hora == 23 and Min >= 55) or (Hora == 0 and Min<15))) then
					while (Hora ~= 0) do Hora,Min = horario() os.execute('start '..Patch..'1.Exec\\gotoStart.wksp') pause(30) end
					os.execute('start '..Patch..'1.Exec\\MeiaNoite.wksp') pause(8)
				Handler.Daily=true
				end
				--]]
--[[ arena ]] if (Arena[1]) then
				while os.time() < Delay.Arena do end
	--[[ healing ]] Handler.Life = getPlayerLife() if (Handler.Life<=cure.life) then Handler.Exit=curar(cure.first,cure.last) cure.first=cure.first+1 end --]]				
				arena(1)
				Delay.Arena = (os.time()+(Arena[2]*60)+math.random(8))-10
			end --]]
--[[ turma? ]] Cturma(Delay.Turma) --]]
--[[ expedition ]]  if (Expedition[1]) then
						if (not Arena[1] or (Delay.Arena>=Delay.Expedition)) and (not Turma[1] or (Delay.Turma>=Delay.Expedition)) then
							while os.time() < Delay.Expedition do end
	--[[ healing ]] Handler.Life = getPlayerLife() if (Handler.Life<=cure.life) then Handler.Exit=curar(cure.first,cure.last) cure.first=cure.first+1 end --]]
							if ((Expedition[4] and Expedition[5] >= 1) or not Expedition[4]) then
								expedition(Expedition[2])
								Expedition[5]=Expedition[5]-1
								Delay.Expedition = os.time()+(Expedition[3]*60)+math.random(8)
							else
								Expedition[1]=false
							end
						end
					end
					-- ]]
--[[ turma? ]] Cturma(Delay.Turma)
--[[ dungeon ]]  if (Dungeon[1]) then
					if (not Arena[1] or (Delay.Arena>=Delay.Dungeon)) and (not Turma[1] or (Delay.Turma>=Delay.Dungeon)) then
							while os.time() < Delay.Dungeon do end
						if ((Dungeon[4] and Dungeon[5] >= 1) or not Dungeon[4]) then
							masmorra(Dungeon[2])
							Dungeon[5]=Dungeon[5]-1
							Delay.Dungeon = os.time()+(Dungeon[3]*60)+math.random(8)
						else
							Dungeon[1]=false
						end
					end
				end
					-- ]]
--[[ packing gold ]] Handler.Gold = getPlayerGold()
					if (Handler.Gold>=pack.gold and pack.now<=pack.last) then
						Handler.Exit=dopac(pack.now,pack.last,pack.repack,true)
						pack.now=pack.now+1
						Handler.Gold=Handler.Gold-pack.gold
						while (Handler.Gold>=pack.gold and pack.now<=pack.last) do
							Handler.Exit=dopac(pack.now,pack.last,pack.repack,false)
							pack.now=pack.now+1
							Handler.Gold=Handler.Gold-pack.gold
						end
						os.execute('start '..Patch..'1.Exec\\gotoStart.wksp') pause(6)
					elseif (pack.now>pack.last) then 
					Handler.Exit=false	
					end
--[[ complete Mission ]] if (Mission.check) then --[[ turma? ]] Cturma(Delay.Turma) --]]
 MissionPage() MissionCheck() pause(3) end --]]
--[[ turma? ]] Cturma(Delay.Turma) --]]
--[[check the minor delay]] if (Delay.Mission<=Delay.Arena) then
								if (Delay.Turma<=Delay.Mission) then while os.time() < Delay.Turma do end Cturma(Delay.Turma) end	
								while os.time() < Delay.Mission do end 
							end --]]
--[[ get Mission ]] if (Mission.get and Gmiss(Delay.Mission)) then MissionPage()
					MissionGet()
					pause(3) os.execute('start '..Patch..'6.Mission\\HomeHDL.wksp') pause(10)
					Delay.Mission = os.time()+(Mission.delay*60)
					end --]]
--[[ proeza ]] if Delay.Proeza<=os.time() then os.execute('start '..Patch..'1.Exec\\MAFIA.wksp') pause(6) Delay.Proeza=(os.time()+(60*5)+(math.random(5)*60)) end --]]
--[[ returning to initial state (handle) ]] os.execute('start '..Patch..'1.Exec\\gotoStart.wksp') pause(6) --]]
--[[ turma? ]] Cturma(Delay.Turma) --]]
--[[ execution times ]] Handler.n=Handler.n+1 print("executed "..Handler.n.." times (its about "..math.floor((os.time()-Handler.inicial)/3600).." hour(s) and "..(math.floor((os.time()-Handler.inicial)/60)-math.floor((os.time()-Handler.inicial)/3600)*60).." minute(s))") --]]
--[[ killing execution ]] if (((Execution[1] > 0 and Execution[1]>=n) or (Execution[2] > 0 and Delay.Execution<=os.time())) and Execution[3]) then pack[1]=pack[2] Execution[3]=false end --]]
--[[ killing execution 2]] if (not Arena[1] and not Turma[1] and not Expedition[1] and not Dungeon[1]) then Handler.Exit=false end
--[[ go home loop ]] GoHome() --]]
--[[ checking last turma ]] if (Delay.Turma<=Delay.Arena) then while os.time() < Delay.Turma do end Cturma(Delay.Turma) end
--[[ finishing loop ]] end --]]
--[[ checking last work ]]  if (working[6]) then
								while (working[4]) do
								    working[4]=working[4]-1
									work(working[2],working[3],working[4])
								end 
							end--]]
if Execution[4] then
os.execute('shutdown -s -t 600')
end
os.exit ()
--		---------------------------------------------------		 --
--		--					-------						 -- 	 --
--		--------------------LOG OUT------------------------ 	 --
--		--					-------						 -- 	 --
--		--------------------------------------------------- 	 --
