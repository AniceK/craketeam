#13/03/2014
#Projet Picross équipe CrakeTeam
#
#Ce fichier contient la classe Profil, qui est constituée d'un nom et d'un nombre de Grilles
#ici une description de la classe Profil.

require 'fileutils'

class Profil

    @nom
	@nbGrilles

	# Constructeur de la classe Profil
    def Profil.creer(nom)
      @nom = nom
      FileUtils.cd('..')
      FileUtils.pwd()
      
      FileUtils.mkdir(@nom)
      FileUtils.cd(@nom)
    end    #marqueur de fin de constructeur

    def initialize(nom)
      creer(nom)
    end    #marqueur de fin d initialize

end
