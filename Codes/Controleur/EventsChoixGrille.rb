# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require './Controleur/Events.rb'
require './Controleur/EventsChoixTaille.rb'
require './Vue/Fenetres/FenetreChoixGrille.rb'

class EventsChoixGrille < Events
  
  public_class_method :new
  
  def initialize(jeu)
    
    super(jeu)
    
    @fenetre = FenetreChoixGrille.new()
    @fenetre.afficher()
    
    
    @fenetre.boutonGrilleCreee.signal_connect('clicked'){
      puts "> Grille créée"
      
      #mouvement(EventsAccueil.new(jeu))
    }
    
    @fenetre.boutonGrilleAleatoire.signal_connect('clicked'){
      puts "> Grille aleatoire"
      
      #mouvement(EventsAccueil.new(jeu))
    }
    
    @fenetre.boutonPrecedent.signal_connect('clicked'){
      puts "> Accueil"
      
      mouvement(EventsChoixTaille.new(jeu))
    }
  end
  
end