#25/02/2014
#Projet Picross équipe CrakeTeam
#
#Ce fichier contient la classe Aide

#Encoding: UTF-8

class Aide
  
  @difficulte
  @tabCondCol
  @tabCondLig
  
   attr_reader :difficulte, :tabCondCol, :tabCondLig
  
	# Constructeur de la classe Aide
    def Aide.creer(uneDifficulte)

		  new(uneDifficulte)

    end

    def initialize(uneDifficulte)

		  @difficulte = uneDifficulte
      @tabCondCol = Array.new()
      @tabCondLig = Array.new()

    end    #marqueur de fin d initialize
    
  def chercherAide(tabCol, tabLig)
    
    tabTaille = tabCol.size()
    
    tabCol.each{ |x|
      tabCondCol.push(x.conditions)
    }
    
    tabLig.each{ |x|
      tabCondLig.push(x.conditions)
    }
    
    case difficulte
      
      when 1
        puts "Difficulté de niveau 1\nLa total\n"
        
      when 2
        puts "Difficulté de niveau 2\nIndication des lignes à potentiel\nVérification des lignes"
        
      when 3
        puts "Difficulté de niveau 3\nVérification des lignes"
        
    end
    
    if difficulte == 1 || difficulte == 2 then
    
      #====      Colonne     ====#
    
      pos = 1

      puts "\nCondition des colonnes\n"
      for tabTabCol in tabCondCol
        totalCol = 0
      
        for valCol in tabTabCol 
          totalCol += valCol
        end
      
        #puts "Total de la colonne #{pos} : #{totalCol}"
      
        if totalCol == tabTaille then
          if difficulte == 1
            puts "Colonne #{pos} : pleine\n"
          else
            puts "Colonne #{pos}"
          end
        
        elsif totalCol == 0
          if difficulte == 1
            puts "Colonne #{pos} : vide\n"
          else
            puts "Colonne #{pos}"
          end
        
        elsif tabTabCol.count > tabTaille/2 && tabTaille%2 == 1
          if difficulte == 1
            puts "Colonne #{pos} : une case sur deux en partant du bord\n"
          else
            puts "Colonne #{pos}"
          end
        
        elsif tabTabCol.count == 1 && totalCol > tabTaille/2 
          if tabTaille%2 == 1
            if difficulte == 1
              printf("Colonne %i : %i case%s à colorier au centre\n", pos, tabTaille-(tabTaille-totalCol)*2, (tabTaille-(tabTaille-totalCol)*2)>1 ? "s":"")
            else
              puts "Colonne #{pos}"
            end
          else
            if difficulte == 1
              printf("Colonne %i : %i cases à colorier au centre\n", pos, tabTaille-(tabTaille-totalCol)*2)
            else
              puts "Colonne #{pos}"
            end
          end
            
        else
          if difficulte == 1
            puts "Colonne #{pos}: aucune aide disponible"
          end
        end
      
        pos += 1
      end
    
      #====      Ligne     ====#
    
    
      pos = 1
    
      puts "\n\nCondition des lignes\n"
      for tabTabLig in tabCondLig
        totalLig = 0
      
        for valLig in tabTabLig 
          totalLig += valLig
        end
      
        #puts "Total de la ligne #{pos} : #{totalLig}"
      
        if totalLig == tabTaille then
          if difficulte == 1
            puts "Ligne #{pos} : pleine"
        
          else
            puts "Ligne #{pos}"
          end
        
        elsif totalLig == 0 
          puts "Ligne #{pos} : vide"
        
        elsif tabTabLig.count > tabTaille/2 && tabTaille%2 == 1
          if difficulte == 1
            puts "Ligne #{pos} : une case sur deux est noir en partant du bord"
          
          else
            puts "Ligne #{pos}"
          end
        
        elsif tabTabLig.count == 1 && totalLig > tabTaille/2
          if tabTaille%2 == 1
            if difficulte == 1
              printf("Ligne %i : %i case%s a colorier au centre\n", pos, tabTaille-(tabTaille-totalCol)*2, (tabTaille-(tabTaille-totalCol)*2)>1 ? "s":"")
            else
              puts "Ligne #{pos}"
            end
        
          else
            if difficulte == 1
              printf("Ligne %i : %i cases a colorier au centre\n", pos, tabTaille-(tabTaille-totalCol)*2)
            else
              puts "Ligne #{pos}"
            end
          end
          
        else
          if difficulte == 1
            puts "Ligne #{pos} : aucune aide disponible"
          end
        end
      
        pos += 1
      end
    end
    
    puts "\nVérification des lignes\n"
      
    #Vérification des lignes et des colonnes
    tmp = false
    pos = 0

    for x in tabLig
      if x.valide() == true then
        for y in tabCol
          if y.valide() == false then
            tmp = false
          end
        end
      end
  
      printf("Ligne %i %s.\n", pos+=1, tmp==true ? "bonne":"erronnée") 
  
    end
  end
end #marqueur de fin de classe
