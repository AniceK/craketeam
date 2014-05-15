# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Events'
require_relative 'EventsOptions'
require './Vue/Fenetres/FenetreAfficherScores'


class EventsAfficherScores < Events
  
  public_class_method :new
  
  def initialize(jeu, position, listeScores)
    
    @fenetre = FenetreAfficherScores.new(listeScores)
    
    super(jeu, position)
    
    @fenetre.afficher()
    
    @fenetre.boutonPrecedent.signal_connect('clicked'){
      
      puts "> Choix Grille"
      mouvement(EventsOptions.new(@jeu, position() ))
    }
    
  end
  
end




