#Encoding: UTF-8
#class GrillePicross

class GrillePicross
  
  @Taille #Taille de la grille 
  @GrillePicross #Grille de Picross
  @TabLignes #Matrice pour les lignes
  @TabColonnes #Matrice pour les colonnes
  
  attr :Taille, true
  attr :GrillePicross, true 
  attr :TabLignes, true 
  attr :TabColonnes, true 
    
  private_class_method :new
  
  
  
  def GrillePicross.Creer(x)
    new(x)
  end
  
  
  
  def initialize(x)
    @Taille = x
    @GrillePicross = Array.new(@Taille){Array.new(@Taille)}
    @TabLignes = Array.new(@Taille){Array.new(@Taille)}
    @TabColonnes = Array.new(@Taille){Array.new(@Taille)}
    
    #Genere une GrillePicross avec des 1 et des 0 aléatoirement ( Essai )
    0.upto(@Taille -1){|o|
      0.upto(@Taille -1){|p|
        r1 = rand(0..1)
        @GrillePicross[o][p] = r1
      }
    }

    #Initialize toutes les cases à 0 (indicatif!!)  
    0.upto(@Taille -1){|o|
      0.upto(@Taille -1){|p|
        @TabLignes[o][p] = 0
      }
    }
    
    0.upto(@Taille -1){|o|
      0.upto(@Taille -1){|p|
        @TabColonnes[o][p] = 0
      }
    }
    
    #Genere la matrice TabLignes d'apres la GrillePicross
    0.upto(@Taille -1){|o|
      tmp = 0
      
        0.upto(@Taille -2){|p|
          itt = @Taille -1
          
          if (@GrillePicross[o][p] ==1)
            tmp+=1
          elsif (@GrillePicross[o][p] == 0 && tmp != 0)
            if (@TabLignes[o][@Taille-1] == 0)
              @TabLignes[o][@Taille-1] = tmp
              tmp = 0
            else
              
              while(@TabLignes[o][itt] != 0)
                itt -=1
              end
              (itt + 1).upto(@Taille -1){|b|
                @TabLignes[o][b-1] = @TabLignes[o][b]
              }

              @TabLignes[o][@Taille-1] = tmp
              tmp = 0

            end
          end
     
        }
        

        f = @Taille-1
        itt = @Taille -1
        if (@GrillePicross[o][f] == 1)
          tmp+=1
          
          while(@TabLignes[o][itt] != 0)
            itt -=1
          end
          (itt + 1).upto(@Taille -1){|b|
            @TabLignes[o][b-1] = @TabLignes[o][b]
          }
          
          @TabLignes[o][@Taille-1] = tmp

        elsif(@GrillePicross[o][f] == 0 && tmp != 0)
          if (@TabLignes[o][@Taille-1] == 0)
            @TabLignes[o][@Taille-1] = tmp
          else
            
            while(@TabLignes[o][itt] != 0)
              itt -=1
            end
            (itt + 1).upto(@Taille -1){|b|
              @TabLignes[o][b-1] = @TabLignes[o][b]
            }
            @TabLignes[o][@Taille-1] = tmp
          end
        end
    }
    
    #Genere la matrice TabColonnes
    0.upto(@Taille -1){|o|
      tmp = 0
      
        0.upto(@Taille -2){|p|
          itt = @Taille -1
          
          if (@GrillePicross[p][o] ==1)
            tmp+=1
          elsif (@GrillePicross[p][o] == 0 && tmp != 0)
            if (@TabColonnes[@Taille-1][o] == 0)
              @TabColonnes[@Taille-1][o] = tmp
              tmp = 0
            else
              
              while(@TabColonnes[itt][o] != 0)
                itt -=1
              end
              (itt + 1).upto(@Taille -1){|b|
                @TabColonnes[b-1][o] = @TabColonnes[b][o]
              }

              @TabColonnes[@Taille-1][o] = tmp
              tmp = 0

            end
          end
     
        }
        

        f = @Taille-1
        itt = @Taille -1
        if (@GrillePicross[f][o] == 1)
          tmp+=1
          
          while(@TabColonnes[itt][o] != 0)
            itt -=1
          end
          (itt + 1).upto(@Taille -1){|b|
            @TabColonnes[b-1][o] = @TabColonnes[b][o]
          }
          
          @TabColonnes[@Taille-1][o] = tmp

        elsif(@GrillePicross[f][o] == 0 && tmp != 0)
          if (@TabColonnes[@Taille-1][o] == 0)
            @TabColonnes[@Taille-1][o] = tmp
          else
            
            while(@TabColonnes[itt][o] != 0)
              itt -=1
            end
            (itt + 1).upto(@Taille -1){|b|
              @TabColonnes[b-1][o] = @TabColonnes[b][o]
            }
            @TabColonnes[@Taille-1][o] = tmp
          end
        end
    }
    
  end



  def VoirGrille
    
    #Affiche la matrice TabColonnes
    print "\n"
    print "Grille de Picross \n\n\t"
    0.upto(@Taille -1) do |o|
      0.upto(@Taille-1){|p|
         print @TabColonnes[o][p]
        
      }
       print "\n\t"
     end
    
    print "\n"
    0.upto(@Taille -1){|o|
      0.upto(@Taille -1){|p|
         print @TabLignes[o][p]
      }
      print "\t"
      0.upto(@Taille -1){|p|
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
    
    print "\nSolution possible sur les lignes\n"
    
    0.upto(@Taille-1){|o|
      somme = 0
      0.upto(@Taille-1){|p|
        somme += @TabLignes[o][p] 
          if(somme == @Taille)
            print "Ligne " + (o+1).to_s() + ": vous pouvez colorier toutes les cases !\n"
          elsif(somme == @Taille - 1)
            print "Ligne " + (o+1).to_s() + " A voir\n"
          elsif(@TabLignes[o][p] > @Taille / 2)
            print "Ligne " + (o+1).to_s() + ": la case du milieu est forcement coloriée\n"
          end
      }
       if(somme == 0) 
         print "Ligne " + (o+1).to_s() + " rien à faire !\n"
       end
    }
  end
  
  def AidePossibleColonne?()
    
    print "\nSolution possible sur les colonnes\n"
    
    0.upto(@Taille-1){|o|
      somme = 0
      0.upto(@Taille-1){|p|
        somme += @TabColonnes[p][o] 
          if(somme == @Taille)
            print "Colonne " + (o+1).to_s() + ": vous pouvez colorier toutes les cases !\n"
          elsif(somme == @Taille - 1)
            print "Colonne " + (o+1).to_s() + " A voir\n"
          elsif(@TabColonnes[p][o] > @Taille / 2)
            print "Colonne " + (o+1).to_s() + ": la case du milieu est forcement coloriée\n"
          end
      }
       if(somme == 0) 
         print "Colonne " + (o+1).to_s() + " rien à faire !\n"
       end
    }
  end
  
end

class LancerAide
  maGrille = GrillePicross.Creer(5)
  maGrille.VoirGrille
  
  
  MatriceLignes = maGrille.getTabLignes
  print "\n"
  maGrille.AidePossibleLigne?()
  maGrille.AidePossibleColonne?()
  
end
