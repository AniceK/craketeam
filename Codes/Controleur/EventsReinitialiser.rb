# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require 'gtk2'

require_relative 'Events'
require_relative 'EventsOptions'
require './Vue/Fenetres/FenetreReinitialiser'
require './Vue/Dialogues/DialogueReinitialiser'

class EventsReinitialiser < Events
  
  public_class_method :new
  
  def initialize(jeu, position)
    
    @fenetre = FenetreReinitialiser.new()
    
    super(jeu, position)
    
    # Affiche tout sauf le texte d'informations
    @fenetre.afficher()
    @fenetre.affichageDepart()
    
    # Efface toutes les grilles enregistrées
    @fenetre.boutonViderGrilles.signal_connect('clicked'){
      
      puts ("> Vider Grilles")
        
      dialog = DialogueReinitialiser.new(@fenetre.widget())
      
      if dialog.doitReinitialiser then
      
        @jeu.viderGrilles()
        @fenetre.affichageInfos("Les grilles du profil ont été effacées")
        
      elsif !dialog.doitReinitialiser then
        
        @fenetre.affichageInfos("Aucune grille n'a été effacée")
        
      else
        
        puts "[EventsReinitialiser]Erreur: Mauvaise réception de la réponse du popup de confirmation de réinitialisation"
        
      end
    }
    
    # Efface toutes les sauvegardes enregistrées
    @fenetre.boutonViderSauvegardes.signal_connect('clicked'){
      
      puts ("> Vider Sauvegardes")
     
      dialog = DialogueReinitialiser.new(@fenetre.widget())
      
      if dialog.doitReinitialiser then
      
        @jeu.viderParties()
        @fenetre.affichageInfos("Les sauvegardes du profil ont été effacées")
        
      elsif !dialog.doitReinitialiser then
        
        @fenetre.affichageInfos("Aucune sauvegarde n'a été effacée")
        
      else
        
        puts "[EventsReinitialiser]Erreur: Mauvaise réception de la réponse du popup de confirmation de réinitialisation"
        
      end
        
    }
    
    # Efface toutes les données enregistrées
    @fenetre.boutonViderTout.signal_connect('clicked'){
      
      puts ("> Réinitialisatioin totale")
        
      dialog = DialogueReinitialiser.new(@fenetre.widget())
      
      if dialog.doitReinitialiser then
      
        @fenetre.affichageInfos("Toutes les données ont été effacées")
        @jeu.deconnecter()
        @jeu.viderTout()
        mouvement(EventsAccueil.new(@jeu, position() ))
        
      elsif !dialog.doitReinitialiser then
        
        @fenetre.affichageInfos("Aucune donnée n'a été effacée")
        
      else
        
        puts "[EventsReinitialiser]Erreur: Mauvaise réception de la réponse du popup de confirmation de réinitialisation"
        
      end
    }
    
    # Revient à la fenêtre d'options
    @fenetre.boutonPrecedent.signal_connect('clicked'){
      puts "> Options"
      
      mouvement(EventsOptions.new(@jeu, position() ))
    }
  end
  
end