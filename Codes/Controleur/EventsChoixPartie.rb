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
require './Vue/Fenetres/FenetreChoixPartie'

class EventsChoixPartie < Events
  
  public_class_method :new
  
  def initialize(jeu)
    
    super(jeu)
    
    @fenetre = FenetreChoixPartie.new()
    @fenetre.afficher()
    
    
    @fenetre.boutonChoisirSauvegarde.signal_connect('clicked'){
      puts "> Choisir Sauvegarde"
      
      mouvement(EventsChoisirSauvegarde.new(jeu))
    }
    
    @fenetre.boutonNouvellePartie.signal_connect('clicked'){
      puts "> Nouvelle Partie"
      
      mouvement(EventsPreparation.new(jeu))
    }
    
    @fenetre.boutonPrecedent.signal_connect('clicked'){
      puts "> Accueil"
      
      mouvement(EventsAccueil.new(jeu))
    }
  end
  
end