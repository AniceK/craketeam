# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require './Controleur/Events.rb'
require './Vue/Fenetres/FenetreProfil.rb'

class EventsProfil < Events
  
  public_class_method :new
  
  def initialize(jeu)
    
    super(jeu)
    
    @fenetre = FenetreProfil.new()
    @fenetre.afficher()
    
    @fenetre.boutonCreerProfil.signal_connect('clicked'){
      @nomProfil = @fenetre.entreeNomProfil.text
      
      puts "> Accueil (pseudo: " + @nomProfil + ")"
      
      mouvement(EventsAccueil.new(jeu))
    }
    
    @fenetre.boutonChargerProfil.signal_connect('clicked'){
       puts "> Accueil (pseudo: " + @fenetre.entreeNomProfil.text + ")"
      
      mouvement(EventsAccueil.new(jeu))
    }
    
    @fenetre.boutonPrecedent.signal_connect('clicked'){
      puts "> Accueil"
      
      mouvement(EventsAccueil.new(jeu))
    }
  end
  
end