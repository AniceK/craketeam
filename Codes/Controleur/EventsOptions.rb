# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Events'
require './Vue/Fenetres/FenetreOptions'

class EventsOptions < Events
  
  public_class_method :new
  
  def initialize(jeu, position)
    
    @fenetre = FenetreOptions.new()
    
    super(jeu, position)
    
    @fenetre.afficher()
    @fenetre.affichageDepart()
    
    if @jeu.profilConnecte?() then
      
      @fenetre.affichageProfil()
      
    elsif !@jeu.profilConnecte?() then
      
      @fenetre.affichageSimple()
      
    else
      
      puts "[EventsOptions]Erreur: Test si profil connecté"
      
    end
    
    @fenetre.boutonViderGrilles.signal_connect('clicked'){
      
      puts ("> Vider Grilles")
      
      @jeu.viderGrilles()
    }
    
    @fenetre.boutonViderSauvegardes.signal_connect('clicked'){
      
      puts ("> Vider Sauvegardes")
      
      @jeu.viderParties()
    }
    
    @fenetre.boutonPrecedent.signal_connect('clicked'){
      puts "> Accueil"
      
      mouvement(EventsAccueil.new(@jeu, position() ))
    }
  end
  
end