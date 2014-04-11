#25/02/2014
#Projet Picross equipe CrakeTeam
#
#Ce fichier contient la classe Grille, qui est constituee de Case
#ici une description de la classe Grille.

require 'Rangee'

class Grille

    @colonne
    @ligne
    @grille

    attr :colonne, true
    attr :ligne, true
    attr :grille, true

	# Constructeur de la classe Grille

    def Grille.ajouter()



    end

    def initialize()



    end

	# Méthode vérifiant la validité du coup joué

    def verifierCoup(coordX, coordY)

      @colonne[coordX].verifier()
      @ligne[coordY].verifier()

    end

	# Méthode vérifiant si la partie est terminée, en passant en revue la validité de chacune des Rangées

    def termine?()

      res = true
      @colonne.each { |x|
          if x.valide() == false then
              res = false
          end
      }
      @ligne.each { |x|
          if x.valide() == false then
              res = false
          end
      }
      return res

    end

	# Méthode permettant de noircir une Case à partir de ses coordonnées

	def noircirCase(coordX, coordY)

	    @colonne[coordX].noircir(coordY)
	    @ligne[coordY].noircir(coordX)

	end

	# Méthode permettant de marquer une Case comme n'étant pas à cocher à partir de ses coordonnées

	def marquerCase(coordX, coordY)

	    @colonne[coordX].marquer(coordY)
	    @ligne[coordY].marquer(coordY)

    end

	# Méthode permettant la sauvegarde de la Grille dans son état actuel

	def sauvegarderGrille()



	end

	# Méthode permettant de charger une Grille préalablement sauvegarder à partir de son nom

	def chargerGrille(unNom)



	end

  def genererAleatoire(unCoef)

    for i in (0..@ligne.lenght()-1)
      for j in (0..@colonne.lenght()-1)
        if (rand(100)) > unCoef then
          @grille.noircirCase(i, j)
        end
      end
    end

	@olonne.each { |x|
		x.conditionsDeterminer()
		x.razCases()
	}

	@ligne.each { |x|
		x.conditionsDeterminer()
		x.razCases()
	}

  end

end
