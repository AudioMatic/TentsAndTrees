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
               if(A(i,j) == x)
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
               if(A(j,i) == x)
                   // verander dit door gras
                   B(j,i) = g
               end
           end
        end
    end
    
    // Kijk of er in de buurt een boom staat
    for i = 1 : length(R)
        for j = 1 : length(K)
            // Controleer of dat links,rechts,onder en boven geen boom staat
            if (A(i ,j)<> b) & (A(max(i-1,1),j)<> b) & (A(min(i+1,length(R)),j)<> b) & (A(i,max(j-1,1)))<>b & (A(i,min(j+1,length(K)))<> b) then 
                B(i,j) = g
            end
        end
    end
    
   
 // TENTJES ZETTEN 
 
 [rB,kB] = size(B) 
    
     // eerste rij     
    for(j=2:kB-1)
       if B(1,j) == x then
            if B(2,j) <> x & B(1,j-1) <> x & B(1,j+1) <> x & B(2,j) <> t & B(1,j-1) <> t & B(1,j+1) <> t then
                B(1,j) = t
            end   
       end
    end
    
    // laatste rij
    for(j=2:kB-1)
       if B(rB,j) == x then
            if B(rB-1,j) <> x & B(rB,j-1) <> x & B(rB,j+1) <> x & B(rB-1,j) <> t & B(rB,j-1) <> t & B(rB,j+1) <> t then
                B(rB,j) = t
            end   
       end
    end 
    
    // eerste kolom
    for(i=2:rB-1)
       if B(i,1) == x then
           if B(i-1,1) <> x & B(i+1,1) <> x & B(i,2) <> x & B(i-1,1) <> t & B(i+1,1) <> t & B(i,2) <> t then
               B(i,1) = t
           end   
       end
    end
    
    // laatste kolom
    for(i=2:rB-1)
       if B(i,rB) == x then
           if B(i-1,rB) <> x & B(i+1,rB) <> x & B(i,rB-1) <> x & B(i-1,rB) <> t & B(i+1,rB) <> t & B(i,rB-1) <> t then
               B(i,rB) = t
           end   
       end
    end   
  
     // linkerbovenhoek
       if B(1,1) == x then
            if B(2,1) <> x & B(1,2) <> x & B(2,1) <> t & B(1,2) <> t then
                B(1,1) = t
            end   
       end
         
    // rechterbovenhoek
           if B(1,kB) == x then
            if B(2,kB) <> x & B(1,kB-1) <> x & B(2,kB) <> t & B(1,kB-1) <> t then
                B(1,kB) = t
            end   
       end
    
    // linkeronderhoek
           if B(rB,1) == x then
            if B(rB-1,1) <> x & B(rB,2) <> x & B(rB-1,1) <> t & B(rB,2) <> t then
                B(rB,1) = t
            end   
       end
    
    // rechteronderhoek
           if B(rB,kB) == x then
            if B(rB-1,kB) <> x & B(rB,kB-1) <> x & B(rB-1,kB) <> t & B(rB,kB-1) <> t then
                B(rB,kB) = t
            end   
       end
      
     // kijken naar vector kolom hoeveel vakjes er tentjes moeten zijn
     for(i=1:kB)
         aantalLegeVakjes = 0
         for(j=1:rB)
             if B(j,i) == x then
                 aantalLegeVakjes = aantalLegeVakjes + 1
             end
             if B(j,i) == t then
                 aantalLegeVakjes = aantalLegeVakjes - 1
             end
         end
         if aantalLegeVakjes == K(j) then
             for(j=1:rB)
                 if B(j,i) ==x then
                     B(j,i) = t
                 end
             end
         end
     end
     
     // kijken naar vector rij hoeveel vakjes er tentjes moeten zijn
     for(i=1:rB)
         aantalLegeVakjes = 0
         for(j=1:kB)
             if B(i,j) == x then
                 aantalLegeVakjes = aantalLegeVakjes + 1
             end
              if B(i,j) == t then
                 aantalLegeVakjes = aantalLegeVakjes - 1
             end
         end
         if aantalLegeVakjes == K(i) then
             for(j=1:kB)
                 if B(i,j) ==x then
                     B(i,j) = t
                 end
             end
         end
     end
       
    Matplot(B)
endfunction


// voorbeeld

A1 = [x b b x x; 
      x x x x b; 
      x x x x x; 
      x x x x b; 
      x b x x x]
K1 = [2 0 0 1 2] 
R1 = [2 0 1 0 2]   
// Is dit niet omgekeerd?
B1 = [t b b t g; 
      g g g g b; 
      g g g g t; 
      g g g g b; 
      t b g g t]

// voorbeeld 2

A2 = [x b x x x; 
      x x x x b; 
      x x b x x; 
      x x x x b; 
      x x b x x]
K2 = [1 1 0 1 2] 
R2 = [2 0 2 0 1]   
// Is dit niet omgekeerd?
B2 = [t b g g t; 
      g g g g b; 
      g t b g t; 
      g g g g b; 
      g g b t g]
      
solveTentjeBoompje(A1,R1,K1)
