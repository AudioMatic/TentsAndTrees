x = 7  // leeg vakje (geel) 
g = 3  // gras (lichtgroen)
b = 13 // boom (donkergroen)
t = 6 // tent (paars


function B = solveTentjeBoompje(A,R,K)
   
    // Voeg code toe die de gegeven Tentje Boompje puzzel
    // oplost. Implementeer een nieuwe functie voor elke
    // bijkomende strategie die je toepast.
    
    
    B = A
    
    // Werkwijze
    // ------
    // Vul eerst alle rijen en kolommen in waar een 0 bij staat.
    // Indien de rij (of kolom) evenveel lege vakjes heeft als aantal benodigd, vul je deze in met tentjes.
    
    //check of dat in de Rijvector een 0 staat.
    for i = 1 : length(R)
        disp('OK1')
        if R(i) == 0 
            disp('OK2')
           // doorloop i-de rij
           for j =  1 : length(K)
               disp('OK3')
               if(A(i,j) == x)
                   disp('OK4')
                   // verander dit door gras
                   B(i,j) = g
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
      
solveTentjeBoompje(A1,R1,K1)
