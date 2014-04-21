#13/03/2014
#Projet Picross équipe CrakeTeam
#
#Ce fichier contient la classe Partie, qui est constituée d'une Grille et de diverses paramètres
#ici une description de la classe Partie.

load "Grille.rb", "Aide.rb"

class Partie

    @grille
    @creation   #heure et date de la creation de la partie
    @type       #entier signalant de quelle type de partie il s'agit. Pour l'instant, on laisse ce paramètre inutilisé
    @aide       #contient l'IA d'aide


    attr_reader :grille, :type, :aide, :creation

	# Constructeur de la classe Partie
    def Partie.creer(taille)

		new(taille)

    end

    def initialize()

		@grille = Grille.ajouter(taille)
		@creation = now
        @aide = 

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
        
        
	end

    #Methode pour charger une grille passe en parametre
    def chargerGrille(grille)
    end

    # Méthode pour créer une grille aléatoirement

    def genererAleatoirementGrille()

        @grille.genererAleatoire()
    end


    def chercherAide()

        @aide.chercherAide(@grille.colonne, @grille.ligne)
    end

end
