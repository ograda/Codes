local job = "numero do storage de quantos jobs o player tem"
local test = "numero do storage se o player esta em job test"
local alchemist = "numero do storage para o player da profissão"
local blacksmith = "numero do storage para o player da profissão"
local whitesmith = "numero do storage para o player da profissão"
local engineer = "numero do storage para o player da profissão"
local enchanter = "numero do storage para o player da profissão"
local collector = "numero do storage para o player da profissão"
local helper = "numero do storage para o player da profissão"
local jobalchemist = "numero do storage para o player que concluiu o teste"
local jobblacksmith = "numero do storage para o player que concluiu o teste"
local jobwhitesmith = "numero do storage para o player que concluiu o teste"
local jobengineer = "numero do storage para o player que concluiu o teste"
local jobenchanter = "numero do storage para o player que concluiu o teste"
local jobcollector = "numero do storage para o player que concluiu o teste"
local jobhelper = "numero do storage para o player que concluiu o teste"


local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid)
    npcHandler:onCreatureAppear(cid)
end
function onCreatureDisappear(cid)
    npcHandler:onCreatureDisappear(cid)
end
function onCreatureSay(cid, type, msg)
    npcHandler:onCreatureSay(cid, type, msg)
end
function onThink()
    npcHandler:onThink()
end
function say(param)
            npcHandler:say(param.text,param.cid)
         end

    function delayedSay(text, delay)
    if focus == 0 then
                return FALSE
    else
            addEvent(doCreatureSay, delay, getNpcCid(), text, TALKTYPE_PRIVATE_NP)
    end
end


function greetCallback(cid)
	if getPlayerStorageValue(cid,20001) == 5 then
		selfSay('Oh no! Was that really me? This is so embarassing, I have no idea what has gotten into me. Was that the fighting spirit you gaveme?', cid)
			talkState = 6
		return true
	else
		return true
	end
end


npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setMessage(MESSAGE_GREET, 'Welcome to my hood, |PLAYERNAME|.')


function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end


	if(msgcontains(msg, 'job') or msgcontains(msg, 'offer') or msgcontains(msg, 'help')) then
	if if getPlayerStorageValue(cid,jobs) == -1 then
	   selfSay("I am responsable to job subscriptions, do you need any help?", cid)
			talkState = 2

elseif getPlayerStorageValue(cid,jobs) == 0 or getPlayerStorageValue(cid,jobs) == 1 then
	   selfSay("Are you sure '.. getCreatureName(cid) ..', do you wanna take an job tutorial!?", cid)
			talkState = 3

elseif getPlayerStorageValue(cid,20000) >= 2 then
	   selfSay("Actually '.. getCreatureName(cid) ..', you are executing two jobs, to take a new one you must {cancel job} before.", cid)
end

elseif(msgcontains(msg, 'cancel test') or msgcontains(msg, 'quit test')) then 
if getPlayerStorageValue(cid,test) ~= 1 then
	   selfSay("you are not in a job test, you can take it anytime.", cid)
			talkState = 0
else
 selfSay("Do you want to cancel your subscription!?", cid)
			talkState = 14
end

elseif(msgcontains(msg, 'test') or msgcontains(msg, 'jobtest') or msgcontains(msg, 'job test')) then if getPlayerStorageValue(cid,test) ~= 1 then
	   selfSay("you are not in a job test, sorry.", cid)
			talkState = 0
else
 selfSay("Have you finished your job test!?", cid)
			talkState = 13
end

elseif(msgcontains(msg, 'cancel job') or msgcontains(msg, 'quit job')) then 
if getPlayerStorageValue(cid,jobs) <= 0 then
	   selfSay("You are not subscripted to any job, do you want to cancel a job test?.", cid)
			talkState = 14
else
 selfSay("What job do you want to cancel?", cid)
delayedSay("{Alchemist}, {blaclsmith}, {whitesmith}, {Engineer}, {enchanter}, {collector} and {helper}", 3000, cid)
			talkState = 15
end

elseif(talkState == 2) then
		if(msgcontains(msg, 'yes') or msgcontains(msg, 'sure')) then
		selfSay("Well, let's make a little explanation for you, attemping to get a job, you'll be able to do some special stuff ...", cid)
		delayedSay("Whenever you want to start a new carrier on a job, you must make a lil tutorial to get how this job works ...", 3000, cid)
		delayedSay("you may have 2 jobs at once, and you can cancel them whenever you want, it's just come here and speak to me, but note that canceling a job you'll loose all skills gained on it.", 7000, cid)
		delayedSay("With this lil introduction you'll be able to understand this sphere, do you wanna take an job tutorial now?.", 11000, cid)
			talkState = 3
	else
selfSay("so, whenever you need, i'll be here!!", cid)
			talkState = 0
end




	elseif(talkState == 3) then
		if(msgcontains(msg, 'yes') or msgcontains(msg, 'sure') or msgcontains(msg, 'of course') or msgcontains(msg, 'tutorial')) then
		selfSay("err, ok let\'s introduce you.", cid)
delayedSay("there are seven kinds of jobs, each one actuating in restricted areas ...", 2000, cid)
delayedSay("You may choose between {Alchemist}, {blaclsmith}, {whitesmith}, {Engineer}, {enchanter}, {collector} and {helper}.", 4500, cid)
delayedSay("After choosing one, i will explain it to you.", 8500, cid)
			talkState = 4

	else
		selfSay('ok, when you\'re ready come back here.', cid)
			npcHandler:releaseFocus(cid)
end

	elseif(talkState == 4) then
		if(msgcontains(msg, 'alchemist')) then
		selfSay("Alchemist eh!?", cid)
delayedSay("Alchemists are knowne by theyr abylities of creating potions ...", 2000, cid)
delayedSay("They can create red potions, purple potions and also antidote potions ...", 4500, cid)
delayedSay("Do you want to take a test for beeing alchemist?.", 6500, cid)
			talkState = 6

		elseif(msgcontains(msg, 'blacksmith')) then
		selfSay("Blacksmith eh!?", cid)
delayedSay("Blacksmith are knowne by theyr abylities of creating weapons ...", 2000, cid)
delayedSay("They can create any kind of weapons, and aprimorate theyr tecniques will made fine flesh weapons ...", 4500, cid)
delayedSay("Do you want to take a test for beeing Blacksmith?.", 6500, cid)
			talkState = 7

		elseif(msgcontains(msg, 'whitesmith')) then
		selfSay("Whitesmith eh!?", cid)
delayedSay("Whitesmith are knowne by theyr abylities of creating armors ...", 2000, cid)
delayedSay("They can create any kind of armors, and aprimorate theyr tecniques will made fine and effective armors ...", 4500, cid)
delayedSay("Do you want to take a test for beeing Whitesmith?.", 6500, cid)
			talkState = 8

		elseif(msgcontains(msg, 'engineer')) then
		selfSay("Engineer eh!?", cid)
delayedSay("Engineer are knowne by theyr abylities of creating traps ...", 2000, cid)
delayedSay("They can create very interesting traps, that can help you hunting creatures on civil wars agains rivals ...", 4500, cid)
delayedSay("Do you want to take a test for beeing Engineer?.", 6500, cid)
			talkState = 9

		elseif(msgcontains(msg, 'enchanter')) then
		selfSay("Enchanter eh!?", cid)
delayedSay("Enchanter are knowne by theyr abylities of enchanting things ...", 2000, cid)
delayedSay("They can enchant anything, weapons, armors, potions and whatever ...", 4500, cid)
delayedSay("Do you want to take a test for beeing Enchanter?.", 6500, cid)
			talkState = 10

		elseif(msgcontains(msg, 'collector')) then
		selfSay("Collector eh!?", cid)
delayedSay("Collector are knowne by theyr abylities of collecting primal materials from theyr natural sources ...", 2000, cid)
delayedSay("They can retrieve wood, sand, minerium and a lot else ...", 4500, cid)
delayedSay("Do you want to take a test for beeing Collector?.", 6500, cid)
			talkState = 11

		elseif(msgcontains(msg, 'helper')) then
		selfSay("Helper eh!?", cid)
delayedSay("Helper are knowne by theyr abylities of creating helpfull stuff with own hands ...", 2000, cid)
delayedSay("They can make a lot of util itens that can help you from hunting to organizing yourself on ...", 4500, cid)
delayedSay("Do you want to take a test for beeing Helper?.", 6500, cid)
			talkState = 12

		elseif(msgcontains(msg, 'yes') or msgcontains(msg, 'sure') or msgcontains(msg, 'of course') or msgcontains(msg, 'tutorial')) then
		selfSay("err, ok let\'s introduce you.", cid)
delayedSay("there are seven kinds of jobs, each one actuating in restricted areas ...", 2000, cid)
delayedSay("You may choose between {Alchemist}, {blaclsmith}, {whitesmith}, {Engineer}, {enchanter}, {collector} and {helper}.", 4500, cid)
delayedSay("After choosing one, i will explain it to you.", 8500, cid)
			talkState = 4

		elseif(msgcontains(msg, 'no') or msgcontains(msg, 'never') or msgcontains(msg, 'of course not')) then
		selfSay("ok, bye then, let me do my business.", cid)
			npcHandler:releaseFocus(cid)

	else
		selfSay('this is not a profession, do you want to try again? .', cid)
			talkState = 4
end

	elseif(talkState == 5) then
		if(msgcontains(msg, 'yes') or msgcontains(msg, 'sure') or msgcontains(msg, 'of course')) then
		selfSay("Here they come ...", cid)
delayedSay("You may choose between {Alchemist}, {blaclsmith}, {whitesmith}, {Engineer}, {enchanter}, {collector} and {helper}.", 1500, cid)
delayedSay("what is gonna be?", 4500, cid)
			talkState = 4

	else
		selfSay("ok, bye then, let me do my business.", cid)
			npcHandler:releaseFocus(cid)
end

	elseif(talkState == 6) then
		if(msgcontains(msg, 'yes') or msgcontains(msg, 'sure') or msgcontains(msg, 'of course')) then
		selfSay("You are now taking an Alchemist test.", cid)
delayedSay("just for you know, you can't run two tests at same time ...", 2000, cid)
delayedSay("after completing it, come here and say {job test}.", 4500, cid)
delayedSay("good bye, have a good test and lucky!", 5500, cid)
            setPlayerStorageValue(cid,test,1)
            setPlayerStorageValue(cid,alchemist,1)
			talkState = 0
			npcHandler:releaseFocus(cid)

	else
		selfSay('well, do you want to choose another profession?', cid)
			talkState = 5
end
	
	elseif(talkState == 7) then
		if(msgcontains(msg, 'yes') or msgcontains(msg, 'sure') or msgcontains(msg, 'of course')) then
		selfSay("You are now taking an Blacksmith test.", cid)
delayedSay("just for you know, you can't run two tests at same time ...", 2000, cid)
delayedSay("after completing it, come here and say {job test}.", 4500, cid)
delayedSay("good bye, have a good test and lucky!", 5500, cid)
            setPlayerStorageValue(cid,test,1)
            setPlayerStorageValue(cid,blacksmith,1)
			talkState = 0
			npcHandler:releaseFocus(cid)

	else
		selfSay('well, do you want to choose another profession?', cid)
			talkState = 5
end

	elseif(talkState == 8) then
		if(msgcontains(msg, 'yes') or msgcontains(msg, 'sure') or msgcontains(msg, 'of course')) then
		selfSay("You are now taking an Whitesmith test.", cid)
delayedSay("just for you know, you can't run two tests at same time ...", 2000, cid)
delayedSay("after completing it, come here and say {job test}.", 4500, cid)
delayedSay("good bye, have a good test and lucky!", 5500, cid)
            setPlayerStorageValue(cid,test,1)
            setPlayerStorageValue(cid,whitesmith,1)
			talkState = 0
			npcHandler:releaseFocus(cid)

	else
		selfSay('well, do you want to choose another profession?', cid)
			talkState = 5
end

	elseif(talkState == 9) then
		if(msgcontains(msg, 'yes') or msgcontains(msg, 'sure') or msgcontains(msg, 'of course')) then
		selfSay("You are now taking an engineer test.", cid)
delayedSay("just for you know, you can't run two tests at same time ...", 2000, cid)
delayedSay("after completing it, come here and say {job test}.", 4500, cid)
delayedSay("good bye, have a good test and lucky!", 5500, cid)
            setPlayerStorageValue(cid,test,1)
            setPlayerStorageValue(cid,engineer,1)
			talkState = 0
			npcHandler:releaseFocus(cid)

	else
		selfSay('well, do you want to choose another profession?', cid)
			talkState = 5
end

	elseif(talkState == 10) then
		if(msgcontains(msg, 'yes') or msgcontains(msg, 'sure') or msgcontains(msg, 'of course')) then
		selfSay("You are now taking an enchanter test.", cid)
delayedSay("just for you know, you can't run two tests at same time ...", 2000, cid)
delayedSay("after completing it, come here and say {job test}.", 4500, cid)
delayedSay("good bye, have a good test and lucky!", 5500, cid)
            setPlayerStorageValue(cid,test,1)
            setPlayerStorageValue(cid,enchanter,1)
			talkState = 0
			npcHandler:releaseFocus(cid)

	else
		selfSay('well, do you want to choose another profession?', cid)
			talkState = 5
end

	elseif(talkState == 11) then
		if(msgcontains(msg, 'yes') or msgcontains(msg, 'sure') or msgcontains(msg, 'of course')) then
		selfSay("You are now taking an collector test.", cid)
delayedSay("just for you know, you can't run two tests at same time ...", 2000, cid)
delayedSay("after completing it, come here and say {job test}.", 4500, cid)
delayedSay("good bye, have a good test and lucky!", 5500, cid)
            setPlayerStorageValue(cid,test,1)
            setPlayerStorageValue(cid,collector,1)
			talkState = 0
			npcHandler:releaseFocus(cid)

	else
		selfSay('well, do you want to choose another profession?', cid)
			talkState = 5
end

	elseif(talkState == 12) then
		if(msgcontains(msg, 'yes') or msgcontains(msg, 'sure') or msgcontains(msg, 'of course')) then
		selfSay("You are now taking an helper test.", cid)
delayedSay("just for you know, you can't run two tests at same time ...", 2000, cid)
delayedSay("after completing it, come here and say {job test}.", 4500, cid)
delayedSay("good bye, have a good test and lucky!", 5500, cid)
            setPlayerStorageValue(cid,test,1)
            setPlayerStorageValue(cid,helper,1)
			talkState = 0
			npcHandler:releaseFocus(cid)

	else
		selfSay('well, do you want to choose another profession?', cid)
			talkState = 5
end

	elseif(talkState == 13) then
		if(msgcontains(msg, 'yes') or msgcontains(msg, 'sure') or msgcontains(msg, 'of course')) then
if getPlayerStorageValue(cid,test2) == 1 then
		selfSay("Great.", cid)
delayedSay("You are now subscripted to a new job.", 2000, cid)


	if getPlayerStorageValue(cid,alchemist) == 1 then
            setPlayerStorageValue(cid,jobalchemist,1)
	elseif getPlayerStorageValue(cid,blacksmith) == 1 then
            setPlayerStorageValue(cid,jobblacksmith,1)
	elseif getPlayerStorageValue(cid,whitesmith) == 1 then
            setPlayerStorageValue(cid,jobwhitesmith,1)
	elseif getPlayerStorageValue(cid,enchanter) == 1 then
            setPlayerStorageValue(cid,jobenchanter,1)
	elseif getPlayerStorageValue(cid,engineer) == 1 then
            setPlayerStorageValue(cid,jobengineer,1)
	elseif getPlayerStorageValue(cid,helper) == 1 then
            setPlayerStorageValue(cid,jobhelper,1)
	elseif getPlayerStorageValue(cid,collector) == 1 then
            setPlayerStorageValue(cid,jobcollector,1)
	end
            setPlayerStorageValue(cid,jobs,getPlayerStorageValue(cid,jobs+1))
            setPlayerStorageValue(cid,test,0)
            setPlayerStorageValue(cid,collector,0)
            setPlayerStorageValue(cid,helper,0)
            setPlayerStorageValue(cid,engineer,0)
            setPlayerStorageValue(cid,enchanter,0)
            setPlayerStorageValue(cid,whitesmith,0)
            setPlayerStorageValue(cid,blacksmith,0)
            setPlayerStorageValue(cid,alchemist,0)
			talkState = 0
			npcHandler:releaseFocus(cid)
	else
		selfSay('You haven\'t completed your job tasks yet.', cid)
			talkState = 0
			npcHandler:releaseFocus(cid)
end
	else
		selfSay('well do you want to {cancel} your subscription?', cid)
			talkState = 14
end

elseif(talkState == 14) then
		if(msgcontains(msg, 'yes') or msgcontains(msg, 'sure') or msgcontains(msg, 'of course')) then
		selfSay("From now on you have been cut out from the job test list.", cid)
delayedSay("You are now subscripted to a new job.", 3000, cid)
            setPlayerStorageValue(cid,test,0)
            setPlayerStorageValue(cid,test2,0)
            setPlayerStorageValue(cid,collector,0)
            setPlayerStorageValue(cid,helper,0)
            setPlayerStorageValue(cid,engineer,0)
            setPlayerStorageValue(cid,enchanter,0)
            setPlayerStorageValue(cid,whitesmith,0)
            setPlayerStorageValue(cid,blacksmith,0)
            setPlayerStorageValue(cid,alchemist,0)
			talkState = 0
			npcHandler:releaseFocus(cid)

	else
		selfSay('then decide your life and come back.', cid)
			talkState = 0
end

elseif(talkState == 15) then
		if(msgcontains(msg, 'alchemist')) then
		selfSay("Alchemist eh!?", cid)
delayedSay("Do you want to cancel your subscription in this job", 2000, cid)
			talkState = 16

		elseif(msgcontains(msg, 'blacksmith')) then
		selfSay("Blacksmith eh!?", cid)
delayedSay("Do you want to cancel your subscription in this job", 2000, cid)
			talkState = 17

		elseif(msgcontains(msg, 'whitesmith')) then
		selfSay("Whitesmith eh!?", cid)
delayedSay("Do you want to cancel your subscription in this job", 2000, cid)
			talkState = 18

		elseif(msgcontains(msg, 'engineer')) then
		selfSay("Engineer eh!?", cid)
delayedSay("Do you want to cancel your subscription in this job", 2000, cid)
			talkState = 19

		elseif(msgcontains(msg, 'enchanter')) then
		selfSay("Enchanter eh!?", cid)
delayedSay("Do you want to cancel your subscription in this job", 2000, cid)
			talkState = 20

		elseif(msgcontains(msg, 'collector')) then
		selfSay("Collector eh!?", cid)
delayedSay("Do you want to cancel your subscription in this job", 2000, cid)
			talkState = 21

		elseif(msgcontains(msg, 'helper')) then
		selfSay("Helper eh!?", cid)
delayedSay("Do you want to cancel your subscription in this job", 2000, cid)
			talkState = 22

		elseif(msgcontains(msg, 'yes') or msgcontains(msg, 'sure') or msgcontains(msg, 'of course') or msgcontains(msg, 'tutorial')) then
		selfSay("well, then say what job do you want me to cancel your subscription.", cid)
delayedSay("You may choose between the existing ones {Alchemist}, {blaclsmith}, {whitesmith}, {Engineer}, {enchanter}, {collector} and {helper}.", 4500, cid)
			talkState = 15

		elseif(msgcontains(msg, 'no') or msgcontains(msg, 'never') or msgcontains(msg, 'of course not')) then
		selfSay("ok, bye then, let me do my business.", cid)
			npcHandler:releaseFocus(cid)

	else
		selfSay('this is not a profession, do you want to try again? .', cid)
			talkState = 15
end




elseif(talkState == 16) then
		if(msgcontains(msg, 'yes') or msgcontains(msg, 'sure') or msgcontains(msg, 'of course')) then
	if getPlayerStorageValue(cid,jobalchemist) == 1 then
		selfSay("You are now out of the alchemist list.", cid)
            setPlayerStorageValue(cid,jobs,getPlayerStorageValue(cid,jos)-1)
            setPlayerStorageValue(cid,jobalchemist,0)
			talkState = 0
			npcHandler:releaseFocus(cid)
else
		selfSay('you are not subscripted on this job.', cid)
		delayedSay("well, do you want to cancel another profession?", 3000, cid)
			talkState = 15
end

	else
		selfSay('well, do you want to cancel another profession?', cid)
			talkState = 15
end
	
	elseif(talkState == 17) then
		if(msgcontains(msg, 'yes') or msgcontains(msg, 'sure') or msgcontains(msg, 'of course')) then
	if getPlayerStorageValue(cid,jobblacksmith) == 1 then
		selfSay("You are now out of the blacksmith list.", cid)
            setPlayerStorageValue(cid,jobs,getPlayerStorageValue(cid,jos)-1)
            setPlayerStorageValue(cid,jobblacksmith,0)
			talkState = 0
			npcHandler:releaseFocus(cid)
else
		selfSay('you are not subscripted on this job.', cid)
		delayedSay("well, do you want to cancel another profession?", 3000, cid)
			talkState = 15
end

	else
		selfSay('well, do you want to cancel another profession?', cid)
			talkState = 15
end



	elseif(talkState == 18) then
		if(msgcontains(msg, 'yes') or msgcontains(msg, 'sure') or msgcontains(msg, 'of course')) then
	if getPlayerStorageValue(cid,jobwhitesmith) == 1 then
		selfSay("You are now out of the whitesmith list.", cid)
            setPlayerStorageValue(cid,jobs,getPlayerStorageValue(cid,jos)-1)
            setPlayerStorageValue(cid,jobwhitesmith,0)
			talkState = 0
			npcHandler:releaseFocus(cid)
else
		selfSay('you are not subscripted on this job.', cid)
		delayedSay("well, do you want to cancel another profession?", 3000, cid)
			talkState = 15
end

	else
		selfSay('well, do you want to cancel another profession?', cid)
			talkState = 15
end
         

	elseif(talkState == 19) then
		if(msgcontains(msg, 'yes') or msgcontains(msg, 'sure') or msgcontains(msg, 'of course')) then
	if getPlayerStorageValue(cid,jobengineer) == 1 then
		selfSay("You are now out of the engineer list.", cid)
            setPlayerStorageValue(cid,jobs,getPlayerStorageValue(cid,jos)-1)
            setPlayerStorageValue(cid,jobengineer,0)
			talkState = 0
			npcHandler:releaseFocus(cid)
else
		selfSay('you are not subscripted on this job.', cid)
		delayedSay("well, do you want to cancel another profession?", 3000, cid)
			talkState = 15
end

	else
		selfSay('well, do you want to cancel another profession?', cid)
			talkState = 15
end
           
	elseif(talkState == 20) then
		if(msgcontains(msg, 'yes') or msgcontains(msg, 'sure') or msgcontains(msg, 'of course')) then
			if getPlayerStorageValue(cid,jobenchanter) == 1 then
		selfSay("You are now out of the enchanter list.", cid)
            setPlayerStorageValue(cid,jobs,getPlayerStorageValue(cid,jos)-1)
            setPlayerStorageValue(cid,jobenchanter,0)
			talkState = 0
			npcHandler:releaseFocus(cid)
else
		selfSay('you are not subscripted on this job.', cid)
		delayedSay("well, do you want to cancel another profession?", 3000, cid)
			talkState = 15
end

	else
		selfSay('well, do you want to cancel another profession?', cid)
			talkState = 15
end
          
	elseif(talkState == 21) then
		if(msgcontains(msg, 'yes') or msgcontains(msg, 'sure') or msgcontains(msg, 'of course')) then
			if getPlayerStorageValue(cid,jobcollector) == 1 then
		selfSay("You are now out of the collector list.", cid)
            setPlayerStorageValue(cid,jobs,getPlayerStorageValue(cid,jos)-1)
            setPlayerStorageValue(cid,jobcollector,0)
			talkState = 0
			npcHandler:releaseFocus(cid)
else
		selfSay('you are not subscripted on this job.', cid)
		delayedSay("well, do you want to cancel another profession?", 3000, cid)
			talkState = 15
end

	else
		selfSay('well, do you want to cancel another profession?', cid)
			talkState = 15
end

	elseif(talkState == 22) then
		if(msgcontains(msg, 'yes') or msgcontains(msg, 'sure') or msgcontains(msg, 'of course')) then
					if getPlayerStorageValue(cid,jobhelper) == 1 then
		selfSay("You are now out of the helper list.", cid)
            setPlayerStorageValue(cid,jobs,getPlayerStorageValue(cid,jos)-1)
            setPlayerStorageValue(cid,jobhelper,0)
			talkState = 0
			npcHandler:releaseFocus(cid)
else
		selfSay('you are not subscripted on this job.', cid)
		delayedSay("well, do you want to cancel another profession?", 3000, cid)
			talkState = 15
end

	else
		selfSay('well, do you want to cancel another profession?', cid)
			talkState = 15
end


end

	return true
end


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())