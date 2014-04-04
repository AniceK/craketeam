#13/03/2014
#Projet Picross équipe CrakeTeam
#
#Ce fichier contient la classe Jeu, qui est constituée d'un Profil et d'une Partie
#ici une description de la classe Jeu.

class Jeu

  @profil
  @partie
  @os       #Variable representant l'os sous lequel le jeu est lancé. 2 signifie Windows, 1 signifie Unix(Mac OS et Linux). Cette variable sert a determiner les commandes a utiliser

	# Constructeur de la classe Jeu
    def Jeu.creer()
    end    #marqueur de fin de constructeur

    def initialize()


        system_name = `uname`
        if(system_name[1,1] == /[Ww]/) then

            os = 2
        else
            os = 1
        end

    end    #marqueur de fin d initialize


	# Méthode permettant de charger le Profil du joueur
	def chargerProfil(unNom)

	end

	def ajouterProfil(unNom)
	  @profil.creer(unNom)
	end


	# Méthode permettant de récupérer une partie
	def chargerPartie()

	end

	def ajouterPartie()
	end

end
