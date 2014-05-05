# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require './Controleur/Events.rb'
require './Controleur/EventsChoixGrille.rb'
require './Vue/Fenetres/FenetreChoixTaille.rb'

class EventsChoixTaille < Events
  
  public_class_method :new
  
  def initialize(jeu)
    
    super(jeu)
    
    @fenetre = FenetreChoixTaille.new()
    @fenetre.afficher()
    
    
    @fenetre.bouton5x5.signal_connect('clicked'){
      puts "> Choix grille 5x5"
      
      mouvement(EventsChoixGrille.new(jeu))
    }
    
    @fenetre.bouton10x10.signal_connect('clicked'){
      puts "> Choix grille 10x10"
      
      mouvement(EventsChoixGrille.new(jeu))
    }
    
    @fenetre.bouton15x15.signal_connect('clicked'){
      puts "> Choix grille 15x15"
      
      mouvement(EventsChoixGrille.new(jeu))
    }
    
    @fenetre.bouton20x20.signal_connect('clicked'){
      puts "> Choix grille 20x20"
      
      mouvement(EventsChoixGrille.new(jeu))
    }
    
    @fenetre.bouton25x25.signal_connect('clicked'){
      puts "> Choix grille 25x25"
      
      mouvement(EventsChoixGrille.new(jeu))
    }
    
    @fenetre.boutonPrecedent.signal_connect('clicked'){
      puts "> Accueil"
      
      mouvement(EventsAccueil.new(jeu))
    }
  end
  
end