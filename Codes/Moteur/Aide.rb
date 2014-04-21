#25/02/2014
#Projet Picross équipe CrakeTeam
#
#Ce fichier contient la classe Aide

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
    
    cpt = 0

    puts "\nCondition des colonnes\n"
    tabCondCol.each{ |x|
      tot = 0
      
      x.each{ |y| tot += y}
      
      puts "Total de la colonne #{cpt} : #{tot}"
      
      if tot == tabTaille then
        puts "La colonne #{cpt} est pleine"
      
      elsif tot == 0
        puts "La colonne #{cpt} est vide"
      
      end
      
      cpt += 1
    }
    
    cpt = 0
    
    puts "\nCondition des lignes\n"
    tabCondLig.each{ |x|
      tot = 0
      
      x.each{ |y| tot += y}
      
      puts "Total de la ligne #{cpt} : #{tot}"
      
      if tot == tabTaille then
        puts "La ligne #{cpt} est pleine"
        
      elsif tot == 0 
        puts "La ligne #{cpt} est vide"
      end
      
      cpt += 1
    }
    
  end
end #marqueur de fin de classe