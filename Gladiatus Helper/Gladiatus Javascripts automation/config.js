Exec = new Array(1,1,1,1); // 1/0 para sim e não ( expedição , masmorra, arena , circus) <-> 1/0 to yes or no ( expedition , dungeon, arena , circus)
Life = 8; //  % de vida para parar o bot <-> Life % to stop working
Potion = new Array(true,2,"Poção de Saúde 100%") // True/false para usar ou não poções 100% e quantas usar, na terceira variavel usar o nome completo da poção 100% (copiar da pagina) <-> true/false to use or not 100% potions and how many you wanna use, the 3rd var just copy the full name of 100% potion of webpage.
Doar = false; // true/false para doar o gold para ally <-> true/false to donate all gold to ally
checMis = true; // true/fase para checar ou não missão <-> true/false to check or not missions
getMis = true; // true/fase para pegar ou não missão <-> true/false to get or not missions
/********************************************************************************/
ignore = true; // ignorar fim das expedições/masmorras? <-> ignore the lack of expedition and dungeon points?
Mnomes = new Array("penhasco do salto: vence 3 x x","arena","circus","vence"); /* missoes para pegar (letras minusculas) <-> mission kind to take (lowcase letters)
ex: se quer todas as missões de arena coloque "arena" <-> if you want to take all arena kind missions, add "arena"
se quer as missoes de um local de expedição, coloque "nome do local" <-> if you want all missions from a expedition place, add "exp place name"
se quer só um tipo de missão de um local de expedição "coloque até o nome do bixo" <-> if you just want a kind of monster, add "mission name until monster name apears" 
*/ 
EXPATK = 3 // qual monstro atacar na expedição (numero 1-4)<-> wich monster it will atack on expeditions (number 1-4)
locEM = new Array(7,1); // local de expedição <-> expedition place (index.php?mod=location&loc="2") || local de masmorra <-> dungeon place (index.php?mod=dungeon&loc="2")
MASM = [1,3,3,"avançado"] // Externsteine use {1,2} se não use 1 // matar até qual bixo? (para todos use 0) <-> kill until wich monster? (0 to all) // monstros derrotados <-> monster killed // dificuldade <-> dificult
server = 5; // server em que joga <-> your server (use just the number)
country = "br" // pais (br, de, fr.. etc P.S. UK = com) <-> country (for Uk use com)
HASH = "f486812f25f239e99968d39bf99bfdf7" // hash do jogador <-> player hash (&sh="number" on web adress)
BDL = 270 // segundos para reexecução <-> seconds between executions

iimPlay("Code:URL GOTO=imacros://run/?m=bot.js") // não mudar <-> don't change this