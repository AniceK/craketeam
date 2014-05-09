# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Events'
require './Vue/Fenetres/FenetreProfil'

class EventsProfil < Events
  
  public_class_method :new
  
  def initialize(jeu)
    
    super(jeu)
    
    @fenetre = FenetreProfil.new()
    @fenetre.afficher()
    
    @fenetre.boutonCreerProfil.signal_connect('clicked'){
      @jeu.creerProfil(@fenetre.entreeNomProfil.text)
      
      puts "> Accueil (pseudo: " + @jeu.nomProfil() + ")"
      
      mouvement(EventsAccueil.new(jeu))
    }
    
    @fenetre.boutonChargerProfil.signal_connect('clicked'){
      puts "> Accueil (pseudo: " + @fenetre.entreeNomProfil.text + ")"
      
      if @jeu.chargerProfil(@fenetre.entreeNomProfil.text) then
        mouvement(EventsAccueil.new(jeu))
      else
        puts "> Profil inconnu"
        # Popup erreur
      end
    }
    
    @fenetre.boutonPrecedent.signal_connect('clicked'){
      puts "> Accueil"
      
      mouvement(EventsAccueil.new(jeu))
    }
  end
  
end