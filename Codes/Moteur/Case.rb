#25/02/2014
#Projet Picross équipe CrakeTeam
#
#Ce fichier contient la classe Case, brique de base du jeu
#ici une description de la classe Case.

class Case

    @etat       #l'état est un entier qui indique si la case a été noircie, cochée par le joueur ou laissée blanche.

    attr_reader :etat

    def Case.creer()

		new()

    end

    def initialize()

		@etat = 0

    end

# Les deux méthodes suivantes sont là pour changer l'état de la case : on bascule dans l'état correspondant à la méthode
	# sauf si la case était déjà dans cet état, dans cette situation on rebascule à l'état initial.
	#
	# Les états possible sont les suivants :
	#  - Vierge avec la valeur 0
	#  - Noirci avec la valeur 1
	#  - Marqué avec la valeur 2

    def noircir()

      if (@etat != 1)

        @etat = 1

      else

        @etat = 0

      end

    end

	def marquer()

		if (@etat != 2)

			@etat = 2

		else

			@etat =0

		end

	end

# La méthode suivante permet de réinitialiser l'état de la case à 0

	def raz()

		@etat = 0

	end

#Methode d'affichage en terminal pour les tests
    def afficher()
        puts @etat
    end

end
