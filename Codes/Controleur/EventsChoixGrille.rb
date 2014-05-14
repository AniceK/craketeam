# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Events'
require_relative 'EventsJeu'
require_relative 'EventsChoixCreation'
require './Vue/Fenetres/FenetreChoixGrille'


#===============================================================================#
#                                                                               #
#        La classe EventsChoixGrille créé une fenêtre de choix de grille.       #
#   Elle permet au joueur de choisir une grille déjà créée par un utilisateur,  #
#              ou de commencer une toute nouvelle grille aléatoire.             #
#                                                                               #
#===============================================================================#

class EventsChoixGrille < Events
  
  public_class_method :new
  
  def initialize(jeu, position)
    
    @fenetre = FenetreChoixGrille.new()
    
    super(jeu, position)
    
    @fenetre.afficher()
    @fenetre.affichageDepart()
    
    if !@jeu.profilConnecte?() then
      
      @fenetre.affichageVisiteur()
      
    end
    
    @fenetre.boutonToutesGrilles.signal_connect('clicked'){
      
      puts "> Toutes les grilles"
      
      tailleCreation = @jeu.tailleGrille()
      
      afficheTout = true
      
      # => Renvoie un tableau de grilles ayant des variables "taille", "nom", "date"
      if listeCreations = @jeu.chargerListeGrillesExistantes(tailleCreation, afficheTout) then
      
        mouvement(EventsChoixCreation.new(@jeu, position() , listeCreations, afficheTout))
        
      else
        
        puts "Erreur: Pas de créations"
        @fenetre.affichageAucuneGrille()
        
      end
    }
    
    @fenetre.boutonGrillesPerso.signal_connect('clicked'){
      
      puts "> Grilles perso"
      
      tailleCreation = @jeu.tailleGrille()
      
      afficheTout = false
      
      # => Renvoie un tableau de grilles ayant des variables "taille", "nom", "date"
      if listeCreations = @jeu.chargerListeGrillesExistantes(tailleCreation, afficheTout) then
      
        puts "Liste des créations : " + listeCreations.to_s
        mouvement(EventsChoixCreation.new(@jeu, position() , listeCreations, afficheTout))
        
      else
        
        puts "Erreur: Pas de créations"
        @fenetre.affichageAucuneGrillePerso()
        
      end
    }
    
    @fenetre.boutonGrilleAleatoire.signal_connect('clicked'){
      
      puts "> Grille aleatoire"
      
      jeu.genererAleatoirementGrille()
      mouvement(EventsJeu.new(@jeu, position() ))
    }
    
    @fenetre.boutonPrecedent.signal_connect('clicked'){
      
      puts "> Accueil"
      
      mouvement(EventsPreparation.new(@jeu, position() ))
    }
  end
  
end













