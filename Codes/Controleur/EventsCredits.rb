# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require './Controleur/Events.rb'
require './Vue/Fenetres/FenetreCredits.rb'

class EventsCredits < Events
  
  public_class_method :new
  
  def initialize(jeu)
    
    super(jeu)
    
    @fenetre = FenetreCredits.new()
    @fenetre.afficher()
    
    @fenetre.boutonPrecedent.signal_connect('clicked'){
      puts "> Accueil"
      
      mouvement(EventsAccueil.new(jeu))
    }
  end
  
end