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
    
    pos = 1

    puts "\nCondition des colonnes\n"
    for tabTabCol in tabCondCol
      totalCol = 0
      
      for valCol in tabTabCol 
        totalCol += valCol
      end
      
      #puts "Total de la colonne #{pos} : #{totalCol}"
      
      if totalCol == tabTaille then
        puts "Colonne #{pos} : pleine\n"
      
      elsif totalCol == 0
        puts "Colonne #{pos} : vide\n"
        
      elsif tabTabCol.count > tabTaille/2 && tabTaille%2 == 1
        puts "Colonne #{pos} : une case sur deux en partant du bord\n"
        
      elsif tabTabCol.count == 1 && totalCol > tabTaille/2
        printf("Colonne %i : %i case%s a colorier au centre\n", pos, totalCol%tabTaille/2, (totalCol%tabTaille/2)>1 ? "s":"");
         
      else
        puts "Colonne #{pos}: aucune aide disponible"
      end
      
      pos += 1
    end
    
    pos = 1
    
    puts "\n\nCondition des lignes\n"
    for tabTabLig in tabCondLig
      totalLig = 0
      
      for valLig in tabTabLig 
        totalLig += valLig
      end
      
      #puts "Total de la ligne #{pos} : #{totalLig}"
      
      if totalLig == tabTaille then
        puts "Ligne #{pos} : pleine"
        
      elsif totalLig == 0 
        puts "Ligne #{pos} : vide"
        
      elsif tabTabLig.count > tabTaille/2 && tabTaille%2 == 1
        puts "Ligne #{pos} : une case sur deux est noir en partant du bord"
        
      elsif tabTabLig.count == 1 && totalLig > tabTaille/2
        printf("Ligne %i : %i case%s a colorier au centre\n", pos, totalLig%tabTaille/2, (totalLig%tabTaille/2)>1 ? "s":"");
      
      else
        puts "Ligne #{pos} : aucune aide disponible"
      
      end
      
      pos += 1
    end
    
  end
end #marqueur de fin de classe
