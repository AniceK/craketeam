# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Events'
require_relative 'EventsPreparation'
require_relative 'EventsJeu'
require './Vue/Fenetres/FenetreChoixGrille'

class EventsChoixGrille < Events
  
  public_class_method :new
  
  def initialize(jeu, tailleGrille)
    
    super(jeu)
    
    @fenetre = FenetreChoixGrille.new()
    @fenetre.afficher()
    
    
    @fenetre.boutonGrilleCreee.signal_connect('clicked'){
      puts "> Grille créée"
      
      #mouvement(EventsChoixGrilleCreee.new(jeu))
    }
    
    @fenetre.boutonGrilleAleatoire.signal_connect('clicked'){
      puts "> Grille aleatoire"
      
      mouvement(EventsJeu.new(jeu, tailleGrille))
    }
    
    @fenetre.boutonPrecedent.signal_connect('clicked'){
      puts "> Accueil"
      
      mouvement(EventsPreparation.new(jeu))
    }
  end
  
end