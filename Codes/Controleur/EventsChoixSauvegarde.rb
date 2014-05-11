# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Events'
require './Vue/Fenetres/FenetreChoixSauvegarde'

class EventsChoixSauvegarde < Events
  
  public_class_method :new
  
  def initialize(jeu)
    
    super(jeu)
    
    @fenetre = FenetreChoixSauvegarde.new()
    @fenetre.afficher()
    
    #@fenetre.bouton.signal_connect('clicked'){
    #  puts "> "
    #  
    #  mouvement(Events.new(jeu))
    #}
    
    @fenetre.boutonPrecedent.signal_connect('clicked'){
      
      puts "> Choix Partie"
      mouvement(EventsChoixPartie.new(@jeu))
    }
    
    @fenetre.boutonSuivant.signal_connect('clicked'){
      
      #sauvegarde = @fenetre.choixSauvegarde()
      
      #puts "> Suivant (Sauvegarde: " + sauvegarde + ")"
      
      #@jeu.chargerPartie(sauvegarde)
      
      #mouvement(EventsJeu.new(@jeu))
    }
  end
  
end