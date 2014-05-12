# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Events'
require_relative 'EventsCredits'
require_relative 'EventsOptions'
require_relative 'EventsProfil'
require_relative 'EventsPreparation'
require_relative 'EventsChoixPartie'
require_relative 'EventsTailleEditeur'
#require_relative 'EventsEditeur'
require './Vue/Fenetres/FenetreAccueil'
require './Vue/Dialogues/DialogueQuitter'

class EventsAccueil < Events
  
  public_class_method :new
  
  def initialize(jeu)
    
    super(jeu)
    
    @fenetre = FenetreAccueil.new()
    @fenetre.afficher()
    #@fenetre.move(@jeu.positionX(), @jeu.positionY()) # => @jeu.positionX() renvoie position[0] et Y -> position[1]
    
    if @jeu.profilConnecte?() then
      
      @fenetre.affichageAvecProfil()
      
    elsif !@jeu.profilConnecte?() then
      
      @fenetre.affichageSansProfil()
      
    else
      puts "Erreur test si profil connecté"
    end
    
    @fenetre.boutonPartieRapide.signal_connect('clicked'){
      puts "> Choix Taille"
      
      mouvement(EventsPreparation.new(@jeu))
    }
    
    @fenetre.boutonJouer.signal_connect('clicked'){
      puts "> Choix Partie"
      
      mouvement(EventsChoixPartie.new(@jeu))
    }
    
    @fenetre.boutonProfil.signal_connect('clicked'){
      puts "> Profil"
      
      mouvement(EventsProfil.new(@jeu))
    }
    
    @fenetre.boutonEditeur.signal_connect('clicked'){
      puts "> Éditeur"
      
      mouvement(EventsTailleEditeur.new(@jeu))
    }
    
    @fenetre.boutonOptions.signal_connect('clicked'){
      puts "> Options"
      
      mouvement(EventsOptions.new(@jeu))
    }
    
    @fenetre.boutonCredits.signal_connect('clicked'){
      puts "> Crédits"
      
      mouvement(EventsCredits.new(@jeu))
    }
    
    @fenetre.boutonQuitter.signal_connect('clicked'){
      puts "> Dialogue Quitter"
      
      
      dialogue = DialogueQuitter.new(@fenetre.widget())
      
      if dialogue.doitQuitter then
        
        puts "> Quitter"
        @fenetre.quitter()
        
      else
        
        puts "> Accueil"
      end
    }
    
    @fenetre.boutonDeconnexion.signal_connect('clicked'){
      puts "> Accueil (Déconnexion)"
      
      @jeu.deconnecter()
      
      @fenetre.affichageSansProfil()
    }
  end
  
end