# encoding: utf-8
#! /usr/bin/env ruby
##
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

      @nom = nom
      @nbGrilles = 0
      sauvegarde = @nom + ".yml"
      File.open(sauvegarde, "w"){ |out| out.puts self.to_yaml}
      File.new("parties.yml", "w")

    end    #marqueur de fin d initialize

    def ajouterUneGrille()

        @nbGrilles = @nbGrilles + 1

    end    #marqueur de fin de methode d'instance

# Méthode pour sauvegarder le profil
    def sauvegarder()

        FileUtils.cd('Profil')
        sauvegarde = @nom + ".yml"
        FileUtils.cd(@nom)
        File.open(sauvegarde, "w"){ |out| out.puts self.to_yaml}
        FileUtils.cd('../..')

    end


end
