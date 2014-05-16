# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Events'
require_relative 'EventsJeu'
require './Vue/Fenetres/FenetreChoixSauvegarde'


class EventsChoixSauvegarde < Events
  
  public_class_method :new
  
  def initialize(jeu, position, listeSauvegardes)
    
    @fenetre = FenetreChoixSauvegarde.new(listeSauvegardes)
    
    super(jeu, position)
    
    
    @fenetre.afficher()
    
    
    @fenetre.boutonPrecedent.signal_connect('clicked'){
      
      puts "> Choix Partie"
      mouvement(EventsChoixPartie.new(@jeu, position() ))
    }
    
    # Implémentation non terminée
    @fenetre.boutonSupprimer.signal_connect('clicked'){
    #  
    #  nomSauvegarde = @fenetre.choixSauvegarde()
    #  
    #  if @jeu.supprimmerPartie(nomSauvegarde) then
    #    
    #    puts "> Suppression Sauvegarde"
    #    
    #  elsif !@jeu.supprimmerPartie(nomSauvegarde) then
    #    
    #    puts "[EventsChoixSauvegardes]Erreur: Problème suppression sauvegarde"
    #    
    #  else
    #    
    #    puts "[EventsChoixSauvegardes]Erreur: Problème suppression sauvegarde"
    #    
    #  end
    #    
    #    
    }

    @fenetre.boutonSuivant.signal_connect('clicked'){
      
      nomSauvegarde = @fenetre.choixSauvegarde()
      
      puts "> Suivant (Sauvegarde: " + nomSauvegarde + ")"
      
      if @jeu.chargerPartie(nomSauvegarde) then
      
        mouvement(EventsJeu.new(@jeu, position() ))
        
      else
        
        puts "Erreur: Sauvegarde non chargée"
        
      end
    }
  end
  
end