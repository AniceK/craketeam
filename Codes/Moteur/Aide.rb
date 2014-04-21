#25/02/2014
#Projet Picross équipe CrakeTeam
#
#Ce fichier contient la classe Aide

load "Rangee.rb"

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
    
    taille = tabCol.size()
    tabCol.each{ |x|
      tabCondCol.push(x.conditions)
    }
    
    tabCol.each{ |x|
      tabCondLig.push(x.conditions)
    }

    puts "Condition des colonnes"
    tabCondCol.each{ |y|
      puts y
      puts "\n"
    }
    
    puts "Condition des lignes"
    tabCondLig.each{ |y|
      puts y
      puts "\n"
    }
    
  end
end #marqueur de fin de classe