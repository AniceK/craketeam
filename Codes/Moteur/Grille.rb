#25/02/2014
#Projet Picross equipe CrakeTeam
#
#Ce fichier contient la classe Grille, qui est constituee de Case
#ici une description de la classe Grille.

load "Rangee.rb"

class Grille

    @colonne
    @ligne
    @grille
    @createur
    @taille

    attr_reader :colonne, :ligne, :grille, :createur

	# Constructeur de la classe Grille

    def Grille.ajouter(nom, taille)
    
        new(nom, taille)

    end

    def initialize(nom, taille)

        @taille = taille
        @colonne = Array.new(taille, Rangee.ajouter(taille))
        @ligne = Array.new(taille, Rangee.ajouter(taille))
        @grille = Array.new(taille, Array.new(taille, Case.creer()))
        @createur = nom
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

    @ligne.each { |x|
        x.razCases()
    }
    @colonne.each {
        |x| x.razCases()
    }

    for i in (0..@taille-1)
      for j in (0..@taille-1)
          alea = 0 + Random.rand(100)
          printf("alea : %i; i : %i ; j : %i\n", alea, i, j)
          if (alea > unCoef) then
              
              @colonne[i].noircir(j)
              @ligne[j].noircir(i)
        end
      end
    end


	@colonne.each { |x|
		x.conditionsDeterminer()
		#x.razCases()
	}

	@ligne.each { |x|
		x.conditionsDeterminer()
		#x.razCases()
	}

  end

  #methode d'affichage reservee aux tests, affichage uniquement des colonnes
  def afficher()

      @colonne.each { |x|
          x.afficher()
      }
  end

end
