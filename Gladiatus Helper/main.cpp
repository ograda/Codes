#include <stdio.h>
#include <stdlib.h>
#include <conio.h>
#include <windows.h>
#include <cstdlib>
#include <math.h>
#include <string>
#include <iostream>
#include "biblioteca.h"

using namespace std;
string nomes[3][8][4]={
{
{"Rato","Lince","Lobo","Urso"},
{"Escravo Fugitivo","Soldado Corrupto","Assassino","Capitao"},
{"Recruta Fugitivo","Harpia","Cerberus","Medusa"},
{"Javali","Alcateia","Lobo Alfa","lobisomen"},
{"Guarda Culista","Homem Rato","Minotauro","Chefe Minotauro"},
{"Barbaro","Guerreiro Barbaro","Berserker","Chefe Barbaro"},
{"Soldado Renegado","merren","Sicario","Chefe Bandido"}  
},{
{"Cobra","Escoriao Gigante","Mumia Desperta","Seth"},
{"Cobrador de Impostos","Canibal","Guerreiro da Tribo","Xama dos Osso"},
{"Lobo Sangnguiario","Escaravelho Gigante","Dancador de Fogo","Demonio de Fogo"}, 
{"Crocodilo","Portador Morto-Vivo","Cobra de Agua Gigante","Mokele Mbembe"},
{"Guerreiro da Tribo","Mago da Tribo","Espirito Guerreiro","Sumo-Sacerdote Seth"},
{"Espiao","Guarda da Caravana","Guarda Elite","Comerciante de Escravos"},
{"Elefante","Chita","Leao Demobiaco","Elefante Demoniaco"},
{"Antilope Amaldicoado","Aranha Gigante","Xama","Sumo-Xama"}
},{
{"Legionario","Myrmidao","Centuriao","Alma Negra"},
{"Javali","Senhor do Pantano","Espirito do Pantano","Homem Urso"},
{"Huno","Ancestral","Nachzerer","Abominacao"},
{"Esqueleto Guerreiro","Esqueleto Berserker","Lich","Principe Necromancer"}    
}};
struct glad { int level, vida, hab, agi, car, arm, min, max, ecrit, blok, crit; };
glad g;
int V=0,D=0,E=0;

glad Transferir(monstro m) 
{
    glad tmp;
    tmp.level=m.level;  
    tmp.vida=m.vida; 
    tmp.hab=m.hab;  
    tmp.agi=m.agi; 
    tmp.car=m.car; 
    tmp.arm=m.arm; 
    tmp.min=m.min; 
    tmp.max=m.max; 
    tmp.ecrit=m.ecrit; 
    tmp.arm=m.arm; 
    tmp.crit=m.crit;
    return tmp;
} 

int ataque(glad A, glad D) {
    int q,crit,dmg=0,tot,armM,armm;
    armM=ceil((D.arm/66)+((D.arm-66)/660)-1); if (armM<0) armM=0;
    armm=ceil((D.arm/66)-((D.arm-66)/660)); if (armm<0) armm=0;
    q=1; tot=0; if (A.car>D.car) {crit=(A.car-D.car); if(crit>100) crit=100; if (crit>=(rand() % 100 + 1)) q++;}
    do {     
       if ( floor ((A.hab*100)/(A.hab+D.agi))>=(rand() % 100 + 1) ) {
       dmg=(A.min+ rand() %(A.max-A.min));
           if (A.crit>=(rand() % 100 + 1) && D.ecrit<(rand() % 100 + 1))
           dmg*=2; dmg-=(armm+rand() %(armM-armm));
               if (D.blok>=(rand() % 100 + 1))
               dmg=dmg*(rand() % 35 + 35)/100; }
       tot+=dmg; q--; 
       } while (q>0);
    return tot;
}

void COMBATE(monstro m, int *Dpt, int *Dmt, int MAX) 
{
     int Vp,Vm,Dp,Dm;
     glad monts;
     monts=Transferir(m);
     for (int j=1; j<=MAX; j++)
     {
         Vp=g.vida; Vm=m.vida; Dp=0; Dm=0;
             for (int i=1; i<=20; i++)
             {
             Vm-=ataque(g,monts); 
             Vp-=ataque(monts,g);
             if (Vm<=0 || Vm<=0) break;
             }
        if (Vm<=0) Dp=m.vida; else Dp=m.vida-Vm; if (Vp<=0) Dm=g.vida; else Dm=g.vida-Vp; *Dpt+=Dp; *Dmt+=Dm;
            if ((Dp==Dm && Vp>=2 && Vm>=2) || (Vm<=0 && Vp<=0)) E++;
            else
                if ((Vp<=0 && Vm>=2) || (Dp<Dm && Vp>0 && Vm>0)) D++;
                else V++;  
        }   
     return;
}

void batalha(int p,int t,int b)
{
     monstro temp;
     int MAX=300;
     int MMin,MMax,DPT=0,DMT=0,L;
     system("cls"); 
         switch (b)
         {
         case 1: MMin=0; MMax=1; break;
         case 2: MMin=2; MMax=5; break;
         case 3: MMin=6; MMax=10; break;
         case 4: MMin=11; MMax=13; break;
         }
     V=0;D=0;E=0;
     L=(MMax-MMin+1)*MAX;   
     for (int i=MMin; i<=MMax ;i++) {
     temp=mundo[p-1][t-1][i]; COMBATE(temp,&DPT,&DMT,MAX); }
     printf("Seu percentual de Vitoria e: %.2f\nSeu percentual de Derrotas e: %.2f\nSeu percentual de Empates e: %.2f",(float) (100*V)/L,(float) (100*D)/L,(float) (100*E)/L); 
     printf("\n\nO Dano medio feito foi: %.2f\nO Dano medio recebido foi: %.2f\n",(float) DPT/L,(float) DMT/L);
     system("pause");      
return;
}

void cadastra() 
{
     system("cls");
     printf("digite o level do gladiador: "); scanf("%i",&g.level); if (g.level<1) g.level=1;
     printf("digite a vida maxima do gladiador: "); scanf("%i",&g.vida); if (g.vida<2) g.vida=2;
     printf("digite a habilidade do gladiador: "); scanf("%i",&g.hab); if (g.hab<5) g.hab=5;
     printf("digite a agilidade do gladiador: "); scanf("%i",&g.agi); if (g.agi<5) g.agi=5;
     printf("digite a carisma do gladiador: "); scanf("%i",&g.car); if (g.car<5) g.car=5;         
     printf("digite a armadura do gladiador: "); scanf("%i",&g.arm); if (g.arm<0) g.arm=0;
     printf("digite o dano minimo do gladiador: "); scanf("%i",&g.min); if (g.min<0) g.min=0;
     printf("digite o dano maximo do gladiador: "); scanf("%i",&g.max); if (g.max<2) g.max=2; if (g.min>=g.max) g.min=(g.max-2);
     printf("digite a porcentagem de evitar criticos: "); scanf("%i",&g.ecrit); if (g.ecrit<0) g.ecrit=0;
     printf("digite a porcentagem de bloqueio: "); scanf("%i",&g.blok); if (g.blok<0) g.blok=0;
     printf("digite a porcentagem de ataque critico: "); scanf("%i",&g.crit); if (g.crit<0) g.crit=0;
}

void escolha() 
{  
     char aux;
     int p=0,t=0,e=0;
     looppais:
     do {
     system("cls"); 
     printf("\n\n\n\n\n\n\t\t\t1. Italia\n\t\t\t2. Africa\n\t\t\t3. Germania\n\n\n\n\n\n\t0 para voltar, Mover para que pais? ");
     aux=getch(); p=atoi(&aux);
         if (p<0 || p>3) {
         printf("\nO pais deve ser um valor entre 1 e 3 (use o 0 para voltar)"); Sleep(2500); }
     } while (p<0 || p>3);
     loopterra:  
            switch (p)
            {      
                   case 1:  case 2: case 3:
                   do {      
                   system("cls");
                   if (p==1) printf("\n\n\n\n\n\n\t\t\t1. Bosques Escuros\n\t\t\t2. Porto Pirata\n\t\t\t3. Monte Nevoeiro\n\t\t\t4. Gruta do Lobo\n\t\t\t5. Templo Antigo\n\t\t\t6. Povo Barbaro\n\t\t\t7. Acampamento dos bandidos\n\n\n\n\n\n\t0 para voltar, Mover para que territorio? ");
                   if (p==2) printf("\n\n\n\n\n\n\t\t\t1. Temploo Voodoo\n\t\t\t2. Ponte\n\t\t\t3. Caverna de Sangue\n\t\t\t4. Porto Perdido\n\t\t\t5. Tribo Umpokta\n\t\t\t6. Caravana\n\t\t\t7. Mesoa-Oasis\n\t\t\t8. Penhasco do salto (desenvolvimento)\n\n\n\n\n\n\t0 para voltar, Mover para que territorio? ");
                   if (p==3) printf("\n\n\n\n\n\n\t\t\t1. Templo da Caverna\n\t\t\t2. A Floresta Verde\n\t\t\t3. Vila Amaldicoada\n\t\t\t4. Monte da Morte\n\t\t\t5. (desenvolvimento)\n\n\n\n\n\n\t0 para voltar, Mover para que territorio? ");
                   aux=getch(); t=atoi(&aux);   
                   if (t<0  || t>8 || (t==8  && p==1 )) {
                   printf("\nA escolha dos territorio so vai ate 8 terrenos (use o 0 para voltar)"); Sleep(2500); }
                   } while (t<0  || t>8 || (t==8  && p==1 ) || (t>=5  && p==3 )); break;
                   default: return; break;
            }      
            switch (t)
            {      
                   default:
                   do {
                   system("cls");
                   printf("\n\n\n\n\n\n\t\t\t1.  %s\n\t\t\t2.  %s\n\t\t\t3.  %s\n\t\t\t4.  %s\n\n\n\n\n\n\t0 para voltar, atacar que adversario? ",nomes[p-1][t-1][0].c_str(),nomes[p-1][t-1][1].c_str(),nomes[p-1][t-1][2].c_str(),nomes[p-1][t-1][3].c_str());
                   aux=getch(); e=atoi(&aux);          
                   if (e<0 || e>4) {
                   printf("\nSo existem 4 adversarios por territorio (use o 0 para voltar)"); Sleep(2500); }
                   } while (e<0 || e>4); break;
                   case 0: goto looppais; break;
            }
            if (e==0)
            goto loopterra;
            else  
            batalha(p,t,e); 
     return;
}

void principal() 
{
bool sair=false;
char op;
    do {   
    system("cls");       
    printf("\n\n\n\n\n\n\t\t\t1. Recadastrar\n\t\t\t2. Testar batalha\n\t\t\t3. Escolha para mim\n\t\t\t4. Sair\n\n\n\n\n\n\tQual opcao deseja iniciar? ");
    op = getch();
        switch (op)
        {
        case (char)49:
           cadastra(); 
        break;
        case (char)50:
           escolha(); 
        break;           
        case (char)51:
           system("cls");  
           printf("\n EM CONSTRUCAO\n\n");
           system("pause");
        break;  
        case (char)52:
        case (char)27:
             sair=true;
        break;
        default:
        printf("\n opcao invalida");
        Sleep(500);
        }
    } while (sair==false);
}

int main()
{             
      printf("\n\n\n\n\n\n\n\n\n\n\t\t\tBem vindo ao gladiatus Helper!");
      Sleep(1500);
      cadastra();
      principal();
return 0;
}
