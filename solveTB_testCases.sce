x = 7  // leeg vakje (geel) 
g = 3  // gras (lichtgroen)
b = 13 // boom (donkergroen)
t = 6 // tent (paars)


// 10 testcases
      
A1 = [x x x x b; 
      x b b x x; 
      x x x x b; 
      x x x x x; 
      x x x b x]
K1 = [1 0 2 0 2]
R1 = [0 2 1 1 1]    
B1 = [g g g g b; 
      t b b g t; 
      g g t g b; 
      g g g g t; 
      g g t b g]


A2 = [x x b x x; 
      b x x b x; 
      x x x x x; 
      b x x x x; 
      x x x x b]
K2 = [2 1 0 0 2] 
R2 = [1 1 1 1 1]   
B2 = [g t b g g; 
      b g g b t; 
      t g g g g; 
      b g g g t; 
      t g g g b]


A3 = [x x x b x; 
      x x x x x; 
      x b x x x; 
      x b b b x; 
      x x x x x]
K3 = [1 1 1 0 2]
R3 = [1 1 0 2 1]    
B3 = [g g g b t; 
      g t g g g; 
      g b g g g; 
      t b b b t; 
      g g t g g]
      
      
A4 = [b x x x b x b x; 
      x x x x x x x b; 
      x x b x x x b x; 
      x x x x x x x x; 
      x b x x x x x x;
      x x b x x x x x;
      x x b x x x x b;
      x x x b x b x x]
K4 = [0 3 1 2 1 1 2 2]
R4 = [4 0 1 2 0 2 0 3]    
B4 = [b t g t b t b t; 
      g g g g g g g b; 
      g g b t g g b g; 
      g t g g g g t g; 
      g b g g g g g g;
      g t b g g g g t;
      g g b g g g g b;
      g g t b t b t g]
      
      
A5 = [x b x b x x x x; 
      x x x x x x b x; 
      x x x x x x x x; 
      b x x x x x x b; 
      b x x x x b b x;
      x x x x b x x x;
      x x x x x x x x;
      x x b b x b x x]
K5 = [2 0 2 0 2 2 2 2]
R5 = [3 0 2 1 1 2 1 2]    
B5 = [g b t b t g t g; 
      g g g g g g b g; 
      t g g g g g g t; 
      b g g g g t g b; 
      b g g g g b b t;
      t g g g b t g g;
      g g t g g g g g;
      g g b b t b t g]


A6 = [x b x x x x x x; 
      b x x b b x x x; 
      b x x x x x x x; 
      x x x x b x x x; 
      x x x b x x b x;
      x x x x x x b x;
      b x x b x b x x;
      x x x x x x x x]
K6 = [3 0 2 2 1 3 0 1]
R6 = [3 0 1 2 2 2 0 2]    
B6 = [t b t g t g g g; 
      b g g b b g g g; 
      b g g t g g g g; 
      t g g g b t g g; 
      g g t b g g b t;
      t g g g g t b g;
      b g g b g b g g;
      g g g t g t g g]


A7 = [x x x b x; 
      x b b x x; 
      x x x x x; 
      x b x x b; 
      x x x x x]
K7 = [2 0 1 0 2]
R7 = [1 1 1 1 1]    
B7 = [g g g b t; 
      t b b g g; 
      g g t g g; 
      t b g g b; 
      g g g g t]
 
    
A8 = [b x x x x x b x; 
      b x x x x x x x; 
      x x x b x b x x; 
      x b x x x b x x; 
      x x x x x x x x;
      x x x x x x x b;
      x x x b b x x x;
      b x x x x x b x]
K8 = [2 2 1 1 0 2 1 3]
R8 = [2 0 3 0 3 0 2 2]    
B8 = [b t g g g g b t; 
      b g g g g g g g; 
      t g t b g b t g; 
      g b g g g b g g; 
      g t g g g t g t;
      g g g g g g g b;
      t g g b b t g g;
      b g g t g g b t]
         
  
A9 = [x x x x x b x x; 
      x x b x b x b x; 
      x x b b x x x x; 
      x x x x x b x x; 
      x x x x x x x x;
      x b x x x x x x;
      x x b x x x b x;
      x x b x b x x x]
K9 = [1 2 1 1 2 2 2 1]
R9 = [2 1 2 1 1 1 2 2]    
B9 = [g g g g t b t g; 
      g t b g b g b g; 
      g g b b t g t g; 
      g g t g g b g g; 
      g g g g g t g g;
      t b g g g g g g;
      g g b t g g b t;
      g t b g b t g g]
        
      
A10 = [x b x x x x x x; 
      x b x x b x x x; 
      x x x x b x b x; 
      x x x x x x b x; 
      x x b x x b b x;
      x b x x x x x x;
      x x b x x x x x;
      x x x x x x x b]
K10 = [2 0 3 1 1 2 2 1]
R10 = [2 2 1 1 1 3 0 2]    
B10 = [g b t g t g g g; 
      t b g g b g t g; 
      g g g t b g b g; 
      g g g g g t b g; 
      g g b g g b b t;
      t b t g g t g g;
      g g b g g g g g;
      g g t g g g t b]
      
            
           

// Onderstaande functie testSolveTB laat toe om je code te testen aan de hand van bovenstaande 10 testcases.
// Deze functie veronderstelt dat je een functie solveTentjeBoompje(A,R,K) geimplementeerd hebt
// die een matrix teruggeeft met de (zo ver mogelijk) opgeloste puzzel.

// De uitvoer van onderstaande functie testSolveTB toont hoeveel puzzels van de 10 je wel en niet hebt kunnen
// oplossen. Verder worden ook nog 3 andere parameters getoond:
// * het percentage correct ingevulde vakjes (dwz waar je code terecht gras of een tent heeft geplaatst),
// * het percentage foutief ingevulde vakjes (dwz waar je code onterecht gras of een tent heeft geplaatst)
//   Als dit percentage niet nul is, wijst dit erop dat er fouten in je code zit, 
// * het percentage lege vakjes, dwz het aantal vakjes die je code niet heeft kunnen invullen.

// Je kan je code dus eenvoudig testen door deze volledig te compileren en nadien de functie 
// testSolveTB() aan te roepen.


function testSolveTB()
    
    sA1 = solveTentjeBoompje(A1,R1,K1)
    sA2 = solveTentjeBoompje(A2,R2,K2)
    sA3 = solveTentjeBoompje(A3,R3,K3)
    sA4 = solveTentjeBoompje(A4,R4,K4)
    sA5 = solveTentjeBoompje(A5,R5,K5)
    sA6 = solveTentjeBoompje(A6,R6,K6)
    sA7 = solveTentjeBoompje(A7,R7,K7)
    sA8 = solveTentjeBoompje(A8,R8,K8)
    sA9 = solveTentjeBoompje(A9,R9,K9)
    sA10 = solveTentjeBoompje(A10,R10,K10)

    nSolved = 0; nNotSolved = 0;
    if isequal(sA1,B1) then nSolved = nSolved+1; else nNotSolved = nNotSolved+1; end
    if isequal(sA2,B2) then nSolved = nSolved+1; else nNotSolved = nNotSolved+1; end
    if isequal(sA3,B3) then nSolved = nSolved+1; else nNotSolved = nNotSolved+1; end
    if isequal(sA4,B4) then nSolved = nSolved+1; else nNotSolved = nNotSolved+1; end
    if isequal(sA5,B5) then nSolved = nSolved+1; else nNotSolved = nNotSolved+1; end
    if isequal(sA6,B6) then nSolved = nSolved+1; else nNotSolved = nNotSolved+1; end
    if isequal(sA7,B7) then nSolved = nSolved+1; else nNotSolved = nNotSolved+1; end
    if isequal(sA8,B8) then nSolved = nSolved+1; else nNotSolved = nNotSolved+1; end
    if isequal(sA9,B9) then nSolved = nSolved+1; else nNotSolved = nNotSolved+1; end
    if isequal(sA10,B10) then nSolved = nSolved+1; else nNotSolved = nNotSolved+1; end
    disp("Aantal correct opgeloste puzzels = ");disp(nSolved);
    disp("Aantal onvolledig of verkeerd opgeloste puzzels = ");disp(nNotSolved); 
      
    
   [Pjuist, Pfout] = percentageCorrIngevuld(list(sA1, sA2, sA3, sA4, sA5, sA6, sA7, sA8, sA9, sA10), list(B1, B2, B3, B4, B5, B6, B7, B8, B9, B10));

    Pjuist = round(Pjuist*1000)/10;
    Pfout = round(Pfout*1000)/10
    disp("Percentage correct ingevulde vakjes = "); disp(Pjuist);
    disp("Percentage foutief ingevulde vukjes = "); disp(Pfout); 
    disp("Percentage lege vakjes = "); disp(100-Pjuist-Pfout); 
endfunction



// Hulpfuncties voor bovenstaande functie testSolveTB


function [Pjuist,Pfout] = aantalCorrIngevuld(M, sM)
    [nr, nc] = size(M)
    Pjuist = 0
    Pfout = 0
    for(i=1:nr)
        for(j=1:nc)
            if(M(i,j)==b | M(i,j) == g | M(i,j) == t) then
                if(M(i,j) == sM(i,j)) then
                    Pjuist = Pjuist + 1
                else
                    Pfout = Pfout + 1
                end
            end
        end
    end    
endfunction


function [Pjuist,Pfout] = percentageCorrIngevuld(V,sV)
    totaalVakken = 0;
    Pjuist = 0;
    Pfout = 0;
    for(i=1:length(V))
        [nr,nc] = size(V(i));
        totaalVakken = totaalVakken + nr*nc;
        [Pj, Pf] = aantalCorrIngevuld(V(i),sV(i));
        Pjuist = Pjuist + Pj;
        Pfout = Pfout + Pf; 
    end
    Pjuist = Pjuist / totaalVakken;
    Pfout = Pfout / totaalVakken;
endfunction











