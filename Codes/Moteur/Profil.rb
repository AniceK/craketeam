#13/03/2014
#Projet Picross équipe CrakeTeam
#
#Ce fichier contient la classe Profil, qui est constituée d'un nom et d'un nombre de Grilles
#ici une description de la classe Profil.

require 'fileutils'

class Profil

    @nom
	@nbGrilles

    attr_reader :nom, :nbGrilles

	# Constructeur de la classe Profil
    def Profil.creer(nom)

        new(nom)
    end    #marqueur de fin de constructeur

    def initialize(nom)

      # Vérifier Arbo sinon création dossier avec @nom dans picross/profil/
      # création dossier Parties et info.txt dans picross/profil/@nom/
      # Création d'un dossier avec @nom dans picross/Grilles/

      @nom = nom
      FileUtils.cd('..')
      FileUtils.pwd()
           
      FileUtils.mkdir(@nom)
      FileUtils.cd(@nom)
    end    #marqueur de fin d initialize

    def ajouterUneGrille()
        @nbGrilles ++
    end    #marqueur de fin de methode d'instance

    def charger(unNom)
      FileUtils.cd('..')
      FileUtils.pwd()
      FileUtils.cd(unNom)
    end
end
