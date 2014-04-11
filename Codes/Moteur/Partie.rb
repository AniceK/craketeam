#13/03/2014
#Projet Picross équipe CrakeTeam
#
#Ce fichier contient la classe Partie, qui est constituée d'une Grille et de diverses paramètres
#ici une description de la classe Partie.

class Partie

    @grille
    @creation   #heure et date de la creation de la partie
    @type        #entier signalant de quelle type de partie il s'agit. Pour l'instant, on laisse ce paramètre inutilisé


    attr_reader :grille, :time

	# Constructeur de la classe Partie
    def Partie.creer(typeCreation)

		new(typeCreation)

    end

    def initialize()

		@grille = Grille.ajouter(typeCreation)
		@creation = now

    end    #marqueur de fin d initialize

	# Méthode de test de fin de partie
	def termine?()

	  return @grille.termine?()

	end

	# Méthode lançant la partie
	def lancer()

	end

	# Méthode permettant de renvoyer la Liste des grilles deja existante
	def chargerGrillesExistantes(taille, profil, toutes)

        FileUtils.cd('Grilles')
        
        if toutes then
        end
	end

    # Méthode pour créer une grille aléatoirement

end
