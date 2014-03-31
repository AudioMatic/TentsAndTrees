x = 7  // leeg vakje (geel) 
g = 3  // gras (lichtgroen)
b = 13 // boom (donkergroen)
t = 6 // tent (paars)


function B = solveTentjeBoompje(A,R,K)
   
    // Voeg code toe die de gegeven Tentje Boompje puzzel
    // oplost. Implementeer een nieuwe functie voor elke
    // bijkomende strategie die je toepast.
    
    
    B = A
    
    // Werkwijze
    // ------
    // Vul eerst alle rijen en kolommen in waar een 0 bij staat.
    // Voeg gras toe aan vakjes die niet aan een boom grenzen.
    // Indien de rij (of kolom) evenveel lege vakjes heeft als aantal benodigd, vul je deze in met tentjes.
    
    //check of dat in de Rijvector een 0 staat.
    for i = 1 : length(R)
        if R(i) == 0
           // doorloop i-de rij
           for j =  1 : length(K)
               if(B(i,j) == x & B(i,j) == x)
                   // verander dit door gras
                   B(i,j) = g
               end
           end
        end
    end
     //check of dat in de Kolomvector een 0 staat.
    for i = 1 : length(K)
        if K(i) == 0
           // doorloop i-de kolom
           for j =  1 : length(R)
               if(B(j,i) == x &  B(j,i) == x)
                   // verander dit door gras
                   B(j,i) = g
               end
           end
        end
    end
    
    //ok
    
    // Kijk of er in de buurt een boom staat
    for i = 1 : length(R)
        for j = 1 : length(K)
            // Controleer of dat links,rechts,onder en boven geen boom staat
            if (A(i ,j)<> b) & (A(max(i-1,1),j)<> b) & (A(min(i+1,length(R)),j)<> b) & (A(i,max(j-1,1)))<>b & (A(i,min(j+1,length(K)))<> b &  B(i,j) == x) then 
                B(i,j) = g
            end
        end
    end
    //That works ! ;) 
   placeTentjes(A,R,K,B)
 //  Matplot(B)
endfunction

function placeTentjes(A,R,K,B)
 // TENTJES ZETTEN 

//STAP 2
 [rB,kB] = size(B) 
  AantalLegeVakjes = [ ]
    
         // kijken naar vector kolom hoeveel vakjes er tentjes moeten zijn
     for(i=1:kB)
         aantalLegeVakjes(i) = 0
         for(j=1:rB)
             if B(j,i) == x then
                 aantalLegeVakjes(i) = aantalLegeVakjes(i) + 1
             end
            
         end
        end
        
        for(i=1:kB)
         if aantalLegeVakjes(i) == K(i) then
             for(j=1:rB)
                 if B(j,i) ==x then
                     B(j,i) = t
                 end
             end
         end
     end
     
     
     // kijken naar vector rij hoeveel vakjes er tentjes moeten zijn
     
     aantalLegeVakjes = [ ]
     for(i=1:rB)
         aantalLegeVakjes(i) = 0
         for(j=1:kB)
             if B(i,j) == x then
                 aantalLegeVakjes(i) = aantalLegeVakjes(i) + 1
             end
             if B(i,j) == t then
               aantalLegeVakjes(i) = aantalLegeVakjes(i) + 1
             end
         end
        end
        
        
        for(i=1:rB)
         if aantalLegeVakjes(i) == R(i) then
             for(j=1:kB)
                 if B(i,j) ==x then
                     B(i,j) = t
                 end
             end
         end
     end
       
      Matplot(B)
 //plaatsGrasRondTentjes(A,R,K,B)
endfunction

function plaatsGrasRondTentjes(A,R,K,B)

       //STAP 3
     // Plaats gras rond tentjes als er nog lege vakjes zouden zijn.
     for i=1:length(R)
         for j=1:length(K)
             if B(i,j)==t then
                 for k=max(i-1,1):min(i+1,length(R))
                     for l=max(j-1,1):min(j+1,length(K))
                         if B(k,l)==x then B(k,l)=g
                         end
                     end
                 end
             end
         end
     end
     
   // Matplot(B)
    
   checkLeegRondBoom(A,R,K,B)
endfunction
function checkLeegRondBoom(A,R,K,B)

// STAP 4 
// Ga na of er nog lege vakjes zijn rond een boom (en dat er rond die boom nog geen tentjes staan)
// Als er nog maar één leeg vakje is, zet je daar een tentje
    aantalLeeg = 0
    oke = %F
     for i=1:length(R)
         for j=1:length(K)
             if B(i,j)==b then
                 aantalLeeg = 0 // reset aantalLeeg
                 for k=max(i-1,1):min(i+1,length(R))
                     for l=max(j-1,1):min(j+1,length(K))
                         if B(k,l)==x then aantalLeeg = aantalLeeg + 1
                         end
                         if B(k,l)==t then oke=%T
                         end
                     end
                 end
                 if aantalLeeg==1 & oke==%F then
                     for k=max(i-1,1):min(i+1,length(R))
                        for l=max(j-1,1):min(j+1,length(K))
                            if B(k,l)==x then B(k,l)=t
                            end
                        end
                    end
                end
            end
        end
     end
       


//TODO
// STAP 5
// Kijk na of er nog een leeg vakje naast een tentje zou staan.
// Indien ja, vul deze met gras op.


 Matplot(B)
endfunction


// voorbeeld
//Werkt
A1 = [x b b x x; 
      x x x x b; 
      x x x x x; 
      x x x x b; 
      x b x x x]
K1 = [2 0 0 1 2] 
R1 = [2 0 1 0 2]   
B1 = [t b b t g; 
      g g g g b; 
      g g g g t; 
      g g g g b; 
      t b g g t]

// voorbeeld 2
// Werkt niet
A2 = [x b x x x; 
      x x x x b; 
      x x b x x; 
      x x x x b; 
      x x b x x]
K2 = [1 1 0 1 2] 
R2 = [2 0 2 0 1]   
B2 = [t b g g t; 
      g g g g b; 
      g t b g t; 
      g g g g b; 
      g g b t g]
// Voorbeeld 3
// (werkt bijna, tentjes zet hij wel al juist)
A3 = [x x b x x; 
      b x x b x; 
      x x x x x; 
      b x x x x; 
      x x x x b]
K3 = [2 1 0 0 2]
R3 = [1 1 1 1 1]         
B3 = [g t b g g; 
      b g g b t; 
      t g g g g; 
      b g g g t; 
      t g g g b]
  
//K3 = [1 0 2 0 2]
//R3 = [0 2 1 1 1]        
//B3 = [g g g g b; 
//      t b b g t; 
//      g g t g b; 
//      g g g g t; 
//      g g t b g]


// Voorbeeld 4
// (werkt bijna, tentjes zet hij wel al juist)
A4 = [x x x b x; 
      x t x x x; 
      x b x x x; 
      x b b b x; 
      x x x x x]
K4 = [1 1 1 0 2] 
R4 = [1 1 0 2 1]        
B4 = [g g g b t; 
      g t g g g; 
      g b g g g; 
      t b b b t; 
      g g t g g]
// Voorbeeld 5
// (werkt niet)
A5 = [x b x b x; 
      b x x x x; 
      x x x b x; 
      b x x x x; 
      x x x x x]
K5 = [2 0 1 1 1] 
R5 = [2 0 1 1 1]   
B5 = [g b t b t; 
      b g g g g; 
      t g g b g; 
      b g g t g; 
      t g g g g]
// Voorbeeld 6
// (werkt niet)
A6 = [x x x x b; 
      x x b x x; 
      x x b x x; 
      x x x x x; 
      x b x b x]
K6 = [1 1 1 1 1]  
R6 = [1 1 0 1 2]       
B6 = [g g g t b; 
      g t b g g; 
      g g b g g; 
      g g t g g; 
      t b g b t]
// Voorbeeld 7
// (werkt niet)
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
      
solveTentjeBoompje(A7,R7,K7)
