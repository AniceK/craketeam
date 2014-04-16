#Encoding: UTF-8
#class GrillePicross

class GrillePicross
  
  @Largeur #Largeur de la grille (x)
  @longueur #Hauteur de la grille (y)
  @GrillePicross #Grille de Picross
  @TabLignes #Matrice pour les lignes
  @TabColonnes #Matrice pour les colonnes
  
  attr :Largeur, true 
  attr :Longueur, true 
  attr :GrillePicross, true 
  attr :TabLignes, true 
  attr :TabColonnes, true 
    
  private_class_method :new
  
  
  
  def GrillePicross.Creer(x,y)
    new(x,y)
  end
  
  
  
  def initialize(x,y)
    @Largeur = x
    @Longueur = y
    @GrillePicross = Array.new(@Longueur){Array.new(@Largeur)}
    @TabLignes = Array.new(@Longueur){Array.new(@Largeur)}
    @TabColonnes = Array.new(@Longueur){Array.new(@Largeur)}
    
    #Genere une GrillePicross avec des 1 et des 0 aléatoirement ( Essai )
    0.upto(@Longueur -1){|o|
      0.upto(@Largeur -1){|p|
        r1 = rand(0..1)
        @GrillePicross[o][p] = r1
      }
    }

    #Initialize toutes les cases à 0 (indicatif!!)  
    0.upto(@Longueur -1){|o|
      0.upto(@Largeur -1){|p|
        @TabLignes[o][p] = 0
      }
    }
    
    0.upto(@Longueur -1){|o|
      0.upto(@Largeur -1){|p|
        @TabColonnes[o][p] = 0
      }
    }
    
    #Genere la matrice TabLignes d'apres la GrillePicross
    0.upto(@Longueur -1){|o|
      tmp = 0
      
        0.upto(@Largeur -2){|p|
          itt = @Largeur -1
          
          if (@GrillePicross[o][p] ==1)
            tmp+=1
          elsif (@GrillePicross[o][p] == 0 && tmp != 0)
            if (@TabLignes[o][@Largeur-1] == 0)
              @TabLignes[o][@Largeur-1] = tmp
              tmp = 0
            else
              
              while(@TabLignes[o][itt] != 0)
                itt -=1
              end
              (itt + 1).upto(@Largeur -1){|b|
                @TabLignes[o][b-1] = @TabLignes[o][b]
              }

              @TabLignes[o][@Largeur-1] = tmp
              tmp = 0

            end
          end
     
        }
        

        f = @Largeur-1
        itt = @Largeur -1
        if (@GrillePicross[o][f] == 1)
          tmp+=1
          
          while(@TabLignes[o][itt] != 0)
            itt -=1
          end
          (itt + 1).upto(@Largeur -1){|b|
            @TabLignes[o][b-1] = @TabLignes[o][b]
          }
          
          @TabLignes[o][@Largeur-1] = tmp

        elsif(@GrillePicross[o][f] == 0 && tmp != 0)
          if (@TabLignes[o][@Largeur-1] == 0)
            @TabLignes[o][@Largeur-1] = tmp
          else
            
            while(@TabLignes[o][itt] != 0)
              itt -=1
            end
            (itt + 1).upto(@Largeur -1){|b|
              @TabLignes[o][b-1] = @TabLignes[o][b]
            }
            @TabLignes[o][@Largeur-1] = tmp
          end
        end
    }
    
    #Genere la matrice TabColonnes
    0.upto(@Largeur -1){|o|
      tmp = 0
      
        0.upto(@Longueur -2){|p|
          itt = @Longueur -1
          
          if (@GrillePicross[p][o] ==1)
            tmp+=1
          elsif (@GrillePicross[p][o] == 0 && tmp != 0)
            if (@TabColonnes[@Longueur-1][o] == 0)
              @TabColonnes[@Longueur-1][o] = tmp
              tmp = 0
            else
              
              while(@TabColonnes[itt][o] != 0)
                itt -=1
              end
              (itt + 1).upto(@Longueur -1){|b|
                @TabColonnes[b-1][o] = @TabColonnes[b][o]
              }

              @TabColonnes[@Longueur-1][o] = tmp
              tmp = 0

            end
          end
     
        }
        

        f = @Longueur-1
        itt = @Longueur -1
        if (@GrillePicross[f][o] == 1)
          tmp+=1
          
          while(@TabColonnes[itt][o] != 0)
            itt -=1
          end
          (itt + 1).upto(@Longueur -1){|b|
            @TabColonnes[b-1][o] = @TabColonnes[b][o]
          }
          
          @TabColonnes[@Longueur-1][o] = tmp

        elsif(@GrillePicross[f][o] == 0 && tmp != 0)
          if (@TabColonnes[@Longueur-1][o] == 0)
            @TabColonnes[@Longueur-1][o] = tmp
          else
            
            while(@TabColonnes[itt][o] != 0)
              itt -=1
            end
            (itt + 1).upto(@Longueur -1){|b|
              @TabColonnes[b-1][o] = @TabColonnes[b][o]
            }
            @TabColonnes[@Longueur-1][o] = tmp
          end
        end
    }
    
  end



  def VoirGrille
    
    #Affiche la matrice TabColonnes
    print "\n"
    print "Grille de Picross \n\n\t"
    0.upto(@Longueur -1) do |o|
      0.upto(@Largeur-1){|p|
         print @TabColonnes[o][p]
        
      }
       print "\n\t"
     end
    
    print "\n"
    0.upto(@Longueur -1){|o|
      0.upto(@Largeur -1){|p|
         print @TabLignes[o][p]
      }
      print "\t"
      0.upto(@Largeur -1){|p|
         print @GrillePicross[o][p]
      }
      print "\n"
    }
    
  end
  
  def getTabLignes
    return @TabLignes
  end
  
  def getTabColonnes
    return @TabColonnes
  end
  
  #Définition des aides possible à partir de la matrice TabLignes
  def AidePossibleLigne?()
    
    print "\nSolution possible\n"
    
    0.upto(@Longueur-1){|o|
      somme = 0
      0.upto(@Largeur-1){|p|
        somme += @TabLignes[o][p] 
          if(somme == @Largeur)
            val = o + 1
            print "Ligne " + val.to_s() + ": vous pouvez colorier toutes les cases !\n"
          elsif(somme == @Largeur - 1)
            val = o + 1
            print "Ligne " + val.to_s() + " A voir\n"
          elsif(@TabLignes[o][p] > @Largeur / 2)
            val = o + 1
            print "Ligne " + val.to_s() + ": la case du milieu est forcement coloriée\n"
          end
      }
       if(somme == 0) 
         val = o + 1
         print "Ligne " + val.to_s() + " rien à faire !\n"
       end
    }
  end
  
  def AidePossibleColonne?()
    
    0.upto(@Largeur-1){|o|
      somme = 0
      0.upto(@Longueur-1){|p| 
       somme += @TabColonnes[p][o] 
      }
      
      case 
        when somme == @Longueur
         print "Colonne " + (o+1).to_s() + ": vous pouvez colorier toutes les cases !\n"
         
       when somme == 0
         print "Colonne" + (o+1).to_s() + " rien à faire."
         
       when somme == @Longueur - 1
         print "Colonne " + (o+1).to_s() + ": une case à chaque extrémité peut être coloriée\n"
        
       when somme == @Longueur
         print "Colonne " + (o+1).to_s() + ""
      end
       
    }
  end
  
end
