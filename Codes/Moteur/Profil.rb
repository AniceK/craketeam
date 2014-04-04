#13/03/2014
#Projet Picross équipe CrakeTeam
#
#Ce fichier contient la classe Profil, qui est constituée d'un nom et d'un nombre de Grilles
#ici une description de la classe Profil.

class Profil

    @nom
	@nbGrilles

    attr_reader :nom, :nbGrilles

	# Constructeur de la classe Profil
    def Profil.creer(nom)

        new(nom)
    end    #marqueur de fin de constructeur

    def initialize()

        @nom = nom
    end    #marqueur de fin d initialize

    def ajouterUneGrille()

        @nbGrilles ++
    end    #marqueur de fin de methode d'instance

end
