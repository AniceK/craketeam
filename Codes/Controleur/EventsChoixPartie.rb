# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Events'
require_relative 'EventsPreparation'
require_relative 'EventsAccueil'
require_relative 'EventsChoixSauvegarde'
require './Vue/Fenetres/FenetreChoixPartie'

class EventsChoixPartie < Events
  
  public_class_method :new
  
  def initialize(jeu, position)
    
    @fenetre = FenetreChoixPartie.new()
    
    super(jeu, position)
    
    @fenetre.afficher()
    #@fenetre.move(@jeu.positionX(), @jeu.positionY()) # => @jeu.positionX() renvoie position[0] et Y -> position[1]
    
    
    @fenetre.boutonChoisirSauvegarde.signal_connect('clicked'){
      puts "> Choisir Sauvegarde"
      
      mouvement(EventsChoixSauvegarde.new(@jeu, position() ))
    }
    
    @fenetre.boutonNouvellePartie.signal_connect('clicked'){
      puts "> Préparation Partie"
      
      mouvement(EventsPreparation.new(@jeu, position() ))
    }
    
    @fenetre.boutonPrecedent.signal_connect('clicked'){
      puts "> Accueil"
      
      mouvement(EventsAccueil.new(@jeu, position() ))
    }
  end
  
end