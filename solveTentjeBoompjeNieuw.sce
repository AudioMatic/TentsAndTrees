x = 7  // leeg vakje (geel) 
g = 3  // gras (lichtgroen)
b = 13 // boom (donkergroen)
t = 6 // tent (paars)
function X = solveTentjeBoompje(B,R,K)
    T = zeros(B) 
    A = geefBoompjes(B)
    M = berekenMogelijkheden(B,R,K)
    M = mogelijkhedenVolgensVec(T,M,R,K)    
    [M,T] = losOp(T,M,A,R,K)
    X = zeros(B)
    X(find(T==1))=t
    X(find(A==1))=b
    X(find(X==0))=g
   
    Matplot(X)
  Rom  = R($:-1:1)
   xlabel(string(K))
   ylabel(string(Rom)) 
return X
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
 
    if sum(T) > 0 then
            // geen mogelijkheid rond tent
            A = find(T==1)
          
            // kijken naar plaatsje deronder en als 
            // het tentje op de laatste plaats staat is 
            // het volgende volgende kolom dus mogelijkheid verwijderen
            // van vektor A  
            A1 = A + 1
            A1 = A1(find(A1 <= length(R) * length(K)&modulo(A1,length(R))<>1)) 
            
            // kijken naar plaatsje erboven 
            A2 = A - 1
            A2 = A2(find(A2 > 0&modulo(A2,length(R))<>0)) 
            
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
    end
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
    rij0 = R - (sum(T,2))' 
    kolom0 = K - sum(T,1)
    
    // de hele som van de rijvector moet 
    // nul zijn als we er de tenten van aftrekken
    if (sum(rij0) == 0 & sum(kolom0) == 0) then
        C = %T
    else
        C = %F
    end
endfunction
function C =isVeilig(T,M,A,R,K)
   
    
    
    C = %T
    // kijken in rij dat er niet meer tentjes zijn
    // dan er in de vektor zijn toegestaan
    if sum(sum(T,2)' > R) <> 0 then
        //C staat op true dus is het 1, als het fout is
        //vermenigvuldigen met False(0) waardoor we 
        //0 terug krijgen en het dus false is
        C = C * %F
    end
    
    // idem vorige maar met kolom
    if sum(sum(T,1) > K) <> 0 then
        C = C * %F
    end
    
    //geen twee tentjes naast elkaar
    
    // nieuwe lege matrix aanmaken
    T1 = zeros(T)
    // eentje omhoog
    T1(1:length(R)-1,:) = T1(1:length(R)-1,:) + T(2:length(R),:)
    // eentje omlaag
    T1(2:length(R),:) = T1(2:length(R),:) + T(1:length(R)-1,:)
    // eentje links
    T1(:,1:length(K)-1) = T1(:,1:length(K)-1) + T(:,2:length(K))
    // eentje rechts
    T1(:,2:length(K)) = T1(:,2:length(K)) + T(:,1:length(K)-1)
    //linkerbovenhoek
    T1(1:length(R)-1,1:length(K)-1) = T1(1:length(R)-1,1:length(K)-1) + T(2:length(R),2:length(K))
    //rechterbovenhoek
    T1(1:length(R)-1,2:length(K)) = T1(1:length(R)-1,2:length(K)) + T(2:length(R),1:length(K)-1)
    //linkeronderhoek
    T1(2:length(R),1:length(K)-1) = T1(2:length(R),1:length(K)-1) + T(1:length(R)-1,2:length(K))
    //rechteronderhoek
    T1(2:length(R),2:length(K)) = T1(2:length(R),2:length(K)) + T(1:length(R)-1:length(K)-1)
    
    // TP = tentplaats
    TP = find(T==1)
    // TRT= tentRondTent
    TRT = T1(TP)
    
    // als er iets groter dan 1 is staat er ergens een tentje naast elkaar
    if (sum(TRT==1) > 1) then 
        C = %F
    end
//    
//     //KOMT IN DE CODE MAAR KLOPT NIET?!!
//    //geen 2 tentjes naast elkaar
//    
//    for i = 1 : length(R)
//        for j = 1 : length(K)
//            // Controleer of dat links,rechts,onder en boven, hoeken geen tent staat
//            if (T(i ,j)==1) & ((T(max(i-1,1),j)==1) | (T(min(i+1,length(R)),j)==1) | (T(i,max(j-1,1))==1)| (T(i,min(j+1,length(K)))==1) | (T(min(i+1,length(R)),max(j-1,1))==1)| (T(min(i+1,length(R)),min(j+1,length(K)))==1)| (T(max(i-1,1),max(j-1,1))==1)| (T(max(i-1,1),min(j+1,length(K)))==1)) then 
//                C = %F
//            end
//        end
//    end
    
    return C
endfunction
function [M,T] = losOp(T,M,A,R,K)
    if isOpgelost(T,M,R,K) then
//        global T3
//        T3 = T
//        global M3
//        M3 = M
        // functie om vroegtijdig te stoppen??
        return M,T
    end
    T1 = T
    M1 = M
    M1 = mogelijkhedenVolgensVec(T1,M1,R,K)         
    M1 =geenMogelijkheidRondTent(T1,M1,R,K)
    [M1,T1] = tentjesVolgensVector(T1,M1,R,K)
    M1 = geenMogelijkheidRondTent(T1,M1,R,K)
//    [M1,T1] = eenKansRondBoom(T1,A,M1,R,K)
//    M1 = geenMogelijkheidRondTent(T1,M1,R,K)
    if (sum(M<>M1)<> 0 & isVeilig(T1,M1,A,R,K))
       [M,T] = losOp(T1,M1,A,R,K)
    end
    // zoek volgende locatie
    M2 = M
    T2 = T
    M2(find(M==1,1)) = 0
    if (sum(M<>M2)<> 0 & isVeilig(T2,M2,A,R,K))
       [M,T] = losOp(T2,M2,A,R,K)
    end
    // zoek volgende locatie
    M2 = M
    T2 = T
    T2(find(M==1,1)) = 1
    M2(find(M==1,1)) = 0
    if (sum(M<>M2)<> 0 & isVeilig(T2,M2,A,R,K))
       [M,T] = losOp(T2,M2,A,R,K)
    end
    return M,T
endfunction
