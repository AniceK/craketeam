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
#require_relative 'EventsEditeur'
require './Vue/Fenetres/FenetreAccueil'
require './Vue/Dialogues/DialogueQuitter'

class EventsAccueil < Events
  
  public_class_method :new
  
  def initialize(jeu)
    
    super(jeu)
    
    @fenetre = FenetreAccueil.new()
    @fenetre.afficher()
    
    # Si aucun profil connecté
    #@fenetre.affichageSansProfil()
    
    # Si profil connecté
    @fenetre.affichageAvecProfil()
    
    
    @fenetre.boutonPartieRapide.signal_connect('clicked'){
      puts "> Choix Taille"
      
      mouvement(EventsPreparation.new(jeu))
    }
    
    @fenetre.boutonJouer.signal_connect('clicked'){
      puts "> Choix Partie"
      
      mouvement(EventsChoixPartie.new(jeu))
    }
    
    @fenetre.boutonProfil.signal_connect('clicked'){
      puts "> Profil"
      
      mouvement(EventsProfil.new(jeu))
    }
    
    @fenetre.boutonEditeur.signal_connect('clicked'){
      puts "> Éditeur"
      
      #mouvement(EventsEditeur.new(jeu))
    }
    
    @fenetre.boutonOptions.signal_connect('clicked'){
      puts "> Options"
      
      mouvement(EventsOptions.new(jeu))
    }
    
    @fenetre.boutonCredits.signal_connect('clicked'){
      puts "> Crédits"
      
      mouvement(EventsCredits.new(jeu))
    }
    
    @fenetre.boutonQuitter.signal_connect('clicked'){
      puts "> Dialogue Quitter"
      
      
      dialogue = DialogueQuitter.new()
      
      if dialogue.doitQuitter() then
        @fenetre.quitter()
      end
    }
    
    @fenetre.boutonDeconnexion.signal_connect('clicked'){
      puts "> Accueil (Déconnexion)"
      
      # Déconnecter le profil ici
      
      @fenetre.affichageSansProfil()
    }
  end
  
end