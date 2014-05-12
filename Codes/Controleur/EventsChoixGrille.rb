# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Events'
require_relative 'EventsJeu'
require_relative 'EventsChoixCreation'
require './Vue/Fenetres/FenetreChoixGrille'


#===============================================================================#
#                                                                               #
#        La classe EventsChoixGrille créé une fenêtre de choix de grille.       #
#   Elle permet au joueur de choisir une grille déjà créée par un utilisateur,  #
#              ou de commencer une toute nouvelle grille aléatoire.             #
#                                                                               #
#===============================================================================#

class EventsChoixGrille < Events
  
  public_class_method :new
  
  def initialize(jeu)
    
    super(jeu)
    
    @fenetre = FenetreChoixGrille.new()
    @fenetre.afficher()
    #@fenetre.move(@jeu.positionX(), @jeu.positionY()) # => @jeu.positionX() renvoie position[0] et Y -> position[1]
    
    
    @fenetre.boutonGrilleCreee.signal_connect('clicked'){
      puts "> Grille créée"
      
      mouvement(EventsChoixCreation.new(jeu))
    }
    
    @fenetre.boutonGrilleAleatoire.signal_connect('clicked'){
      puts "> Grille aleatoire"
      
      jeu.genererAleatoirementGrille()
      mouvement(EventsJeu.new(jeu))
    }
    
    @fenetre.boutonPrecedent.signal_connect('clicked'){
      puts "> Accueil"
      
      mouvement(EventsPreparation.new(jeu))
    }
  end
  
end