x = 7  // leeg vakje (geel) 
g = 3  // gras (lichtgroen)
b = 13 // boom (donkergroen)
t = 6 // tent (paars)

function B = solveTentjeBoompje(B,R,K)
        
//  for i = 1 : length(R)
//        for j = 1 : length(K)
//            while B(i,j) == x
               B = plaatsGrasOpVector0(B,R,K)
               B = plaatsGrasWaarGeenBoom(B,R,K)
               B = plaatsTentjesVolgensVector(B,R,K)
               B = checkLeegRondBoom(B,R,K) 
               B = plaatsGrasRondTentjes(B,R,K)
//            end 
//        end
//    end
   Matplot(B) 
   return B
   
endfunction

function B = plaatsGrasOpVector0(B,R,K)
    
    // Werkwijze
    // ------
    // Vul eerst alle rijen en kolommen in waar een 0 bij staat.
    // Voeg gras toe aan vakjes die niet aan een boom grenzen.
    // Indien de rij (of kolom) evenveel lege vakjes heeft als aantal benodigd, vul je deze in met t        entjes.
    
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
    return
endfunction
    
function B = plaatsGrasWaarGeenBoom(B,R,K)
    // Kijk of er in de buurt een boom staat
    for i = 1 : length(R)
        for j = 1 : length(K)
            // Controleer of dat links,rechts,onder en boven geen boom staat
            if (B(i ,j)<> b) & (B(max(i-1,1),j)<> b) & (B(min(i+1,length(R)),j)<> b) & (B(i,max(j-1,1)))<>b & (B(i,min(j+1,length(K)))<> b &  B(i,j) == x) then 
                B(i,j) = g
            end
        end
    end
    return
endfunction

function B = plaatsTentjesVolgensVector(B,R,K)
    
     // kijken naar vector kolom hoeveel vakjes er tentjes moeten zijn
 
     [rB,kB] = size(B) 
     AantalLegeVakjes = [ ]

     for(i=1:kB)
         aantalLegeVakjes(i) = 0
         for(j=1:rB)
             if B(j,i) == x then
                 aantalLegeVakjes(i) = aantalLegeVakjes(i) + 1
             end
             if B(i,j) == t then
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
     return
endfunction

function B = checkLeegRondBoom(B,R,K)

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
     return
endfunction

function B = plaatsGrasRondTentjes(B,R,K)

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
     return
endfunction
//
//function B = plaatsTentje2op3(B,R,K)
//    
//       //Plaats tentje waar er sowieso tentje moet in een geval van 2 op 3.
//  aantalLegeVakjes = [ ]
//     for(i=1:rB)
//         aantalLegeVakjes(i) = 0
//         for(j=1:kB)
//             if B(i,j) == x then
//                 aantalLegeVakjes(i) = aantalLegeVakjes(i) + 1
//             end
//         end
//        end
//        
//         if aantalLegeVakjes(i) == 3 then
//                 if B(i,j) ==x then
//                     B(i,j) = t
//                 end
//             end
//         end
//     end
//     return
//endfunction

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
      
// voorbeeld
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
      

solveTentjeBoompje(A20,R20,K20)

