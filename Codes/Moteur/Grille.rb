#25/02/2014
#Projet Picross equipe CrakeTeam
#
#Ce fichier contient la classe Grille, qui est constituee de Case
#ici une description de la classe Grille.

class Grille

    @columns
    @rows

    attr :columns, true
    attr :rows, true

	# Constructeur de la classe Grille

    def Grille.ajouter()
    end

    def initialize()
    end

	# Méthode vérifiant la validité du coup joué

    def verifierCoup(coordX, coordY)
      @columns[coordX].verifier()
      @rows[coordY].verifier()
    end

	# Méthode vérifiant si la partie est terminée, en passant en revue la validité de chacune des Rangées

    def termine?()
      res = true
      @columns.each { |X|
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

	# Méthode permettant de noircir une Case à partir de ses coordonnées

	def noircirCase(coordX, coordY)
	    @columns[coordX].noircir(coordY)
	    @rows[coordY].noircir(coordX)
	end

	# Méthode permettant de marquer une Case comme n'étant pas à cocher à partir de ses coordonnées

	def marquerCase(coordX, coordY)
	    @column[coordX].marquer(coordY)
	    @rows[coordY].marquer(coordY)
    end

end
