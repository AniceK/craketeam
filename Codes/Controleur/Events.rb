# encoding: utf-8
#! /usr/bin/env ruby
##
# Auteur CrakeTeam
# Version 0.1 : Date : Mon Mar 17 09:42 2013
#

require './Modele/Profil'
require './Modele/Jeu'


#===============================================================================#
#                                                                               #
#               La classe Events n'est pas instantiable.                        #
#  Elle permet de créer des évènements qui controleront l'interface graphique   #
#                                                                               #
#===============================================================================#

class Events
  
  @jeu
  # Contient le jeu (modèle) qui est lié au Controleur
  @fenetre
  # Contient la fenêtre courante
  
  # Les attributs sont en lecture seul
  attr_reader :jeu,
              :fenetre
  
  # On ne peut pas instancier la classe Events
  private_class_method :new
  
  # On transmet les données du jeu entre les évènements
  def initialize(jeu, position)
    
    @jeu = jeu
    
    if position != Gtk::Window::POS_CENTER then
      
      self.bouger(position)
      
    else
      
      @fenetre.widget.set_window_position(Gtk::Window::POS_CENTER)
      
    end
    
    
    if @jeu.profilConnecte?() then
      
      pseudoTitre = jeu.profil.nom
      
    elsif !@jeu.profilConnecte?() then
      
      pseudoTitre = "Visiteur"
      
    else
      
      puts "Erreur: Problème de détection du profil"
      
    end
    
    @fenetre.titre(pseudoTitre)
    
  end

  # On change l'évènement à prendre en compte pour afficher une nouvelle fenêtre
  def mouvement(events)
    
    @fenetre.cacher()
    @jeu.ajouterEvenement(events)
  end
  
  # Récupère la position de la fenêtre actuelle (Permet aux fenêtre de se suivre)
  def position()
    
    return @fenetre.position()
  end
  
  # Déplace la fenêtre à la position donnée en argument (Permet aux fenêtre de se suivre)
  def bouger(position)
    
    @fenetre.move(position[0], position[1])
  end
  
end

















