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
    def Partie.creer(taille, difficulte)

		new(taille, difficulte)

    end

    def initialize(taille)

		@grille = Grille.creer(taille)
		@creation = now
        @aide = Aide.creer(difficulte)

    end    #marqueur de fin d initialize

	# Méthode lançant la partie
	def lancer()

	end

	# Méthode permettant de renvoyer la Liste des grilles deja existante
	def chargerGrillesExistantes(taille, profil, toutes)
        
        FileUtils.cd('Grilles')
        tab = Array.new(YAML::load(File.open('grilles.yml')))

        if toutes then

            return tab
        else

            return tab.find_all{ |x|
                x.createur() == profil.nom()
            }
        end

        FileUtils.cd('..')

	end

    #Methode pour charger une grille passe en parametre
    def chargerGrille(grille)

        @grille = grille
    end


    #methode pour actualiser l'aide
    def chercherAide()

        @aide.chercherAide(@grille.colonne, @grille.ligne)
    end
    
    #methode pour sauvegarder la grille vierge
    def sauvegarder()

      @grille.raz()
    end

#=================================================
    #ici commencent les méthodes de retransmission
#=================================================
    
# Méthode pour créer une grille aléatoirement
    def genererAleatoirementGrille()

        @grille.genererAleatoire()
    end

   
# Méthode de test de fin de partie
	def termine?()

	  return @grille.termine?()

	end

#methode de noircissage d'une case(X, Y)
    def noircir(x, y)

        @grille.noircir(x, y)
    end

#methode de marquage d'une case (X, Y)
    def marquer(x, y)

        @grille.marquer(x, y)
    end

#methode de verification d'un cou joué
  def verifierCoup(coordX, coordY)
    
        @grille.verifierCoup(coordX, coordY)
  end
  
end
