# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Events'
require_relative 'EventsEditeur'
require './Vue/Fenetres/FenetreTailleEditeur'

#===============================================================================#
#                                                                               #
#          La classe EventsTailleEditeur créé une fenêtre de préparation.       #
#    Elle permet au joueur de choisir une taille de grille pour son édition.    #
#                                                                               #
#===============================================================================#

class EventsTailleEditeur < Events
  
  public_class_method :new
  
  def initialize(jeu, position)
    
    @fenetre = FenetreTailleEditeur.new()
    
    super(jeu, position)
    
    @fenetre.afficher()
    
    @fenetre.boutonPrecedent.signal_connect('clicked'){
      
      puts "> Accueil"
      
      mouvement(EventsAccueil.new(@jeu, position() ))
    }
    
    @fenetre.boutonSuivant.signal_connect('clicked'){
      
      tailleGrille = @fenetre.choixTaille()
      
      puts "> Suivant"
      
      puts "Taille de la grille = " + tailleGrille.to_s
      
      @jeu.creerEditeur(tailleGrille)
      
      mouvement(EventsEditeur.new(@jeu, position() ))
    }
  end
  
end




















