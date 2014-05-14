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
  
  def initialize(jeu, position)
    
    @fenetre = FenetreProfil.new()
    
    super(jeu, position)
    
    @fenetre.afficher()
    @fenetre.affichageDepart()
    
    @fenetre.boutonCreerProfil.signal_connect('clicked'){
      
      if @jeu.creerProfil(@fenetre.entreeNomProfil.text) then
      
        puts "> Accueil (pseudo: \”" + @jeu.nomProfil() + "\")"
        mouvement(EventsAccueil.new(@jeu, position() ))
      else
        
        @fenetre.affichagePseudoExistant()
        puts "> Pseudo déjà utilisé"
      end
    }
    
    @fenetre.boutonChargerProfil.signal_connect('clicked'){
      puts "> Accueil (pseudo: \"" + @fenetre.entreeNomProfil.text + "\")"
      
      if @jeu.chargerProfil(@fenetre.entreeNomProfil.text) then
        
        mouvement(EventsAccueil.new(@jeu, position() ))
        
      else
        
        @fenetre.affichagePseudoInexistant()
        puts "> Pseudo inconnu"
      end
    }
    
    @fenetre.boutonPrecedent.signal_connect('clicked'){
      puts "> Accueil"
      
      mouvement(EventsAccueil.new(@jeu, position() ))
    }
  end
  
end