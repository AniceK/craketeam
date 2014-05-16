# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Events'
require_relative 'EventsChoixGrille'
require_relative 'EventsJeu'
require './Vue/Fenetres/FenetreChoixCreation'



class EventsChoixCreation < Events
  
  public_class_method :new
  
  def initialize(jeu, position, listeCreations, afficheTout)
    
    @fenetre = FenetreChoixCreation.new(listeCreations)
    
    super(jeu, position)
    
    
    @fenetre.afficher()
    @fenetre.affichageDepart()
    
    
    @fenetre.boutonPrecedent.signal_connect('clicked'){
      
      puts "> Choix Grille"
      mouvement(EventsChoixGrille.new(@jeu, position() ))
    }
    
    # Implémentation non terminée
    @fenetre.boutonSupprimer.signal_connect('clicked'){
      
    #  nomCreation = @fenetre.nomChoixCreation()
    #  tailleCreation = @fenetre.tailleChoixCreation()
    #  
    #  if @jeu.supprimerGrille(nomCreation, tailleCreation) then
    #    
    #    puts "> Suppression Création"
    #    
    #  elsif !@jeu.supprimerGrille(nomCreation, tailleCreation) then
    #    
    #    puts "[EventsChoixSauvegardes]Erreur: Problème suppression création"
    #    
    #  else
    #    
    #    puts "[EventsChoixSauvegardes]Erreur: Problème suppression création"
    #    
    #  end
        
        
    }
    
    @fenetre.boutonSuivant.signal_connect('clicked'){
      
      
      if (nomCreation = @fenetre.choixCreation() ) != nil then
        
        tailleCreation = @jeu.tailleGrille()
        
        puts "> Suivant (Creation: " + nomCreation + ")"
        
        @jeu.chargerGrille(nomCreation, tailleCreation)
        
        mouvement(EventsJeu.new(@jeu, position() ))
        
      elsif @fenetre.choixCreation() == nil then 
        
        @fenetre.affichageAucuneGrilleSelectionnee()
        
      else
        
        puts "[EventsChoixCreation]Erreur: Mauvaise gestion du choix de création"
        
      end
    }
  end
  
end





