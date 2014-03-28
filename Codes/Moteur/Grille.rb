#25/02/2014
#Projet Picross equipe CrakeTeam
#
#Ce fichier contient la classe Grille, qui est constituee de Case
#ici une description de la classe Grille.

class Grille

    @collumns
    @rows
    
    attr :columns, true
    attr :rows, true
  
    def Grille.ajouter()
    end

    def initialize()
    end

    def verifierCoup(coordX, coordY)
      @collumns[coordX].verifier()
      @rows[coordY].verifier()
    end

    def termine?()
      res = true
      @collumns.each { |X|
          if X.valide() == false then
              res = false
          end
      }
      @rows.each { |X|
          if X.valide() == false then
              res = false
          end
      }
      return res
    end

	  def noircirCase(coordX, coordY)
	      @collumns[coordX].noircir(coordY)
	      @rows[coordY].noircir(coordX)
	  end
	  
	  def marquerCase(coordX, coordY)
	      @collumn[coordX].marquer(coordY)
	      @rows[coordY].marquer(coordY)
    end

end
