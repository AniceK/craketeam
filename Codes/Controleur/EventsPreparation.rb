# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Events'
require_relative 'EventsChoixGrille'
require './Vue/Fenetres/FenetrePreparation'

class EventsPreparation < Events
  
  public_class_method :new
  
  def initialize(jeu)
    
    super(jeu)
    
    @fenetre = FenetrePreparation.new()
    @fenetre.afficher()
    
    @fenetre.boutonPrecedent.signal_connect('clicked'){
      
      puts "> Accueil"
      
      # Si profil connecté
      #mouvement(EventsChoixPartie.new(jeu))
      
      # Si pas de profil connecté
      mouvement(EventsAccueil.new(jeu))
    }
    
    @fenetre.boutonSuivant.signal_connect('clicked'){
      
      tailleGrille = @fenetre.choixTaille()
      difficulte = @fenetre.choixDifficulte()
      
      puts "> Suivant"
      
      puts "Taille de la grille = " + @tailleGrille.to_s
      puts "Niveau de difficulté de l'aide: " + @difficulte.to_s
      
      @jeu.creerPartie(tailleGrille, difficulte)
      
      mouvement(EventsChoixGrille.new(jeu))
    }
  end
  
end




















