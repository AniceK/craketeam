# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Events'
require_relative 'EventsReinitialiser'
require_relative 'EventsAfficherScores'
require './Vue/Fenetres/FenetreOptions'

class EventsOptions < Events
  
  public_class_method :new
  
  def initialize(jeu, position)
    
    @fenetre = FenetreOptions.new()
    
    super(jeu, position)
    
    @fenetre.afficher()
    
    if @jeu.profilConnecte?() then
      
      @fenetre.affichageProfil()
      
    elsif !@jeu.profilConnecte?() then
      
      @fenetre.affichageSimple()
      
    else
      
      puts "[EventsOptions]Erreur: Test si profil connecté"
      
    end
    
    @fenetre.boutonReinitialiser.signal_connect('clicked'){
      
      puts ("> Réinitialiser")
      
      self.mouvement(EventsReinitialiser.new(@jeu, position() ))
    }
    
    @fenetre.boutonAfficherScores.signal_connect('clicked'){
      
      puts ("> High Score")
      
      
      # Liste temporaire à supprimer après l'implémentation de @jeu.chargerScores()
      
     #####################################################
     #                                                   #
     # listeTemporaire = Array.new()                     #
     # listeTemporaire[0] = [5, "Rémi", 1000]            #
     # listeTemporaire[1] = [5, "Colas", 300]            #
     # listeTemporaire[2] = [10, "Kévin", 50000]         #
     # listeTemporaire[3] = [10, "Erwan", 99999999]      #
     # listeTemporaire[4] = [25, "Anice", 69]            #
     # listeTemporaire[5] = [25, "Coco", 19812]          #
     # listeTemporaire[6] = [20, "Jacoboni", 1]          #
     # listeTemporaire[7] = [15, "Despres", 1]           #
     #                                                   #
     #####################################################
      
      
      if listeScores = jeu.afficherScores() then # Renvoie la liste des scores [taille, pseudo, score]
         
        self.mouvement(EventsAfficherScores.new(@jeu, position(), listeScores))
        
      elsif @jeu.afficherScores() == nil then
        
        @fenetre.affichageInfos("Il n'y a aucun score à afficher")
        
      else
        
        puts "[EventsOptions]Erreur: Mauvaise gestion chargement des scores"
        
      end
    }
    
    @fenetre.boutonPrecedent.signal_connect('clicked'){
      puts "> Accueil"
      
      mouvement(EventsAccueil.new(@jeu, position() ))
    }
  end
  
end