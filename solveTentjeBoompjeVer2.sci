


x = 7  // leeg vakje (geel) 
g = 3  // gras (lichtgroen)
b = 13 // boom (donkergroen)
t = 6 // tent (paars)

function [M,A,T] = solveTentjeBoompje(B,R,K)
    T = zeros(B) 
    A = geefBoompjes(B)
    M = berekenMogelijkheden(B,R,K)
    M = mogelijkhedenVolgensVec(T,M,R,K)    
    [M,T] = tentjesVolgensVector(T,M,R,K)
    M = geenMogelijkheidRondTent(T,M,R,K)
    [M,T] = eenKansRondBoom(T,A,M,R,K)
    
    M = mogelijkhedenVolgensVec(T,M,R,K)    
    [M,T] = tentjesVolgensVector(T,M,R,K)
    M = geenMogelijkheidRondTent(T,M,R,K)
    [M,T] = eenKansRondBoom(T,A,M,R,K)

     Matplot(B)
  Rom  = R($:-1:1)
   xlabel(string(K))
   ylabel(string(Rom)) 
   return B
endfunction

function G = berekenMogelijkheden(B,R,K)
    //Functie plaatsGrasWaarGeenBoom herschreven 
    // zonder forlus voor beter efficiëntie
    
    // de matrixelementen omzetten naar getallen
    B(find(B==x))=0
    B(find(B==b))=1
    
    // de grootte van de te gebruiken matricen bepalen
    S = size(B)
    nrKol = S(2)
    nrRij = S(1)
    
    // lege matricen aanmaken
    C = zeros(B)
    D = zeros(B)
    E = zeros(B)
    F = zeros(B)
    
    // matrix naar boven verplaatsen
    C(1:nrRij-1,:) = B(2:nrRij,:)
    // matrix naar onder verplaatsen
    D(2:nrRij,:) = B(1:nrRij-1,:)
    // matrix naar rechts verplaatsen
    E(:,1:nrKol-1) = B(:,2:nrKol)
    // matrix naar links verplaatsen
    F(:,2:nrKol) = B(:,1:nrKol-1)
    
    // matricen optellen
    G = C + D + E + F
    
    // De bomen van de mogelijkheden aftrekken
    G = G - B*10
    
    // de matrix G is een matrix met de mogelijkheden
    G(find(G<0)) = 0
    G(find(G>0)) = 1    

return G
endfunction

function M = mogelijkhedenVolgensVec(T,M,R,K)
    // waar er 0 staat in de vector of het aantal tentjes gelijk 
    // is aan de vector is er geen mogelijkheid
    // we willen weten welke er nul zijn (rij0)
    rij0 = R - (sum(T,2))' 
    kolom0 = K - sum(T,1)
    
    M(find(rij0==0),:)=0
    M(:,find(kolom0==0))=0    
return M
endfunction

function H = geefBoompjes(B)
    //een matrix met de boompjes teruggeven
    H = B
    H(find(H==x)) = 0
    H(find(H==b)) = 1
    
return H   
endfunction

function [M,T] = tentjesVolgensVector(T,M,R,K)
    // tentjes zetten waar vector gelijk is aan mogelijkheden + tentjes
    // rijen checken
        //krijgt rij met False en true terug
    rijTent = (sum(M,2))' + (sum(T,2))' == R
        //in de rij waar true staat zet hij in t-matrix ook tentjes (1)
    T(rijTent,:) = T(rijTent,:) + M(rijTent,:)
      
    //kolommen checken
        //idem rij maar bij kolom
    kolomTent = sum(M,1) + sum(T,1) == K
    T(:,kolomTent) = T(:,kolomTent) + M(:,kolomTent)
    
    //mogelijkheden wegdoen
    M(find(T == 1)) = 0
    
return
endfunction

function M = geenMogelijkheidRondTent (T,M,R,K)
    // geen mogelijkheid rond tent
    A = find(T==1)
  
    // kijken naar plaatsje deronder en als 
    // het tentje op de laatste plaats staat is 
    // het volgende volgende kolom dus mogelijkheid verwijderen
    // van vektor A  
    A1 = A + 1
    A1 = A1(find(modulo(A1,length(R))<>1)) 
    
    // kijken naar plaatsje erboven 
    A2 = A - 1
    A2 = A2(find(modulo(A2,length(R))<>0)) 
    
    // kijken naar plaatse rechts
    // alles wat een hogere index heeft dan er eigenlijk
    // kan zijn, (rechts van het veld),
    // verwijderen als mogelijkheid van vektor A
    A3 = A + length(R)
    A3 = A3(find(A3 <= length(R) * length(K))) 
    
    A4 = A + length(R) - 1
    //modulo voor als hij een kolom verder springt
    A4 = A4(find(A4 <= length(R) * length(K)&modulo(A4,length(R))<>0)) 
    
    A5 = A + length(R) + 1
    A5 = A5(find(A5 <= length(R) * length(K)&modulo(A5,length(R))<>1)) 
    
    // kijken naar plaatsen links
    // alles wat een lagere index heeft dan er eigenlijk
    // kan zijn, (links van het veld),
    // verwijderen als mogelijkheid van vektor A
    A6 = A - length(R)
    A6 = A6(find(A6 > 0))
    
    A7 = A - length(R) - 1
    A7 = A7(find(A7 > 0&modulo(A7,length(R))<>0)) 
    
    A8 = A - length(R) + 1
    A8 = A8(find(A8 > 0&modulo(A8,length(R))<>1)) 
    
    Atotaal = unique([A1,A2,A3,A4,A5,A6,A7,A8])
    
    M(Atotaal) = 0
return M   
endfunction

function [M,T] = eenKansRondBoom (T,A,M,R,K)
    // nieuwe lege matrix aanmaken
    M1 = zeros(M)
    // eentje omhoog, als het exact 1 is -> tentje beneden
    M1(1:length(R)-1,:) = M1(1:length(R)-1,:) + M(2:length(R),:)
    // eentje omlaag, als het exact 10 is -> tentje omhoog
    M1(2:length(R),:) = M1(2:length(R),:) + 10*M(1:length(R)-1,:)
    // eentje links, als het exact 100 is -> tentje rechts
    M1(:,1:length(K)-1) = M1(:,1:length(K)-1) + 100*M(:,2:length(K))
    // eentje rechts, als het exact 1000 is -> tentje links
    M1(:,2:length(K)) = M1(:,2:length(K)) + 1000*M(:,1:length(K)-1)
    
    // BP = boomplaats
    BP = find(A==1)
    // KRB = kans rond boom
    KRB = M1(BP)
    // als er geen getal is mag het geen +1 doen -> if
    // als het 1 is tentje beneden
    if (sum(KRB==1) >= 1) then 
        T(BP(find(KRB==1))+1) = 1 
    end
    // als het 10 is tentje omhoog
    if (sum(KRB==10) >= 1) then 
        T(BP(find(KRB==10))-1) = 1
    end
    // als het 100 is tentje rechts
    if (sum(KRB==100) >= 1) then 
        T(BP(find(KRB==100))+length(R)) = 1
    end
    // als het 1000 is tentje links
    if (sum(KRB==1000) >= 1) then 
        T(BP(find(KRB==1000))-length(R)) = 1
    end
    
    //mogelijkheden wegdoen
    M(find(T == 1)) = 0
    
return
endfunction

// BACKTRACKING

function C = isOpgelost(T,M,R,K)
    // kijken of het juist is opgelost
    // tentjes aftrekken van de vector om 
    // te kijken of er genoeg tentjes staan
    rij0 = R - sum(T,1) 
    kolom0 = K - (sum(T,2))'
    // de hele som van de rijvector moet 
    // nul zijn als we er de tenten van aftrekken
    if(sum(rij0) == 0 & sum(kolom0) == 0)
        return %T
    else
        return %F
    end
endfunction

function [M,A,T] = losOp(T,M,A,R,K)
    if isOpgelost(T,M,R,K) then
        return %T
    end
    
    T1 = T
    M = mogelijkhedenVolgensVec(T,M,R,K)    
    [M,T] = tentjesVolgensVector(T,M,R,K)
    M = geenMogelijkheidRondTent(T,M,R,K)
    [M,T] = eenKansRondBoom(T,A,M,R,K)
    
    if sum(T <> T1) <> 0
       return %T
    else
       return %F
    end
     //verandert?
    
endfunction


// eigen voorbeeldje


A20 = [x b x x x; 
      x x x x b; 
      x x b x x; 
      x x x x b; 
      x x b x x]
K20 = [1 1 0 1 2] 
R20 = [2 0 2 0 1]   
B20 = [t b g g t; 
      g g g g b; 
      g t b g t; 
      g g g g b; 
      g g b t g]
      
// voorbeeld 1
// Werkt
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

// voorbeeld 2
// Werkt
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

// voorbeeld 3
// Werkt
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
// voorbeeld 4
// Werkt
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
 // start counter
        tic       
//solveTentjeBoompje(A9,R9,K9)
testSolveTB
 // stop timer
  toc
