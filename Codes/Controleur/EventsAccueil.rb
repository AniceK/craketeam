# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require './Controleur/Events.rb'
require './Controleur/EventsCredits.rb'
require './Controleur/EventsOptions.rb'
require './Controleur/EventsProfil.rb'
require './Controleur/EventsChoixTaille.rb'
require './Vue/Fenetres/FenetreAccueil.rb'
require './Vue/Dialogues/DialogueQuitter.rb'

class EventsAccueil < Events
  
  public_class_method :new
  
  def initialize(jeu)
    
    super(jeu)
    
    @fenetre = FenetreAccueil.new()
    @fenetre.afficher()
    
    
    @fenetre.boutonPartieRapide.signal_connect('clicked'){
      puts "> Choix Taille"
      
      mouvement(EventsChoixTaille.new(jeu))
    }
    
    @fenetre.boutonProfil.signal_connect('clicked'){
      puts "> Profil"
      
      mouvement(EventsProfil.new(jeu))
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
      puts "> Quitter"
      
      
      dialogue = DialogueQuitter.new()
      
      if dialogue.doitQuitter() then
        @fenetre.quitter()
      end
    }
  end
  
end