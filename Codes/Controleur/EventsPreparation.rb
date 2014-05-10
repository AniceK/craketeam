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

#===============================================================================#
#                                                                               #
#          La classe EventsPreparation créé une fenêtre de préparation.         #
#      Elle permet au joueur de choisir une taille de grille pour sa partie.    #
#           Il choisit également la difficulté de l'aide apportée               #
#                                                                               #
#===============================================================================#

class EventsPreparation < Events
  
  public_class_method :new
  
  def initialize(jeu)
    
    super(jeu)
    
    @fenetre = FenetrePreparation.new()
    @fenetre.afficher()
    
    @fenetre.boutonPrecedent.signal_connect('clicked'){
      
      puts "> Accueil"
      
      if @jeu.profilConnecte?() then
        
        mouvement(EventsChoixPartie.new(jeu))
      
      elsif !@jeu.profilConnecte?() then
        
        mouvement(EventsAccueil.new(jeu))
        
      else
        
        puts "Erreur: Problème booléen indiquant si un profil est connecté"
        
      end
    }
    
    @fenetre.boutonSuivant.signal_connect('clicked'){
      
      tailleGrille = @fenetre.choixTaille()
      difficulte = @fenetre.choixDifficulte()
      
      puts "> Suivant"
      
      puts "Taille de la grille = " + tailleGrille.to_s
      puts "Niveau de difficulté de l'aide: " + difficulte.to_s
      
      @jeu.creerPartie(tailleGrille, difficulte)
      
      mouvement(EventsChoixGrille.new(jeu))
    }
  end
  
end




















