#25/02/2014
#Projet Picross équipe CrakeTeam
#
#Ce fichier contient la classe Aide

#Encoding: UTF-8

class Aide
  
  @difficulte
  @tabCondCol
  @tabCondLig
  @tabMessage
  
   attr_reader :difficulte, :tabCondCol, :tabCondLig
  
	# Constructeur de la classe Aide
    def Aide.creer(uneDifficulte)

		  new(uneDifficulte)

    end

    def initialize(uneDifficulte)

		  @difficulte = uneDifficulte
      @tabCondCol = Array.new()
      @tabCondLig = Array.new()
      @tabMessage = Array.new()

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
        @tabMessage.push("Difficulté de niveau 1\nLa total\n")
        
      when 2
        @tabMessage.push("Difficulté de niveau 2\nIndication des lignes à potentiel\nVérification des lignes")
        
      when 3
        @tabMessage.push("Difficulté de niveau 3\nVérification des lignes")
        
    end
    
    if difficulte == 1 || difficulte == 2 then
    
      #====      Colonne     ====#
    
      pos = 1

      @tabMessage.push("\nCondition des colonnes\n")
      for tabTabCol in tabCondCol
        totalCol = 0
      
        for valCol in tabTabCol 
          totalCol += valCol
        end
      
        #puts "Total de la colonne #{pos} : #{totalCol}"
      
        if totalCol == tabTaille then
          if difficulte == 1
            @tabMessage.push("Colonne #{pos} : pleine")
          else
            @tabMessage.push("Colonne #{pos}")
          end
        
        elsif totalCol == 0
          if difficulte == 1
             @tabMessage.push("Colonne #{pos} : vide")
          else
             @tabMessage.push("Colonne #{pos}")
          end
        
        elsif tabTabCol.count > tabTaille/2 && tabTaille%2 == 1
          if difficulte == 1
            @tabMessage.push("Colonne #{pos} : une case sur deux en partant du bord")
          else
            @tabMessage.push("Colonne #{pos}")
          end
        
        elsif tabTabCol.count == 1 && totalCol > tabTaille/2 
          if tabTaille%2 == 1
            if difficulte == 1
              @tabMessage.push("Colonne #{pos} : #{tabTaille-(tabTaille-totalCol)*2} case#{ (tabTaille-(tabTaille-totalCol)*2)>1 ? "s":""} à colorier au centre")
            else
               @tabMessage.push("Colonne #{pos}")
            end
          else
            if difficulte == 1
              @tabMessage.push("Colonne #{pos} : #{tabTaille-(tabTaille-totalCol)*2} cases à colorier au centre")
            else
              @tabMessage.push("Colonne #{pos}")
            end
          end
            
        else
          if difficulte == 1
              @tabMessage.push("Colonne #{pos}: aucune aide disponible")
          end
        end
      
        pos += 1
      end
    
      #====      Ligne     ====#
    
    
      pos = 1
    
      @tabMessage.push("\nCondition des lignes\n")
      for tabTabLig in tabCondLig
        totalLig = 0
      
        for valLig in tabTabLig 
          totalLig += valLig
        end
      
        #puts "Total de la ligne #{pos} : #{totalLig}"
      
        if totalLig == tabTaille then
          if difficulte == 1
            @tabMessage.push("Ligne #{pos} : pleine")
        
          else
            @tabMessage.push("Ligne #{pos}")
          end
        
        elsif totalLig == 0 
          @tabMessage.push("Ligne #{pos} : vide")
        
        elsif tabTabLig.count > tabTaille/2 && tabTaille%2 == 1
          if difficulte == 1
            @tabMessage.push("Ligne #{pos} : une case sur deux est noir en partant du bord")
          
          else
            @tabMessage.push("Ligne #{pos}")
          end
        
        elsif tabTabLig.count == 1 && totalLig > tabTaille/2
          if tabTaille%2 == 1
            if difficulte == 1
              @tabMessage.push("Ligne #{pos} : #{tabTaille-(tabTaille-totalCol)*2} case#{(tabTaille-(tabTaille-totalCol)*2)>1 ? "s":""} a colorier au centre")
            else
              @tabMessage.push("Ligne #{pos}")
            end
        
          else
            if difficulte == 1
             @tabMessage.push("Ligne #{pos} : #{tabTaille-(tabTaille-totalCol)*2} cases a colorier au centre")
            else
              @tabMessage.push("Ligne #{pos}")
            end
          end
          
        else
          if difficulte == 1
            @tabMessage.push("Ligne #{pos} : aucune aide disponible")
          end
        end
      
        pos += 1
      end
    end
    
    @tabMessage.push("\nVérification des lignes et des colonnes")
    
    #puts "\nVérification des lignes\n"
    posLig = 0
    for x in tabLig
      tmp = true
      if x.valide() == false then #Change to false pour les tests
        tmp = false
      end
  
      @tabMessage.push("Ligne #{posLig+=1} #{tmp ? "bonne":"erronnée"}")
  
    end
    
    #puts "\nVérification des colonnes\n"
    posCol = 0
    for y in tabCol
      tmp = true
      if y.valide() == false then
        tmp = false
      end
      
      @tabMessage.push("Colonne #{posCol+=1} #{tmp ? "bonne":"erronnée"}")
      
    end
  
    return @tabMessage
  
  end
  
end #marqueur de fin de classe
