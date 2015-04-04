/********************************************************************************/
/**********************NÃO EDITE NADA DAQUI PARA BAIXO***************************/
/********************************************************************************/
/*
Gladiatus/Mfinish
Gladiatus/Mreset
Gladiatus/Mget
Gladiatus/reset
*/
/********************************************************************************/
/**********************NÃO EDITE NADA DAQUI PARA BAIXO***************************/
/********************************************************************************/
var i, r, vida, stMiss, Abkr, Bbkr, DHdl, Mhdl, pt, protest,data,dathdl,pthdl,potcount=0;
var macroList = new Array();
macroList.push("Gladiatus/Exped");
macroList.push("Gladiatus/Masmorra");
/********************************************************************************/
iimDisplay("Gladiatus Bot ON");

function allow() {
pt = iimPlay("Gladiatus/Protect");
	if (pt < 0) {
	return false
	}
protest = iimGetLastExtract(1);

for (i = 0; i < AllowedChar.length; i++) {
allowed = AllowedChar[i].id
pthdl = protest.slice((protest.length-allowed.length),protest.length);
	if (pthdl == AllowedChar[i].id) { 	
		if (date(i)) { return true }
	}
	else	
	iimDisplay("this account is not allowed to use gladiatus bot");
}
return false
}

function date(id) {
pt = iimPlay("Gladiatus/date"); 
var first=6,second=10
	if (pt < 0) {
	return false
	}
	data = iimGetLastExtract(1); 
	for (j=2; j>=0; j--) {
	dathdl = parseInt(data.slice(first,second));
	iimDisplay(dathdl+" tst "+AllowedChar[id].date[j]);
		if (dathdl <= AllowedChar[id].date[j]) {
			if (j==0 || dathdl < AllowedChar[id].date[j]) { return true }
			first=first-3;
			second=first+2;
		}	
		else {break}
	}
iimDisplay("your license expired");
return false
}

var AllowedChar =  [ { "id" : "15641", "date" : new Array(2,6,2013) } ]

function cont(e) {
iimSet("HASH",HASH); iimSet("SERVER",server);
if (country="br") { iimSet("BR","br."); iimSet("CTR","com"); } else { iimSet("BR",""); iimSet("CTR",country); }
iimPlay("Gladiatus/Principal"); iimPlay("Gladiatus/daily"); iimPlay("Gladiatus/daily");
if (allow()==false) { return false }
iimPlay("Gladiatus/Vida"); 
vida = iimGetLastExtract(1);  
	if (vida.substring(0,(vida.length-2)) > Life && (ignore || e[0]==1 || e[1]==1)) {
	return true
	}
	if (vida.substring(0,(vida.length-2)) < Life && (potcount < Potion[1]) && Potion[0]) {
	var pcot=1;
		while (pcot<=3) {
		iimSet("VARI",pcot);
		iimSet("HASH",HASH);
		iimSet("SERVER",server);
		if (country="br") { iimSet("BR","br."); iimSet("CTR","com"); } else { iimSet("BR",""); iimSet("CTR",country); }
		iimPlay("Gladiatus/Potioncheck");
		potName = iimGetLastExtract (1); 
			if (potName=="Poção de Saúde 100%") { iimSet("HASH",HASH);
						iimSet("SERVER",server);
						if (country="br") { iimSet("BR","br."); iimSet("CTR","com"); } else { iimSet("BR",""); iimSet("CTR",country); }
						iimSet("VARI",pcot);
						iimPlay("Gladiatus/Potion");
						potcount++;
						return true
			}
                pcot++;
		}	
	}
return false
}

function pegarMis(Txt) {
	for (k = 0; k< Mnomes.length; k++) {
	THDL = Txt;
	THDL = THDL.substring(0,Mnomes[k].length).toLowerCase();
		if (THDL == Mnomes[k]) { 
		return true
		}
	}
return false
}

//INICIAR O LOOP DO BOT
while (cont(Exec)) {
// EXPEDIÇÂO E MASMORRA
    for (i = 0; i < macroList.length; i++) {
        if (Exec[i]) {
            if (i==0) { iimSet("LOCAL",locEM[i]); iimSet("BIXO",EXPATK); }
            if (i==1) {
                if (MASM[1]==0) { iimSet("HASH",HASH); iimSet("LOCAL",locEM[i]); iimSet("TIPO",MASM[3]);  iimPlay("Gladiatus/MasmRestart.iim"); }
                else if (MASM[1]==MASM[2]) { iimSet("HASH",HASH); iimSet("HASHP",HASH); iimSet("LOCAL",locEM[i]); iimSet("TIPO",MASM[3]); iimPlay("Gladiatus/MasmRestart.iim"); MASM[2]=0; }
                if (MASM[0]==1) { Mhdl=1; } else { Mhdl=MASM[0][MASM[2]]; }
                iimSet("HASH",HASH);
		iimSet("SERVER",server);
		if (country="br") { iimSet("BR","br."); iimSet("CTR","com"); } else { iimSet("BR",""); iimSet("CTR",country); }
                iimSet("LOCAL",locEM[i]); iimSet("BIXO",Mhdl);
                }
            r = iimPlay(macroList[i]);
            if (r < 0) {
            iimDisplay("Erro - stopping this case -- "+macroList[i]); 
            Exec[i]=0;
            } 
            else if (i==1) MASM[2]++;
        }
    } 
// FIM EXPEDIÇÂO E MASMORRA

// ARENA
	if (Exec[2]) { iimPlay("Gladiatus/Arena"); r = iimPlay("Gladiatus/chest"); if (r < 0){} }
// FIM ARENA

// CIRCUS TURMA
	if (Exec[3]) { iimPlay("Gladiatus/CT"); r = iimPlay("Gladiatus/chest"); if (r < 0){} }
// FIM CIRCUS TURMA

// CHECAR MISSÃO
if (checMis) {
	iimPlay("Gladiatus/miss"); Abkr=true; Bbkr=true;
	while (Abkr==true || Bbkr==true) {
		if (Abkr) { r = iimPlay("Gladiatus/Mfinish"); if (r < 0) Abkr=false; }
		if (Bbkr) { r = iimPlay("Gladiatus/Mreset");  if (r < 0) Bbkr=false; }
	}
}
// FIM CHECAR MISSÃO
 
// PEGAR MISSÃO 
if (getMis) {
	iimPlay("Gladiatus/miss");
	for (i = 1; i<=10; i++) {
		iimSet("VARI",(i)); iimPlay("Gladiatus/Mcheck"); stMiss = iimGetLastExtract (1)  
		if (pegarMis(stMiss)) { iimSet("POS",(i)); r = iimPlay("Gladiatus/Mget"); if ( r >= 0) { break; } }
		if (i==10) { r = iimPlay("Gladiatus/reset"); if (r<0) { } }
	}
}
// FIM PEGAR MISSÃO

// DOAR
	if (Doar) { iimSet("HASH",HASH); iimSet("SERVER",server); if (country="br") { iimSet("BR","br."); iimSet("CTR","com"); } else { iimSet("BR",""); iimSet("CTR",country); }iimPlay("Gladiatus/Doar"); }
// FIM DOAR

// DELAY
iimSet("DL",BDL);
	iimPlay("Gladiatus/delay");
// FIM DELAY
}
// ENDING BOT
//iimDisplay("killing bot -- ending instance");