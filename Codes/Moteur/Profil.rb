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
      # Création d'un dossier avec @nom dans picross/Grilles

      @nom = nom
      @nbGrilles = 0
      FileUtils.cd('Profil')
      FileUtils.cd(@nom)
      File.open('profil.yml', "w"){ |out| out.puts self.to_yaml}
      FileUtils.cd('../..')
      #ajouter serialisation automatique a la creation

    end    #marqueur de fin d initialize

    def ajouterUneGrille()
        @nbGrilles = @nbGrilles + 1
    end    #marqueur de fin de methode d'instance


end
