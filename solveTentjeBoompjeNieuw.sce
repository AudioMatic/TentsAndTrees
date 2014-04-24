x = 7  // leeg vakje (geel) 
g = 3  // gras (lichtgroen)
b = 13 // boom (donkergroen)
t = 6 // tent (paars)

B = [x,x,x,x,x,x,x,x;
     x,x,x,x,x,b,x,x;
     b,x,x,x,b,x,b,b;
     b,x,x,x,x,x,x,x;
     x,x,x,x,b,x,x,b;
     x,x,x,x,b,x,b,x;
     b,x,b,x,x,x,x,x;
     x,x,x,x,x,x,x,x;]
R = [1,1,3,1,2,0,2,2]
K = [2,1,1,2,1,2,1,2]

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

    return
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
